module VER
  module Methods
    module Move
      GO_MATCHING_RIGHT = {
        '(' => ')',
        '{' => '}',
        '[' => ']',
        '<' => '>',
      }
      GO_MATCHING_LEFT = GO_MATCHING_RIGHT.invert

      def matching_brace(count = nil)
        opening = get(:insert)

        if closing = GO_MATCHING_RIGHT[opening]
          search = method(:search_all)
          level = 1
          start = 'insert + 1 chars'
        elsif closing = GO_MATCHING_LEFT[opening]
          search = method(:rsearch_all)
          level = 1
          start = 'insert'
        else
          return
        end

        needle = Regexp.union(opening, closing)

        search.call(needle, start) do |match, pos, from|
          if match == opening
            level += 1
          elsif match == closing
            level -= 1
          end

          if level < 1
            mark_set :insert, pos
            return
          end
        end
      end

      # Move cursor +count+ characters left.
      def backward_char(count = 1)
        mark_set :insert, "insert - #{count} displaychars"
      end

      # Move cursor +count+ characters right.
      def forward_char(count = 1)
        mark_set :insert, "insert + #{count} displaychars"
      end

      # Move to the beginning of the line where insert mark is located.
      #
      # With +count+ it will move to the beginning of the display line, which
      # takes line wraps into account.
      def beginning_of_line(count = nil)
        if count
          mark_set :insert, 'insert display linestart'
        else
          mark_set :insert, 'insert linestart'
        end
      end

      # Move to the end of the line where insert mark is located.
      #
      # With +count+ it moves to the end of the display line, so when there is
      # a line wrap it will move to the place where the line wraps instead of the
      # real end of the line.
      def end_of_line(count = nil)
        if count
          mark_set :insert, 'insert display lineend'
        else
          mark_set :insert, 'insert lineend'
        end
      end

      def eol_then_insert_mode(count = nil)
        end_of_line(count)
        start_insert_mode
      end

      def sol_then_insert_mode(count = nil)
        beginning_of_line(count)
        start_insert_mode
      end

      def forward_char_then_insert_mode(count = 1)
        forward_char(count)
        start_insert_mode
      end

      def go_line(number = 0)
        mark_set :insert, "#{number}.0"
      end

      def end_of_file(count = nil)
        if count
          mark_set :insert, "#{count}.0"
        else
          mark_set :insert, :end
        end
      end

      def virtual_movement(name, count = 1)
        pos = index(:insert)
        __send__(name, count)
        mark = index(:insert)
        mark_set :insert, pos
        return [pos, mark].sort
      rescue => ex
        VER.error(ex)
      end

      # HACK: but it's just too good to do it manually

      def page_up(count = 1)
        mark_set :insert, tk_prev_page_pos(count)
      end

      def page_down(count = 1)
        mark_set :insert, tk_next_page_pos(count)
      end

      def previous_line(count = 1)
        mark_set :insert, tk_prev_line_pos(count)
      end

      def next_line(count = 1)
        mark_set :insert, tk_next_line_pos(count)
      end

      def forward_scroll(count = 1)
        count_abs = count.abs
        yview_scroll(count_abs, :units)
        next_line(count_abs)
      end

      def backward_scroll(count = 1)
        count_abs = count.abs
        yview_scroll(-count_abs, :units)
        previous_line(count_abs)
      end

      def forward_word(count = 1)
        forward_jump(count, &method(:word_char_type))
      end

      def forward_chunk(count = 1)
        forward_jump(count, &method(:chunk_char_type))
      end

      def word_right_end(count = 1)
        count.times do
          mark_set :insert, tk_next_word_pos_end('insert')
        end
      end

      def backward_word(count = 1)
        backward_jump(count, &method(:word_char_type))
      end

      def backward_chunk(count = 1)
        backward_jump(count, &method(:chunk_char_type))
      end

      private

      def word_char_type(char)
        case char
        when /\w/; :word
        when /\S/; :special
        when /\s/; :space
        else; raise "You cannot get here"
        end
      end

      def chunk_char_type(char)
        case char
        when /\S/; :nonspace
        when /\s/; :space
        else; raise "You cannot get here"
        end
      end

      def forward_jump(count)
        count.times do
          original_type = type = yield(get(:insert))
          changed = 0

          begin
            original_pos = index(:insert)
            execute :mark, :set, :insert, 'insert + 1 chars'
            break if  original_pos == index(:insert)

            type = yield(get(:insert))
            changed += 1 if type != original_type
            original_type = type
          end until changed > 0 && type != :space
        end

        Tk::Event.generate(self, '<<Movement>>')
      rescue => ex
        VER.error(ex)
      end

      def backward_jump(count = 1)
        count.times do
          original_type = type = yield(get(:insert))
          changed = 0

          begin
            original_pos = index(:insert)
            execute :mark, :set, :insert, 'insert - 1 chars'
            break if index(:insert) == original_pos

            type = yield(get(:insert))
            changed += 1 if type != original_type
            original_type = type
          end until changed > 0 && type != :space

          type = yield(get('insert - 1 chars'))

          while type == original_type
            original_pos = index(:insert)
            execute :mark, :set, :insert, 'insert - 1 chars'
            break if index(:insert) == original_pos

            type = yield(get('insert - 1 chars'))
          end
        end

        Tk::Event.generate(self, '<<Movement>>')
      rescue => ex
        VER.error(ex)
      end

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
