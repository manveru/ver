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

      def draw
        window.move 1, 1
        window.puts "#{@prompt} #{buffer}"
        window.color = Color[:white]

        current = @choices.index(@pick) || 0
        height = [window.height - 3, 5].max
        count = @choices.size

        top_half = bottom_half = (height / 2)
        bottom_half -= 1 if height % bottom_half == 0

        if current < top_half
          range = (0...height)
        elsif current >= (count - bottom_half)
          range = ((count - height)..count)
        else
          range = ((current - top_half)..(current + bottom_half))
        end

        draw_cons(@choices[range])

        draw_padding
      ensure
        window.move 1, (cursor.pos + @prompt.size + 2)
        window.color = Color[:white]
        window.box 124, 45
      end

      def draw_cons(cons)
        cons.each do |choice|
          if choice == @pick
            draw_selected_choice(choice)
          else
            draw_choice(choice)
          end
        end
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
