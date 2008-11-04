module VER
  class View
    class AskLarge < View
      module Methods
      end

      LAYOUT = {
        :width => lambda{|w| w },
        :height => lambda{|h| h * 0.8 }, # 80%
        :top => 0,
        :left => 0
      }

      DEFAULT = {
        :interactive => true,
        :mode => :ask_large,
      }

      def initialize(*args)
        super

        buffer_name = self.class.name.split('::').last.downcase.to_sym
        @buffer = MemoryBuffer.new(buffer_name)
      end

      def input=(string)
        buffer[0..-1] = string
        buffer.cursor.pos = buffer.size
        update_choices
      end

      def input
        buffer[0..-1]
      end

      # TODO: natural scrolling
      def draw
        window.move 1, 1
        window.puts "#{@prompt} #{buffer}"
        window.color = Color[:white]

        current = @choices.index(@pick) || 0
        from = 0
        to = from + window.height
        delta = current - (window.height - 6)

        if delta > 1
          from += delta
          to += delta
        end

        @choices[from...to].each do |choice|
          if choice == @pick
            draw_selected_choice(choice)
          else
            draw_choice(choice)
          end
        end

        draw_padding
      ensure
        window.move 1, (cursor.pos + @prompt.size + 2)
        window.color = Color[:white]
        window.box ?|, ?-
      end

      def pick
        @pick || @choices.first
      end

      def select_above
        if idx = @choices.index(@pick)
          @pick = @choices[idx - 1]
        end

        @pick ||= @choices[0]
      end

      def select_below
        if idx = @choices.index(@pick)
          @pick = @choices[idx + 1]
        end

        @pick ||= @choices[0]
      end
    end
  end
end
