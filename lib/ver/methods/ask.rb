module VER
  module Methods
    module Ask
      include Switch, Buffer

      def up
      end

      def down
      end

      def left
        cursor.left
      end

      def right
        cursor.right
      end

      def insert_character(char)
        cursor.insert(char)
      end

      def insert_backspace
        cursor.insert_backspace
      end

      def insert_delete
        cursor.insert_delete
      end

      def stop_asking
        throw(:answer, false)
      end

      def completion
        view.try_completion
      end

      def answer_question
        input = view.input
        valid, *rest = view.block_complete

        throw(:answer, input) if valid
      end
    end
  end
end
