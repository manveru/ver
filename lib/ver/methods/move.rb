module VER
  Buffer.def_delegators(:@at_insert,
    :end_of_buffer, :end_of_line, :go_line, :home_of_line, :next_char,
    :next_char, :next_chunk, :next_line, :next_page, :next_word, :next_word_end,
    :prev_char, :prev_char, :prev_chunk, :prev_line, :prev_page, :prev_word,
    :prev_word_end, :start_of_line
  )

  module Methods
    module Move
      module_function

      # Move cursor left.
      def prev_char(buffer)
        buffer.prev_char
      end

      # Move cursor right.
      def next_char(buffer)
        buffer.next_char
      end

      def next_word(buffer)
        buffer.next_word
      end

      def next_chunk(buffer)
        buffer.next_chunk
      end

      # Jump to the last character of the word the insert cursor is over currently.
      def next_word_end(buffer)
        buffer.next_word_end
      end

      def prev_word(buffer)
        buffer.prev_word
      end

      def prev_chunk(buffer)
        buffer.prev_chunk
      end

      def prev_word_end(buffer)
        buffer.prev_word_end
      end

      # Move to the beginning of the line in which insert mark is located.
      #
      # With +count+ it will move to the beginning of the display line, which
      # takes line wraps into account.
      def start_of_line(buffer)
        buffer.start_of_line
      end

      # Move to the first character of the line in which insert mark is located.
      #
      # With +count+ it will move to the linestart of the displayed, taking
      # linewraps into account.
      def home_of_line(buffer)
        buffer.home_of_line
      end

      # Move to the end of the line where insert mark is located.
      #
      # With +count+ it moves to the end of the display line, so when there is
      # a line wrap it will move to the place where the line wraps instead of the
      # real end of the line.
      def end_of_line(buffer)
        buffer.end_of_line
      end

      def go_line(buffer)
        buffer.go_line
      end

      def go_column(buffer)
        buffer.go_char
      end

      # Basically like [go_line] without arguments, but much nicer name.
      def start_of_buffer(buffer)
        buffer.start_of_buffer
      end

      def end_of_buffer(buffer)
        buffer.end_of_buffer
      end

      def end_of_sentence(buffer)
        buffer.end_of_sentence
      end

      def prev_line(buffer)
        buffer.prev_line
      end

      def next_line(buffer)
        buffer.next_line
      end

      def prefix_arg_sol(text)
        return if text.update_prefix_arg(text)
        start_of_line(text)
      end

      def matching_brace(buffer)
        if pos = buffer.matching_brace.counterpart_position
          buffer.at_insert.index = pos
        else
          VER.warn "No matching brace"
        end
      end

      def ask_go_line(buffer)
        initial = $1 if buffer.event.unicode =~ /^(\d+)$/
        question = 'Go to [line number|+lines][,column number]: '
        buffer.ask question, value: initial do |answer, action|
          case action
          when :attempt
            parse_go_line buffer, answer do |index|
              buffer.insert = index
              :abort
            end
          when :modified
            parse_go_line buffer, answer do |index|
              buffer.tag_configure(Search::TAG, Search::HIGHLIGHT)
              buffer.tag_add(Search::TAG, index, index.lineend)
              buffer.see(index)
              Tk::After.ms(3000){
                buffer.tag_remove(Search::TAG, index, index.lineend)
                buffer.at_insert.see
              }
            end
          end
        end
      end

      def parse_go_line(buffer, input)
        case input.to_s.strip
        when /^\+(\d+)(?:,(\d+))?$/
          line, char = $1.to_i, $2.to_i
          current = buffer.at_insert
          yield buffer.index("#{current.line + line}.#{char}")
        when /^(\d+)(?:,(\d+))?$/
          line, char = $1.to_i, $2.to_i
          yield buffer.index("#{line}.#{char}")
        end
      end

      def forward_scroll(buffer, count = buffer.prefix_count)
        count_abs = count.abs
        buffer.yview_scroll(count_abs, :units)
        next_line(buffer, count_abs)
      end

      def backward_scroll(buffer, count = buffer.prefix_count)
        count_abs = count.abs
        buffer.yview_scroll(-count_abs, :units)
        prev_line(buffer, count_abs)
      end

      # HACK: but it's just too good to do it manually

      def prev_page(buffer, count = buffer.prefix_count)
        buffer.insert = buffer.tk_prev_page_pos(count)
      end

      def next_page(buffer, count = buffer.prefix_count)
        buffer.insert = buffer.tk_next_page_pos(count)
      end
    end
  end
end
