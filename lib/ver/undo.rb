module VER
  module Undo
    # The Tree keeps track of the current Record and creates new records.
    #
    # It maintains a pointer to the buffer and the current record in the tree.
    # The current record is the record that was last applied.
    #
    # When a record is undone:
    # If there is a parent, it becomes the new current record.
    # If there is no parent, it stays the current record, only flagged as unapplied.
    # it's parent (if there is one), becomes the new
    # current record.
    #
    # When a record is redone, it's current child (if there is one), becomes the
    # new current record.
    #
    # The Tree doesn't have a maximum depth at the moment, but this will be
    # added, when old records are pruned, only the record at depth+1 that is
    # current stays.
    class Tree < Struct.new(:buffer, :applied, :pending)
      def record
        current = Record.new(buffer.data, applied)

        yield current

        applied.next = current if applied = self.applied

        self.applied = current
        self.applied = current
        self.pending = nil
      end

      # Undo last applied change so it becomes the next pending change.
      # Parent of the applied change becomes the next applied change.
      def undo
        return unless applied = self.applied

        applied.undo

        self.applied = applied.parent
        self.pending = applied
      end

      # Redo pending change so it becomes the new applied change.
      # If the pending change has a next child, it becomes the new pending one.
      def redo
        return unless pending = self.pending

        pending.redo

        self.applied = pending
        self.pending = pending.next
      end

      # Join previous applied changes that have only one child and that modify
      # data consecutive.
      # This rewrites already applied history only.
      def compact!
        return unless applied
        applied.compact!
        self.pending = applied.next
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
    class Record < Struct.new(:data, :parent, :ctime, :childs, :applied,
                              :undo_info, :redo_info)

      def initialize(data, parent = nil)
        self.data, self.parent = data, parent
        self.ctime = Time.now
        self.childs = []
        self.applied = false
      end

      def insert(pos, string)
        self.redo_info = [:insert, pos, string]
        self.undo_info = [pos, string.bytesize, '']
        self.applied = true

        data.insert(pos, string)
      end

      def replace(pos, len, string)
        self.redo_info = [:replace, pos, len, string]

        if len == 0
          self.undo_info = [pos, string.bytesize, '']
        else
          self.undo_info = [pos, string.bytesize, data[pos, len]]
        end

        self.applied = true

        data[pos, len] = string
      end

      def undo
        return unless undo_info && applied

        pos, len, string = undo_info
        data[pos, len] = string

        self.applied = false
      end

      def redo
        return unless redo_info && !applied

        name, *args = redo_info

        case name
        when :insert
          insert(*args)
        when :replace
          replace(*args)
        end
      end

      def compact!
        return unless parent = self.parent

        pundo_pos, pundo_len, pundo_string = parent.undo_info
        sundo_pos, sundo_len, sundo_string = undo_info

        predo_name, *predo_args = parent.redo_info
        sredo_name, *sredo_args = redo_info

        # only compact identical methods (for now)
        return unless predo_name == sredo_name

        case predo_name
        when :insert
          predo_pos, predo_string = predo_args
          sredo_pos, sredo_string = sredo_args

          return parent.compact! unless predo_pos + 1 == sredo_pos

          redo_pos = predo_pos
          redo_string = predo_string + sredo_string
          self.redo_info = [:insert, redo_pos, redo_string]

          undo_pos = pundo_pos
          undo_len = pundo_len + sundo_len
          undo_string = pundo_string + sundo_string
          self.undo_info = [undo_pos, undo_len, undo_string]

          # the parent of our parent (grandparent) becomes our parent
          self.parent = grandparent = parent.parent

          # recurse into a new compact cycle if we have a grandparent
          if grandparent
            grandparent.next = self
            compact!
          end
        when :replace
          predo_pos, predo_len, predo_string = predo_args
          sredo_pos, sredo_len, sredo_string = sredo_args

          # the records have to be consecutive so they can still be applied by a
          # single undo/redo
          return parent.compact! unless predo_pos + 1 == sredo_pos

          redo_pos = predo_pos
          redo_len = predo_len + sredo_len
          redo_string = predo_string + sredo_string
          self.redo_info = [predo_name, redo_pos, redo_len, redo_string]

          undo_pos = pundo_pos
          undo_len = pundo_len + sundo_len
          undo_string = pundo_string + sundo_string
          self.undo_info = [undo_pos, undo_len, undo_string]

          # the parent of our parent (grandparent) becomes our parent
          self.parent = grandparent = parent.parent

          # recurse into a new compact cycle if we have a grandparent
          if grandparent
            grandparent.next = self
            compact!
          end
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
        [undo_info, redo_info].inspect
      end
    end
  end
end
