module VER
  class Action
    def initialize(view, mode, key)
      @view, @mode, @key = view, mode, key
      @window, @buffer, @cursor = @view.window, @view.buffer, @view.cursor
    end

    def cursor_x
      @window.x
    end

    def cursor_y
      @window.y
    end
  end
end
