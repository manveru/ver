module VER
  module Methods
    module Delete
      def delete_char_left
        delete 'insert - 1 char'
      end

      def delete_char_right
        delete 'insert'
      end

      def delete_word_right
        delete_right_until Text::MATCH_WORD_RIGHT
      end

      def delete_right_until(regexp)
        search_all(regexp, "insert wordend") do |match, from, to|
          delete :insert, "#{to} - 1 chars"
          return
        end

        delete :insert, 'end'
      end

      def delete_word_left
        delete_left_until Text::MATCH_WORD_LEFT
      end

      def delete_left_until(regexp)
        rsearch_all(regexp, "insert wordstart") do |match, from, to|
          delete from, :insert
          return
        end

        delete :insert, '1.0'
      end

      def delete_line
        delete 'insert linestart', 'insert lineend + 1 char'
      end

      def delete_to_eol
        delete 'insert', 'insert lineend'
      end

      def delete_to_eol_then_insert
        delete_to_eol
        start_insert_mode
      end

      def delete_char_right_then_insert
        delete_char_right
        start_insert_mode
      end

      def delete_char_left_then_insert
        delete_char_left
        start_insert_mode
      end

      def delete_word_right_then_insert
        delete_word_right
        start_insert_mode
      end

      def delete_word_left_then_insert
        delete_word_left
        start_insert_mode
      end
    end
  end
end