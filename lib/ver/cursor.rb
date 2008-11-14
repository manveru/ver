module VER
  class Cursor < Struct.new(:buffer, :pos, :mark, :color, :meta)
    def [](key, *keys)
      keys.empty? ? meta[key] : meta.values_at(key, *keys)
    end

    def []=(key, value)
      meta[key] = value
    end

    def ==(other)
      other.buffer == buffer &&
        other.pos == pos &&
        other.mark == mark
    end

    def beginning_of_line
      self.pos = bol
    end

    def end_of_line
      self.pos = eol
    end

    def eol(pos = pos)
      buffer.index(/\n/, pos..buffer.size) || buffer.size
    end

    def bol(pos = pos)
      max = [pos - 1, 0].max
      if pos = buffer.rindex(/\n/, 0..max)
        pos + 1
      else
        0
      end
    end

    def region(range)
      cursor = buffer.new_cursor(pos)
      cursor.pos, cursor.mark = range.begin, range.end
      yield(cursor)
    end

    def buffer_line
      buffer[0..pos].count(/\n/)
    end

    def up
      return unless bol = buffer.rindex(/\n/, (0...pos))
      prebol = buffer.rindex(/\n/, (0...bol))

      target = pos - bol

      if prebol # not second line
        pre_size = bol - prebol

        self.pos =
          if target == 0
            prebol + 1
          elsif pre_size == 1 # previous line is empty
            bol
          elsif prebol + target < bol
            prebol + target
          else
            bol - 1
          end
      else
        self.pos = target - 1
      end
    end

    def down
      return unless eol = buffer.index(/\n/, pos..buffer.size)
      bol = buffer.rindex(/\n/, 0..pos) || -1
      posteol = buffer.index(/\n/, (eol + 1)..buffer.size)

      target = eol + (pos - bol)

      self.pos =
        if not posteol
          buffer.size - 1
        elsif posteol - 1 == eol # coming is empty line
          posteol
        elsif bol == eol # on empty line
          pos + 1
        elsif target >= posteol
          posteol - 1
        else
          target
        end
    end

    def left(boundary = 0)
      self.pos -= 1
      self.pos = boundary if pos < boundary
    end

    def right
      self.pos += 1 if pos < (buffer.size - 1)
    end

    # TODO:
    #   * should take linewrap into account?
    #   * needs up to three matches, might be possible with only 2
    def to_pos(from_mark = false)
      return to_y(from_mark), to_x(from_mark)
    end

    def to_y(from_mark = false)
      max = from_mark ? mark : pos
      y = buffer[0...max].count("\n")
    rescue RangeError
      return 0
    end

    def to_x(from_mark = false)
      max = from_mark ? mark : pos

      bol = buffer.rindex(/\n/, 0...max)
      eol = buffer.index(/\n/, max..buffer.size)

      if not bol and not eol # only one line
        x = max
      elsif not bol # first line
        x = max
      elsif bol == eol # on newline
        if bol = buffer.rindex(/\n/, 0...pos)
          x = max - (bol + 1)
        else
          x = max
        end
      else
        x = max - (bol + 1)
      end

      return x
    rescue RangeError
      return 0
    end

    def to_s
      buffer[to_range]
    end

    def to_range
      [pos, mark].min..[pos, mark].max
    end

    def delta
       [pos, mark].max - [pos, mark].min
    end

    def insert(string)
      buffer[pos, 0] = string
      self.pos += string.size
    end

    def insert_newline
      insert("\n")
    end

    def delete_left
      return if pos == 0 or pos - 1 < 0

      self.pos -= 1
      deleted = buffer[pos, 1]
      buffer[pos, 1] = ''
      return deleted
    end

    def delete_right
      deleted = buffer[pos, 1]
      buffer[pos, 1] = ''
      return deleted
    end

    def replace(string)
      deleted = buffer[pos, string.size]
      buffer[pos, string.size] = string
      return deleted
    end

    def delete_range
      range = to_range
      range = (range.begin...range.end)

      deleted = buffer[range]
      buffer[range] = ''
      return deleted
    end

    def virtual
      old = clone
      self.mark = pos
      yield
      self.pos, self.mark = old.pos, old.mark
      rearrange
    end

    def invert
      clone.invert!
    end

    def invert!
      self.mark, self.pos = pos, mark
      self
    end

    # fix pos and mark to be within the bounds of the buffer
    def rearrange
      min, max = 0, buffer.size
      self.pos = [min, pos, max].sort[1]
      self.mark = [min, pos, max].sort[1]
    end

    def normalize
      from, to = [pos, mark].sort
      yield(from..to)
    end

    def rindex(pattern)
      normalize{|range| buffer.rindex(pattern, range) }
    end

    def index(pattern)
      normalize{|range| buffer.index(pattern, range) }
    end
    alias find index

    WORD = /[A-Za-z0-9'-]+/
    LEFT_CHUNK = /#{WORD}\z/
    RIGHT_CHUNK = /\A#{WORD}/

    # FIXME:
    #   * use index/rindex?
    #   * assume default range, all the buffer is way too large
    def current_word(left_chunk = LEFT_CHUNK, right_chunk = RIGHT_CHUNK)
      left, right = buffer[0...pos], buffer[pos..-1]
      left_match, right_match = left[left_chunk], right[right_chunk]

      if left_match and right_match
        word = left_match + right_match
        range = (pos - left_match.size)...(pos + right_match.size)
      elsif word = left_match
        range = (pos - word.size)...pos
      elsif word = right_match
        range = pos...(pos + word.size)
      end

      return word, range if word
    end
  end
end
