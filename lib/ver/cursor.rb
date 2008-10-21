module VER
  class Cursor
    attr_reader :buffer
    attr_accessor :pos, :mark

    def initialize(buffer, pos, mark = nil)
      @buffer, @pos = buffer, pos
      @mark = mark || buffer.size
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
      @pos = bol
    end

    def end_of_line
      @pos = eol
    end

    def eol
      @buffer.index(/\n/, @pos..buffer.size) || buffer.size
    end

    def bol
      max = [@pos - 1, 0].max
      if pos = @buffer.rindex(/\n/, 0..max)
        pos + 1
      else
        0
      end
    end

    def region(range)
      cursor = @buffer.new_cursor(@pos)
      cursor.pos, cursor.mark = range.begin, range.end
      yield(cursor)
    end

    def buffer_line
      @buffer[0..@pos].count(/\n/)
    end

    def up
      return unless bol = buffer.rindex(/\n/, (0...@pos))
      prebol = buffer.rindex(/\n/, (0...bol))

      target = @pos - bol

      if prebol # not second line
        pre_size = bol - prebol

        if target == 0
          @pos = prebol + 1
        elsif pre_size == 1 # previous line is empty
          @pos = bol
        elsif prebol + target < bol
          @pos = prebol + target
        else
          @pos = bol - 1
        end
      else
        @pos = target - 1
      end
    end

    def down
      return unless eol = buffer.index(/\n/, @pos..buffer.size)
      bol = buffer.rindex(/\n/, 0..@pos) || -1
      posteol = buffer.index(/\n/, (eol + 1)..buffer.size)

      target = eol + (@pos - bol)

      if not posteol
        @pos = buffer.size - 1
      elsif posteol - 1 == eol # coming is empty line
        @pos = posteol
      elsif bol == eol # on empty line
        @pos += 1
      elsif target >= posteol
        @pos = posteol - 1
      else
        @pos = target
      end
    end

    def left(boundary = 0)
      @pos -= 1
      @pos = boundary if @pos < boundary
    end

    def right
      @pos += 1 if @pos < (buffer.size - 1)
    end

    def render_on(window)
      window.move(*to_pos)
    end

    # TODO:
    #   * should take linewrap into account?
    #   * needs up to three matches, might be possible with only 2
    def to_pos(from_mark = false)
      return to_y(from_mark), to_x(from_mark)
    end

    def to_y(from_mark = false)
      pos = from_mark ? @mark : @pos
      y = @buffer[0...pos].count("\n")
    end

    def to_x(from_mark = false)
      pos = from_mark ? @mark : @pos

      bol = @buffer.rindex(/\n/, 0...pos)
      eol = @buffer.index(/\n/, pos..buffer.size)

      if not bol and not eol # only one line
        x = pos
      elsif not bol # first line
        x = pos
      elsif bol == eol # on newline
        if bol = @buffer.rindex(/\n/, 0...pos)
          x = pos - (bol + 1)
        else
          x = pos
        end
      else
        x = pos - (bol + 1)
      end

      return x
    end

    def to_range
      [@pos, @mark].min..[@pos, @mark].max
    end

    def delta
       [@pos, @mark].max - [@pos, @mark].min
    end

    def insert(string)
      @buffer[@pos, 0] = string
      @pos += 1
    end

    def insert_newline
      @buffer[@pos, 0] = "\n"
      @pos += 1
    end

    def insert_backspace
      return if @pos == 0 or @pos - 1 < 0

      @pos -= 1
      @buffer[@pos, 1] = ''
    end

    def insert_delete
      @buffer[@pos, 1] = ''
    end
  end
end
