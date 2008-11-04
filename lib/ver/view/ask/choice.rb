module VER
  class View
    class AskChoice < View
      module Methods
        def stop
          view.close
          View[:file].open
        end

        def pick
          stop
        end
      end

      LAYOUT = {
        :width => lambda{|w| w },
        :height => 2,
        :top => lambda{|h| h - 2},
        :left => 0
      }

      DEFAULT = {
        :interactive => true,
        :mode => :ask_choice
      }

      attr_reader :prompt, :valid, :choices, :block

      def initialize(*args)
        super
        @buffer = MemoryBuffer.new(:ask_choice)
        @prompt = '>'
      end

      def open(prompt, choices, &block)
        @prompt, @choices, @block = prompt, choices, block
        @buffer.clear
        super()
      end

      def draw
        window.move 0, 0
        window.color = Color[:white]
        window.print_line("#{@prompt}#{buffer}")
        window.print_line(@choices.values.uniq.sort.join(', '))

        window.move 0, (cursor.pos + @prompt.size)
        refresh
      end

      def press(key)
        super

        if choice = @choices[buffer.to_s.strip]
          @block.call(choice)
          close
        end
      end
    end
  end
end
