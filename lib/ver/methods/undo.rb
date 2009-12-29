module VER
  module Methods
    module Undo
      def redo
        undoer.redo
        @pristine = false
      end

      def undo
        undoer.undo
        @pristine = false
      end

      private

      def undo_record(&block)
        undoer.record_multi(&block)
        @pristine = false
      end

      def undo_separator
        undoer.separate!
      end
    end
  end
end
