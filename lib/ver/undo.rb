module VER
  module Undo
    # The Tree keeps track of the current Record and creates new records.
    #
    # It maintains a pointer to the widget and the current record in the tree.
    # The current record is the record that was last applied.
    #
    # When a record is undone:
    # If there is a parent, it becomes the new current record.
    # If there is no parent, it stays the current record, only flagged as
    # unapplied.
    # it's parent (if there is one), becomes the new
    # current record.
    #
    # When a record is redone, it's current child (if there is one), becomes the
    # new current record.
    #
    # The Tree doesn't have a maximum depth at the moment, but this will be
    # added, when old records are pruned, only the record at depth+1 that is
    # current stays.
    #
    # Eventually we have to separate records and undo/redo stepping.
    # Some operations involve more than one record, but should be undone/redone
    # together.
    # It would also be handy if these operations could be identified
    # automagically (like multiple operations within one record block).
    class Tree < Struct.new(:widget, :applied, :pending, :stack, :recording)
      def initialize(widget)
        self.widget = widget
        self.stack = []
      end

      def record_multi
        AutoSeparator.new self do |auto_separator|
          yield auto_separator
        end

        compact!
      end

      def record
        if recording
          stack << Proc.new
        else
          self.recording = true
          current = Record.new(self, widget, applied)

          yield current

          applied.next = current if applied = self.applied

          self.applied = current
          self.applied = current
          self.pending = nil

          compact!
          self.recording = false

          if pending = stack.shift
            record(&pending)
          end
        end
      end

      # Undo last applied change so it becomes the next pending change.
      # Parent of the applied change becomes the next applied change.
      def undo
        while applied = self.applied
          applied.undo

          self.pending = applied
          self.applied = applied = applied.parent

          break if applied && applied.separator
        end
      end

      # Redo pending change so it becomes the new applied change.
      # If the pending change has a next child, it becomes the new pending one.
      def redo
        while pending = self.pending
          pending.redo

          self.applied = pending
          self.pending = pending.next

          break if pending && pending.separator
        end
      end

      # Join previous applied changes that have only one child and that modify
      # data consecutive.
      # This rewrites already applied history only.
      def compact!
        return unless applied
        applied.compact!
        self.pending = applied.next
      end

      def separate!
        applied.separator = true if applied
      end
    end # Tree

    class AutoSeparator < Struct.new(:tree, :records)
      def initialize(tree)
        self.tree = tree
        self.records = []

        yield(self) if block_given?

        records.last.separator = true if records.any?
      end

      def insert(*args)
        tree.record do |record|
          record.insert(*args)
          records << record
        end
      end

      def replace(*args)
        tree.record do |record|
          record.replace(*args)
          records << record
        end
      end

      def delete(*args)
        tree.record do |record|
          record.delete(*args)
          records << record
        end
      end
    end # AutoSeparator

    # Every Record is responsible for one change that it can apply or undo.
    # There is only a very limited set of methods for modifications, as some of
    # the destructive String methods in Ruby can have unpredictable results.
    # In order to undo a change, we have to predict what the change will do
    # before it happens to avoid expensive diff algorithms.
    #
    # A Record has one parent and a number of childs.
    # If there are any childs, one of them is called current, and is the child
    # that was last active, this way we can provide an intuitive way of choosing
    # a child record to apply when a user wants to redo an undone change.
    #
    # Record has a direct pointer to the data in the tree, since it has to know
    # about nothing else.
    #
    # Apart from that, Record also knows the time when it was created, this way
    # you can move forward and backward in time.
    #
    # Revisions only keep the data necessary to undo/redo a change, not the whole
    # data that was modified, that way it can keep overall memory-usage to a
    # minimum.
    #
    # The applied property indicates whether or not this change has been applied
    # already.
    class Record < Struct.new(:tree, :widget, :parent, :ctime, :childs,
                              :applied, :undo_info, :redo_info, :separator)

      def initialize(tree, widget, parent = nil)
        self.tree = tree
        self.widget = widget
        self.parent = parent
        self.ctime = Time.now
        self.childs = []
        self.applied = false
        self.separator = false
      end

      def insert(pos, string, tag = Tk::None)
        pos = index(pos)

        widget.execute_only(:insert, pos, string, tag)
        widget.touch!(pos, "#{pos} + #{string.size} chars")

        self.redo_info = [:insert, pos, string, tag]
        self.undo_info = [pos, index("#{pos} + #{string.size} chars"), '']
        self.applied = true
        pos
      end

      def replace(from, to, string, tag = Tk::None)
        from, to = indices(from, to)

        data = widget.get(from, to)
        widget.execute_only(:replace, from, to, string, tag)
        widget.touch!(from, to)

        self.redo_info = [:replace, from, to, string, tag]
        self.undo_info = [from, index("#{from} + #{string.size} chars"), data]
        self.applied = true
        from
      end

      def delete(*indices)
        case indices.size
        when 0
          nil
        when 1 # pad to two
          index = index(*indices)
          delete(index, index + '1 chars')
        when 2
          first, last = indices(*indices)

          data = widget.get(first, last)
          widget.execute_only(:delete, first, last)
          widget.touch!(first, last)

          self.redo_info = [:delete, first, last]
          self.undo_info = [first, first, data]
          self.applied = true
          first
        else # sanitize and chunk into deletes
          sanitize(*indices).map do |first, last|
            tree.record { |rec| rec.delete(first, last) }
          end.last
        end
      end

      def undo
        return unless undo_info && applied

        from, to, string = undo_info
        widget.execute_only(:replace, from, to, string)
        widget.touch!(from, to)
        widget.mark_set(:insert, from)

        self.applied = false
      end

      def redo
        return unless redo_info && !applied
        pos = send(*redo_info)
        widget.mark_set(:insert, pos)
      end

      def compact!
        return if separator
        return unless parent = self.parent

        pundo_from, pundo_to, pundo_string = parent.undo_info
        sundo_from, sundo_to, sundo_string = undo_info

        predo_name, *predo_args = parent.redo_info
        sredo_name, *sredo_args = redo_info

        # only compact identical methods
        return unless predo_name == sredo_name

        case predo_name
        when :insert
          predo_pos, predo_string = predo_args
          sredo_pos, sredo_string = sredo_args

          # the records have to be consecutive so they can still be applied by a
          # single undo/redo
          consecutive = index("#{predo_pos} + #{predo_string.size} chars") == sredo_pos
          return parent.compact! unless consecutive

          redo_string = "#{predo_string}#{sredo_string}"
          self.redo_info = [:insert, predo_pos, redo_string]

          undo_string = "#{pundo_string}#{sundo_string}"
          self.undo_info = [pundo_from, sundo_to, undo_string]
        when :replace
          predo_from, predo_to, predo_string = predo_args
          sredo_from, sredo_to, sredo_string = sredo_args

          # the records have to be consecutive so they can still be applied by a
          # single undo/redo
          consecutive = predo_to == sredo_from
          return parent.compact! unless consecutive

          redo_string = "#{predo_string}#{sredo_string}"
          self.redo_info = [:replace, predo_from, sredo_to, undo_string]

          undo_string = "#{pundo_string}#{sundo_string}"
          self.undo_info = [pundo_from, sundo_to, undo_string]
        when :delete
          predo_from, predo_to = predo_args
          sredo_from, sredo_to = sredo_args

          consecutive = predo_to == sredo_from
          return parent.compact! unless consecutive

          self.redo_info = [:delete, predo_from, sredo_to]

          undo_string = "#{sundo_string}#{pundo_string}"
          self.undo_info = [pundo_from, sundo_to, undo_string]
        else
          return
        end

        # the parent of our parent (grandparent) becomes our parent
        self.parent = grandparent = parent.parent

        # recurse into a new compact cycle if we have a grandparent
        if grandparent
          grandparent.next = self
          compact!
        end
      end

      def next=(child)
        childs.unshift(childs.delete(child) || child)
      end

      def next
        childs.first
      end

      def applied?
        applied
      end

      def indices(*given_indices)
        given_indices.map do |index|
          index.respond_to?(:to_index) ? index.to_index : widget.index(index)
        end.sort
      end

      def index(given_index)
        if given_index.respond_to?(:to_index)
          given_index.to_index
        else
          widget.index(given_index)
        end
      end

      # Multi-index pair case requires that we prevalidate the indices and sort
      # from last to first so that deletes occur in the exact (unshifted) text.
      # It also needs to handle partial and fully overlapping ranges. We have to
      # do this with multiple passes.
      def sanitize(*indices)
        raise ArgumentError if indices.size.odd?

        # first we get the real indices
        indices = indices.map { |index| widget.index(index) }

        # pair them, to make later code easier.
        indices = indices.each_slice(2).to_a

        # then we sort the indices in increasing order
        indices = indices.sort

        # Now we eliminate ranges where end is before start.
        indices = indices.select { |st, en| st <= en }

        # And finally we merge ranges where the end is after the start of a
        # following range.
        final = []

        while rang = indices.shift
          if prev = final.last
            prev_start = prev.at(0)
            prev_end = prev.at(1)
            rang_start = rang.at(0)
            rang_end = rang.at(1)
          else
            final << rang
            next
          end

          if prev_start == rang_start
            # starts are overlapping, use longer end
            prev[1] = [prev_end, rang_end].max
          elsif prev_end >= rang_start
            # prev end is overlapping rang start, use longer end
            prev[1] = [prev_end, rang_end].max
          elsif prev_end >= rang_end
            # prev end is overlapping rang end, skip
          else
            final << rang
          end
        end

        final.reverse
      end

      def inspect
        format('#<Undo::Record sep=%p undo=%p redo=%p>', separator, undo_info, redo_info)
      end
    end # Record
  end # Undo
end # VER
