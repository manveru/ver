require 'ver/methods/ask'

module VER
  class AskView < View
    METHODS = [Methods::Ask]
    INITIAL_MODE = :ask

    attr_reader :question

    def ask(question, completer, &block)
      @question, @block = question, completer
      @buffer = MemoryBuffer.new(:ask)

      answer = catch(:answer){ activate }
      Log.debug :answer => answer
      response = yield(answer)
    rescue Object => ex
      VER.error(ex)
    ensure
      deactivate
      View.active.focus_input
    end

    def draw
      @valid, @completions = block_complete
      input = self.input

      draw_readline
      draw_completions
    rescue Object => ex
      Log.debug :error
      draw_exception(ex)
    ensure
      adjust_cursor
      window.refresh
    end

    def draw_readline
      window.clear
      window.move 0, 0

      window.color_set Color[:white]
      window.print_line @question

      window.color_set Color[@valid ? :green : :red]
      window.print_line input + "\n"
    end

    def draw_completions
      window.move 1, 0
      color_complete_from(input, *@completions).each do |color, string|
        window.color_set color
        window.print_line string
      end
    end

    def draw_exception(ex = @exception)
      window.move(1, 0)
      window.color_set(Color[:red])
      window.print_line(ex)
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

    def activate
      View[:status].window.hide
      View[:info].window.hide
      window.show

      # window.clear
      window.color_set Color[:black, :white]
      draw
      focus_input
    end

    def deactivate
      View[:status].window.show
      View[:info].window.show
    end
  end
end
