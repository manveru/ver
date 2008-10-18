require 'ver/action/status'

module VER
  class StatusView < View
    attr_reader :buffer

    COLOR = {:status => :blue, :info => :red}

    def initialize(name, window, buffer)
      super
      @buffer = buffer
    end

    def draw
      @window.color_set Color[COLOR[@name]]
      buffer.draw_on(@window, @offset)
    end
  end
end
