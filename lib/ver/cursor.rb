module VER
  class Cursor
    attr_reader :buffer

    def initialize(buffer)
      @buffer = buffer
    end

    def y
      @buffer.window.gety
    end

    def x
      @buffer.window.getx
    end

    def to_a
      [y, x]
    end

    def left
      buffer.window.move y, x - 1
    end

    def right
      buffer.window.move y, x + 1
    end

    def up
      buffer.window.move y - 1, x
    end

    def down
      buffer.window.move y + 1, x
    end
  end
end
