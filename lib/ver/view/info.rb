module VER
  class View
    class Info < View
      module Methods
      end

      LAYOUT = {
        :height => 1,
        :top => lambda{|height| height - 1},
        :left => 0,
        :width => lambda{|width| width }
      }

      DEFAULT = { :methods => [], :interactive => false }

      def initialize(*args)
        super
        @buffer = MemoryBuffer.new(@name)
        @color = Color[:black, :white]
      end

      def draw
        window.color = @color
        window.move 0, 0
        window.print_line buffer[0..-1]
        refresh
      end

      def change
        window.clear
        yield(self)
        draw
      end
    end
  end
end
