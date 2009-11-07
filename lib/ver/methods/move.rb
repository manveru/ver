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

      def go_word_right_end(count = 1)
        count.times do
          mark_set :insert, tk_next_word_pos_end('insert')
        end
      end

      def go_word_left(count = 1)
        count.times do
          mark_set :insert, tk_prev_word_pos('insert')
        end
      end

      private

      def tk_prev_word_pos(start)
        Tk.execute('tk::TextPrevPos', tk_pathname, start, 'tcl_startOfPreviousWord').to_s
      end

      def tk_next_word_pos(start)
        Tk.execute('tk::TextNextPos', tk_pathname, start, 'tcl_startOfNextWord').to_s
      end

      def tk_next_word_pos_end(start)
        Tk.execute('tk::TextNextWord', tk_pathname, start).to_s
      end

      def tk_prev_line_pos(count)
        Tk.execute('tk::TextUpDownLine', tk_pathname, -count.abs).to_s
      end

      def tk_next_line_pos(count)
        Tk.execute('tk::TextUpDownLine', tk_pathname, count).to_s
      end

      def tk_prev_page_pos(count)
        Tk.execute('tk::TextScrollPages', tk_pathname, -count.abs).to_s
      end

      def tk_next_page_pos(count)
        Tk.execute('tk::TextScrollPages', tk_pathname, count).to_s
      end
    end
  end
end
