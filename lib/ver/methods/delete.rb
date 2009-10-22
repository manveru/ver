module VER
  module Methods
    module Delete
      def delete_char_left
        delete 'insert - 1 char'
      end

      def delete_char_right(count = 1)
        delete 'insert'
      end

      def delete_word_right(count = 1)
        delete(*virtual_movement(:go_word_right, count))
      end

      def delete_word_left(count = 1)
        delete(*virtual_movement(:go_word_left, count))
      end

      def delete_line(count = 1)
        count.times do
          delete 'insert linestart', 'insert lineend + 1 char'
        end
      end

      def delete_to_eol(count = 1)
        count.times do
          delete 'insert', 'insert lineend'
        end
      end

      def delete_to_eol_then_insert(count = 1)
        delete_to_eol(count)
        start_insert_mode
      end

      def delete_char_right_then_insert(count = 1)
        delete_char_right(count)
        start_insert_mode
      end

      def delete_char_left_then_insert(count = 1)
        delete_char_left(count)
        start_insert_mode
      end

      def delete_word_right_then_insert(count = 1)
        delete_word_right(count)
        start_insert_mode
      end

      def delete_word_left_then_insert(count = 1)
        delete_word_left(count)
        start_insert_mode
      end
    end
  end
end