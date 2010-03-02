module VER
  module Methods
    # Handles most operations on {Text} that concern undo/redo.
    #
    # @see VER::Undo
    module Undo
      module_function

      # Redo +count+ changes made in the given +buffer+.
      def redo(buffer, count = buffer.prefix_count)
        count.times{ buffer.redo }
      end

      # Undo +count+ changes made in the given +buffer+
      def undo(buffer, count = buffer.prefix_count)
        count.times{ buffer.undo }
      end

      # Wrapper to record multiple changes to given +buffer+ as one change, so
      # they can be undone and redone together.
      # A user usually expects one command to correspond to one undo record,
      # except for things like replacement or input.
      # So use this wrapper when you do more than one modification inside your
      # command.
      #
      # @yieldparam [VER::Undo::AutoSeparator]
      #   proxy for delete/insert/replace methods
      def record(buffer, &block)
        buffer.undo_record(&block)
      end

      # Insert a separator into the undo history, undo/redo apply always up to
      # the next separator.
      # Operates on the undoer of the given +buffer+.
      def separator(buffer)
        buffer.undoer.separate!
      end
    end # Undo
  end # Methods
end # VER
