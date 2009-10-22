module VER
  module Methods
    module Move
      def go_char_left(count = 1)
        mark_set :insert, "insert - #{count} char"
      end

      def go_char_right(count = 1)
        mark_set :insert, "insert + #{count} char"
      end

      def go_beginning_of_line
        mark_set :insert, 'insert display linestart'
      end

      def go_end_of_line
        mark_set :insert, 'insert display lineend'
      end

      def go_line(number = 0)
        mark_set :insert, "#{number}.0"
      end

      def go_end_of_file
        mark_set :insert, :end
      end

      def virtual_movement(name, count = 1)
        pos = index(:insert)
        __send__(name, count)
        mark = index(:insert)
        mark_set :insert, pos
        return [pos, mark].sort
      end

      # HACK: but it's just too good to do it manually

      def go_page_up(count = 1)
        mark_set :insert, tk_prev_page_pos(count)
      end

      def go_page_down(count = 1)
        mark_set :insert, tk_next_page_pos(count)
      end

      def go_line_up(count = 1)
        mark_set :insert, tk_prev_line_pos(count)
      end

      def go_line_down(count = 1)
        mark_set :insert, tk_next_line_pos(count)
      end

      def go_word_right(count = 1)
        count.times do
          mark_set :insert, tk_next_word_pos('insert')
        end
      end

      def go_word_left(count = 1)
        count.times do
          mark_set :insert, tk_prev_word_pos('insert')
        end
      end

      private

      def tk_prev_word_pos(start)
        Tk.tk_call('tk::TextPrevPos', path, start, 'tcl_startOfPreviousWord')
      end

      def tk_next_word_pos(start)
        Tk.tk_call('tk::TextNextWord', path, start)
      end

      def tk_prev_line_pos(count)
        Tk.tk_call('tk::TextUpDownLine', path, -count.abs)
      end

      def tk_next_line_pos(count)
        Tk.tk_call('tk::TextUpDownLine', path, count)
      end

      def tk_prev_page_pos(count)
        Tk.tk_call('tk::TextScrollPages', path, -count.abs)
      end

      def tk_next_page_pos(count)
        Tk.tk_call('tk::TextScrollPages', path, count)
      end
    end
  end
end