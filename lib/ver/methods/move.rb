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
        mark_set :insert, 'insert - 1 char'
        mark_set :insert, 'insert wordstart'
      end

      def go_word_right
        mark_set :insert, 'insert + 1 char'
        mark_set :insert, 'insert wordend'
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
        height = Tk.root.winfo_height
        linespace = cget(:font).metrics(:linespace)
        diff = height / linespace

        mark_set :insert, "insert - #{diff} line"
        see :insert
      end

      def go_page_down
        height = Tk.root.winfo_height
        linespace = cget(:font).metrics(:linespace)
        diff = height / linespace

        mark_set :insert, "insert + #{diff} line"
        see :insert
      end
    end
  end
end
