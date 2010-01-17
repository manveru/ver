module VER::Methods
  module Undo
    class << self
      def redo(text, count = 1)
        count.times{ text.undoer.redo }
        text.pristine = false
      end

      def undo(text, count = 1)
        count.times{ text.undoer.undo }
        text.pristine = false
      end

      def record(text, &block)
        text.undoer.record_multi(&block)
        text.pristine = false
      end

      def separator(text)
        text.undoer.separate!
      end
    end
  end
end
