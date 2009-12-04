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
    class Tree < Struct.new(:widget, :applied, :pending)
      def record_multi
        AutoSeparator.new self do |auto_separator|
          yield auto_separator
        end

        compact!
      end

      def record
        current = Record.new(widget, applied)

        yield current

        applied.next = current if applied = self.applied

        self.applied = current
        self.applied = current
        self.pending = nil
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
    end

    class AutoSeparator < Struct.new(:tree, :records)
      def initialize(tree)
        self.tree = tree
        self.records = []

        yield(self) if block_given?

        records.last.separator = true
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
    end

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
    class Record < Struct.new(:widget, :parent, :ctime, :childs, :applied,
                              :undo_info, :redo_info, :separator)

      def initialize(widget, parent = nil)
        self.widget, self.parent = widget, parent
        self.ctime = Time.now
        self.childs = []
        self.applied = false
        self.separator = false
      end

      def insert(pos, string)
        pos = widget.index(pos) unless pos.respond_to?(:to_index)

        widget.execute_only(:insert, pos, string)
        widget.touch!(pos)

        self.redo_info = [:insert, pos, string]
        self.undo_info = [pos, pos + string.size, '']
        self.applied = true
      end

      def replace(from, to, string)
        from = widget.index(from) unless from.respond_to?(:to_index)
        to = widget.index(to) unless to.respond_to?(:to_index)

        data = widget.get(from, to)
        widget.execute_only(:replace, from, to, string)
        widget.touch!(*from.upto(to))

        self.redo_info = [:replace, from, to, string]
        self.undo_info = [from, from + string.size, data]
        self.applied = true
      end

      def delete(from, to)
        from = widget.index(from) unless from.respond_to?(:to_index)
        to = widget.index(to) unless to.respond_to?(:to_index)

        data = widget.get(from, to)
        widget.execute_only(:delete, from, to)
        widget.touch!(*from.upto(to))

        self.redo_info = [:delete, from, to]
        self.undo_info = [from, from, data]
        self.applied = true
      end

      def undo
        return unless undo_info && applied

        from, to, string = undo_info
        widget.execute_only(:replace, from, to, string)

        self.applied = false
      end

      def redo
        return unless redo_info && !applied
        send(*redo_info)
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
          consecutive = (predo_pos + predo_string.size) == sredo_pos
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

      def inspect
        "#<Undo::Record sep=%p undo=%p redo=%p>" % [separator, undo_info, redo_info]
      end
    end
  end
end
