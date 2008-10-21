require 'ver/methods/status'

module VER
  class StatusView < View
    METHODS = [Methods::Status]
    INITIAL_MODE = :status

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

      visible_each do |line|
        @window.print_line(line.ljust(window.width))
      end

      @window.refresh
    end
  end
end
