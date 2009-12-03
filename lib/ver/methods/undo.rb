module VER
  module Methods
    module Undo
      def redo
        undoer.redo
      end

      def undo
        undoer.undo
      end

      private

      def undo_record(&block)
        undoer.record_multi(&block)
      end

      def undo_separator
        undoer.separate!
      end
    end
  end
end
