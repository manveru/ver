require 'ver/action/status'

module VER
  class StatusView < View
    attr_reader :buffer

    COLOR = {
      :status => [:black, :white],
      :info   => [:white, :blue]
    }

    def initialize(name, window, buffer)
      super
      @buffer = buffer
    end

    def show(message)
      buffer[0..-1] = message
      draw
    end

    def draw
      window.color_set Color[*COLOR[@name]]
      @window.move 0, 0

      buffer.each_line do |line|
        if visible_line?(line.number)
          @window.print_line(line)
        end
      end

      @window.refresh
    end
  end
end
