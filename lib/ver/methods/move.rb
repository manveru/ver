module VER
  class Buffer
    def prefix_arg_sol
      return if update_prefix_arg
      at_insert.start_of_line
    end

    def forward_scroll(count = buffer.prefix_count)
      count_abs = count.abs
      yview_scroll(count_abs, :units)
      next_line(count_abs)
    end

    def backward_scroll(count = buffer.prefix_count)
      count_abs = count.abs
      yview_scroll(-count_abs, :units)
      prev_line(count_abs)
    end

    def ask_go_line
      initial = $1 if events.last[:unicode] =~ /^(\d+)$/

      question = 'Go to [line number|+lines][,column number]: '
      ask(question, value: initial) do |answer, action|
        case action
        when :attempt
          parse_go_line(answer) do |index|
            self.insert = index
            :abort
          end
        when :modified
          parse_go_line(answer) do |index|
            tag_configure(Methods::Search::TAG, Methods::Search::HIGHLIGHT)
            tag_add(Methods::Search::TAG, index, index.lineend)
            see(index)
            Tk::After.ms(3000){
              tag_remove(Methods::Search::TAG, index, index.lineend)
              at_insert.see
            }
          end
        end
      end
    end

    def parse_go_line(input)
      case input.to_s.strip
      when /^\+(\d+)(?:,(\d+))?$/
        line, char = $1.to_i, $2.to_i
        yield index("#{at_insert.line + line}.#{char}")
      when /^(\d+)(?:,(\d+))?$/
        line, char = $1.to_i, $2.to_i
        yield index("#{line}.#{char}")
      else
        VER.warn("Invalid [+]line[,char]: %p" % [input])
      end
    end

    def_delegators(:@at_insert,
      :end_of_buffer, :end_of_line, :go_line, :home_of_line, :next_char,
      :next_char, :next_chunk, :next_line, :next_page, :next_word,
      :next_word_end, :prev_char, :prev_char, :prev_chunk, :prev_line,
      :prev_page, :prev_word, :prev_word_end, :start_of_line
    )
  end

  module Methods
    module Move
      module_function

      def prefix_arg_sol(buffer)
        return if buffer.update_prefix_arg
        buffer.start_of_line
      end

      # This method forwards to {go_percent} or {go_match}, depending on whether
      # an argument was given.
      def percent(buffer, count = buffer.prefix_count(nil))
        if count
          buffer.at_insert.go_percent(count)
        else
          buffer.at_insert.matching_brace
        end
      end
    end
  end
end
