module VER
  class MemoryBuffer < Buffer
    def initialize(name, data = '')
      super name
      @dirty = false
      @data = data
    end

    def filename
      @name
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

      @data[range(s, len)] = replacement.to_s
      @dirty = true
    end

    def modified?
      @dirty
    end

    def grep_cursors(regex)
      pos = 0
      cursors = []

      while idx = @data.index(regex, pos)
        if matchdata = $~
          from, to = matchdata.offset(0)
          cursors << new_cursor(from, to)
          pos = to + 1
        else
          pos = idx + 1
        end
      end

      return cursors
    end
  end
end
