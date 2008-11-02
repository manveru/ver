module VER
  class View
    class AskSmall < View
      LAYOUT = {
        :width => lambda{|w| w },
        :height => 2,
        :top => lambda{|h| h - 2},
        :left => 0
      }

      DEFAULT = {
        :interactive => true,
        :methods => [Methods::Ask],
        :mode => :ask
      }

      attr_reader :prompt, :valid, :choices, :block

      def initialize(*args)
        super
        @buffer = MemoryBuffer.new(:ask)
        @prompt = '>'
        @history = {}
      end

      def open(prompt, completer, &block)
        @prompt, @completer, @block = prompt, completer, block
        @buffer.clear
        @choices.clear if @choices
        super()
      end

      def answer
        Log.debug :valid => @valid
        buffer.to_s if @valid
      end

      def draw
        window.clear
        window.move 0, 0
        window.color = Color[:white]
        window.print "#{@prompt}#{buffer}"

        if @choices
          window.move 1, 0
          window.print @choices.join(' ')
        end

        window.move 0, (cursor.pos + @prompt.size)
      end

      def update_choices
        @valid, @choices = @completer.call(buffer.to_s)
      end

      def try_completion
        if @choices.size == 1
          string = @choices.first
          buffer[0..-1] = string
          buffer.cursor.pos = buffer.size
        elsif @choices.any?
          string = @choices.abbrev.keys.min_by{|k| k.size }[0..-2]

          if string.empty?
          else
            buffer[0..-1] = string
            buffer.cursor.pos = buffer.size
          end
        end
      end
    end
  end
end

__END__

      def open
        super
      end

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

        window.color = Color[:white]
        window.print @question

        window.color = Color[@valid ? :green : :red]
        window.print input + "\n"
      end

      def draw_completions
        window.move 1, 0
        color_complete_from(input, *@completions).each do |color, string|
          window.color = color
          window.print string
        end
      end

      def draw_exception(ex = @exception)
        window.move(1, 0)
        window.color = Color[:red]
        window.print(ex)
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
        window.color = Color[:black, :white]
        draw
        Keyboard
      end

      def deactivate
        View[:status].window.show
        View[:info].window.show
      end
    end
  end
end
