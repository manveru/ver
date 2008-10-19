require 'ver/action/ask'

module VER
  class AskView < View
    attr_reader :question

    def ask(question, completer, &block)
      @question, @block = question, completer
      @buffer = MemoryBuffer.new(:ask)

      yield catch(:answer){ show_ask }
    ensure
      hide_ask
    end

    def press(key)
      KeyMap.press(key, :ask) do |mode, signature|
        AskAction.new(self, mode, key).send(*signature)
        draw
      end
    end

    def draw
      @input = buffer[0..-1]
      valid, @completions = block_complete

      window.clear
      window.move 0, 0

      input_color = valid ? :green : :red

      lines = [ [Color[:black, :white], @question],
                [Color[input_color], "#@input\n"] ]
      lines.concat color_complete_from(@input, *@completions)
      window.show_colored_chunks(lines)

      adjust_cursor
      window.refresh
    end

    def adjust_cursor
      y, x = buffer.cursor.to_pos
      x += @question.size
      window.move y, x
    end

    def try_completion
      if @completions.size == 1
        string = @completions.first
        buffer[0..-1] = string
        buffer.cursor.pos = buffer.size
      elsif @completions.any?
        string = @completions.abbrev.keys.min_by{|k| k.size }[0..-2]

        if string.empty?
        else
          buffer[0..-1] = string
          buffer.cursor.pos = buffer.size
        end
      end

      adjust_cursor
    end

    def input
      buffer[0..-1]
    end

    def block_complete(input = input)
      @block[input]
    end

    def color_complete_from(input, *completions)
      final = []

      completions.to_enum(:map).with_index do |string, idx|
        head, *tail = string.split(input)
        tail = tail.join(input)
        space = (idx + 1) == completions.size ? '' : ', '
        next unless head

        if head.empty?
          final << [Color[:green], input]
          final << [Color[:yellow], tail + space]
        else
          final << [Color[:yellow], string + space]
        end
      end

      final
    end

    def show_ask
      View[:status].window.hide
      View[:info].window.hide
      window.show
      # window.clear
      window.color_set Color[:black, :white]
      draw
      focus_input
    end

    def hide_ask
      window.hide
      View[:status].window.show
      View[:info].window.show
      View[:main].draw
      View[:main].focus_input
    end
  end
end
