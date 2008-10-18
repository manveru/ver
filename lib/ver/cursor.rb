module VER
  class Cursor
    attr_reader :buffer
    attr_accessor :pos

    def initialize(buffer, pos)
      @buffer, @pos = buffer, pos
      @mark = buffer.size
    end

    def wrap_region
      return yield if @pos < @mark
      @pos, @mark = @mark, @pos
      result = yield
      @pos, @mark = @mark, @pos
      return result
    end

    def rindex(pattern)
      wrap_region{ @buffer.rindex(pattern, @pos..@mark) }
    end

    def index(pattern)
      wrap_region{ @buffer.index(pattern, @pos..@mark) }
    end
    alias find index

    def beginning_of_line
      @pos = rindex(/\n/) || 0
    end

    def end_of_line
      @pos = index(/\n/) || buffer.size
    end

    def buffer_line
      @buffer[0..@pos].count(/\n/)
    end

    def left_indent
      @pos - (rindex(/\n/) || 0)
    end

    def up
      if bol = buffer.rindex(/\n/, (0..@pos))
        if prebol = buffer.rindex(/\n/, (0...bol))
          @pos -= (bol - prebol)
        else
          @pos -= (bol + 1)
        end
      end
    end

    def down
      if eol = buffer.index(/\n/, (@pos..buffer.size))
        if bol = buffer.rindex(/\n/, (0..@pos))
          @pos += (eol - bol)
        else
          @pos += (eol + 1)
        end
      end

      @pos = buffer.size - 1 if @pos > buffer.size
    end

    def left(chars = 1)
      @pos -= 1 if @pos > 0
    end

    def right(chars = 1)
      @pos += 1 if @pos < buffer.size
    end
  end
end

__END__

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
