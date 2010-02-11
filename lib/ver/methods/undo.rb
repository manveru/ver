module VER
  module Methods
    # Handles most operations on {Text} that concern undo/redo.
    #
    # @see VER::Undo
    module Undo
      module_function

      # Redo +count+ changes made in the given +text+.
      def redo(text, count = text.prefix_count)
        count.times{ text.undoer.redo }
        text.pristine = false
      end

      # Undo +count+ changes made in the given +text+
      def undo(text, count = text.prefix_count)
        count.times{ text.undoer.undo }
        text.pristine = false
      end

      # Wrapper to record multiple changes to given +text+ as one change, so
      # they can be undone and redone together.
      # A user usually expects one command to correspond to one undo record,
      # except for things like replacement or input.
      # So use this wrapper when you do more than one modification inside your
      # command.
      #
      # @yieldparam [VER::Undo::AutoSeparator]
      #   proxy for delete/insert/replace methods
      def record(text, &block)
        VER.warn "Buffer is Read-only" if text.readonly
        text.undoer.record_multi(&block)
        text.pristine = false
      end

      # Insert a separator into the undo history, undo/redo apply always up to
      # the next separator.
      # Operates on the undoer of the given +text+.
      def separator(text)
        text.undoer.separate!
      end
    end # Undo
  end # Methods
end # VER
