module VER
  class Action
    WORD_PART = VER::Keyboard::PRINTABLE.grep(/\w/)
    WORD_BREAK = Regexp.union(*(VER::Keyboard::PRINTABLE - WORD_PART))
    CHUNK_BREAK = /\s+/

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
