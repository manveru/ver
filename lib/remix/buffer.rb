module Remix
  class Buffer
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def new_cursor(position = 0)
      return Cursor.new(position, self)
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

=begin
    def each_line(s=nil, len=nil)
      r         = range(s, nil)
      pos, last = r.first, r.last

      while pos < last
        i = find(/\n/, pos...last) || last
        yield self[pos..i], (pos..i)
        pos = i + 1
      end
    end
=end

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
  end

  class BufferLine < Struct.new(:buffer, :line, :range, :number)
    def to_s
      line
    end

    def delete
      self.line  = ''
    end

    def delete!
      delete
      store!
    end

    def join!(other_line)
      if range.begin < other_line.range.begin
        append(other_line)
        other_line.delete!
        store!
      else
        raise ArgumentError, "Cannot join downwards (yet)"
      end
    end

    def store!
      VER::Log.debug "buffer[%p, %p] = %p" % [range.begin, range.end, line]
      buffer[range] = line
    end

    def size
      line.size
    end

    def replace(string)
      self.line = string
    end

    def rstrip
      line.rstrip
    end

    def lstrip
      line.lstrip
    end

    def prepend(string)
      self.line = "#{string}#{line}"
      return self
    end

    def append(string)
      self.line = "#{line}#{string}"
      return self
    end
    alias << append

    def [](*args)
      line[*args]
    end

    def []=(*args)
      line.[]=(*args)
    end
  end

  class MemoryBuffer < Buffer
    def initialize(name, data = '')
      super name
      @dirty = false
      @undo, @redo = [], []
      @data = data
    end

    def size
      return @data.size
    end

    def index(pattern, s=nil, len=nil)
      r   = range(s,len)
      pos = @data[range(s,len)].index(pattern)
      pos += r.first if pos
    end

    def rindex(pattern, s=nil, len=nil)
      r   = range(s,len)
      pos = @data[range(s,len)].rindex(pattern)
      pos += r.first if pos
    end

    def [](s=nil, len=nil)
      @data[range(s,len)]
    end

    def []=(*args)
      case args.size
      when 2
        s, replacement = args
      when 3
        s, len, replacement = args
      else
        raise ArgumentError
      end

      @undo << [range(s, len), @data[range(s, len)]]
      @data[range(s, len)] = replacement
      @dirty = true
    end

    def undo
      return if @undo.empty?
      range, content = last = @undo.pop
      @redo << last
      @data[range] = content
    end

    def unundo # redo is ruby keyword
      return if @redo.empty?
      range, content = last = @redo.pop
      @undo << last
      @data[range] = content
    end

    def modified?
      @dirty
    end

    def draw_on(window, top)
      y, x = window.pos
      window.move 0, 0
      range = (top...(window.height + top))

      each_line do |line|
        window.printw(line.to_s) if range.include?(line.number)
      end

      window.move y, x
      window.refresh
    end

    # to_enum(:each_line).with_index(&block)
    # may result in ugly receiver: |(line, range), index|
    # so this approach gives you:  |line, range, index|
    def each_line_with_index
      to_enum(:each_line).with_index{|(l,r),i| yield(l,r,i) }
    end
  end

  class FileBuffer < MemoryBuffer
    attr_reader :filename

    def initialize(name, file_or_filename)
      super(name)

      case file_or_filename
      when File
        load_file(file_or_filename)
      when String
        load_filename(file_or_filename)
      else
        raise ArgumentError, "Not a File or String: %p" % file_or_filename
      end
    end

    # TODO: should it close?
    def load_file(file)
      file.rewind
      @data = file.read
      @filename = file.path
    end

    def load_filename(file)
      @filename = File.expand_path(file)
      @data = File.read(@filename)
    end

    def save_file
      File.open(filename, 'w+') do |file|
        file.puts @data
      end

      @dirty = false
      return filename
    end
  end
end
