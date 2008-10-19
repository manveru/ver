module VER
  class Buffer
    attr_accessor :name, :cursor

    def initialize(name)
      @name = name
    end

    def cursor
      @cursor ||= Cursor.new(self, 0)
    end

    def new_cursor(position = 0)
      Cursor.new(self, position)
    end

    def range(s=nil, len=nil)
      r = (0...size)  unless s
      r = (s...s+len) if s.is_a?(Numeric) && len
      r = (s...size)  if s.is_a?(Numeric) && !len
      r = s           if s.is_a?(Range)

      if(r.first < 0 || r.first > size || r.last > size)
        raise RangeError, "#{r} not within 0..#{size}"
      end

      return r
    end

    # This should return the size of the buffer
    def size
      raise NotImplementedError
    end

    # This should return the index of the first occurrence of PATTERN
    # from position S, or the end of the buffer if S is nil.
    def index(pattern, s=nil, len=nil)
      raise NotImplementedError
    end

    # Find should behave like index
    def find(*args)
      return index(*args)
    end

    # This should return the index of the first occurrence of PATTERN
    # looking backwards from position S, or the end of the buffer if S
    # is nil.
    def rindex(pattern, s=nil, len=nil)
      raise NotImplementedError
    end

    # This should get a substring of the buffer.
    def [](s=nil, len=nil)
      raise NotImplementedError
    end

    # This should set a substring of the buffer.
    def []=(s, len, replacement)
      raise NotImplementedError
    end

    def apply_delta(range, replacement)
      d  = range.last - range.first + 1
      d -= replacement.size

      self[range] = replacement

      return -d
    end

    def apply_deltas(list)
      accum = 0

      list.each do |(r,s)|
        r = (r.first+accum)..(r.last+accum)
      accum += apply_delta(r, s)
      end
    end

    def each_line
      range = (0..0)

      @data.each_line("\n").with_index do |line, number|
        range = (range.end...(range.end + line.size))
        yield BufferLine.new(self, line, range, number)
      end
    end

    def line_at(number)
      each_line do |line|
        return line if number == line.number
      end

      return nil
    end

    def lines_at(*numbers)
      return [] if numbers.empty?
      max = numbers.max
      result = {}

      each_line do |line|
        ln = line.number

        if numbers.include?(ln)
          result[ln] = line
        end

        break if ln > max
      end

      result.values_at(*numbers)
    end

    def line_count
      @data.count("\n")
    end

    def map!
      # Gathering modifications then applying them makes life a lot
      # easier.  We don't have to keep track of how changes alter where
      # @pos and @mark should be.

      a = []
      each_line do |line, range|
        replacement = yield(line, range)
        a << [range, replacement]
      end

      @buffer.apply_deltas(a)

      @pos  = @buffer.size if @pos  > @buffer.size
      @mark = @buffer.size if @mark > @buffer.size

      return
    end

    def close
      @data = ''
    end
  end
end
