module VER
  module Methods
    module Move
      def go_char_left(count = 1)
        mark_set :insert, "insert - #{count} char"
      end

      def go_char_right(count = 1)
        mark_set :insert, "insert + #{count} char"
      end

      def go_line_up(count = 1)
        mark_set :insert, "insert - #{count} line"
      end

      def go_line_down(count = 1)
        mark_set :insert, "insert + #{count} line"
      end

      def go_word_left
        go_left_until Text::MATCH_WORD_LEFT
      end

      def go_left_until(regexp)
        rsearch_all(regexp, "insert wordstart") do |match, from, to|
          mark_set :insert, from
          return
        end

        mark_set :insert, '1.0'
      end

      def go_word_right
        go_right_until Text::MATCH_WORD_RIGHT
      end

      def go_chunk_right
        go_right_until(/\b\S/)
      end

      def go_right_until(regexp)
        search_all(regexp, "insert wordend") do |match, from, to|
          mark_set :insert, "#{to} - 1 chars"
          return
        end

        mark_set :insert, 'end'
      end

      def go_beginning_of_line
        mark_set :insert, 'insert linestart'
      end

      def go_end_of_line
        mark_set :insert, 'insert lineend'
      end

      def go_line(number = 0)
        mark_set :insert, "#{number}.0"
      end

      def go_end_of_file
        mark_set :insert, :end
      end

      def go_page_up
        height = winfo_height
        linespace = cget(:font).metrics(:linespace)
        diff = height / linespace
        diff -= 2 if diff > 2

        mark_set :insert, "insert - #{diff} line"
        see :insert
      end

      def go_page_down
        height = winfo_height
        linespace = cget(:font).metrics(:linespace)
        diff = height / linespace
        diff -= 2 if diff > 2

        mark_set :insert, "insert + #{diff} line"
        see :insert
      end
    end
  end
end
