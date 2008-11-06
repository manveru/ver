module VER
  class View
    class Info < View
      module Methods
      end

      LAYOUT = {
        :height => 2,
        :top => lambda{|height| height - 2},
        :left => 0,
        :width => lambda{|width| width }
      }

      DEFAULT = { :methods => [], :interactive => false }

      attr_accessor :info_color, :status_color

      def initialize(*args)
        super
        @info = MemoryBuffer.new(:info_info)
        @status = MemoryBuffer.new(:info_status)

        @info_color = Color[:white, :black]
        @status_color = Color[:black, :white]
      end

      def status=(message)
        @status[0..-1] = message
        draw
      end

      def info=(message)
        @info[0..-1] = message
        draw
      end

      def draw
        window.color = @status_color
        window.move 0, 0
        window.print_line(@status.to_s)

        window.color = @info_color
        window.move 1, 0
        window.print_line(@info.to_s)

        refresh
      end
    end
  end
end
