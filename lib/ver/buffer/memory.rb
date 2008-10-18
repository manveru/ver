module VER
  class MemoryBuffer < Buffer
    def initialize(name, data = '')
      super name
      @dirty = false
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

    def <<(content)
      @data[@data.size,0] = content
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

      @data[range(s, len)] = replacement
      @dirty = true
    end

    def modified?
      @dirty
    end

    def draw_on(window, top)
      y, x = window.pos
      window.move 0, 0

      range = (top...(window.height + top))
      lines_at(*range).each do |line|
        if line
          window.printw(line.to_s)
        else
          window.print_empty_line
        end
      end

      window.move y, x
    end
  end
end
