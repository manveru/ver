module VER
  class MemoryBuffer < Buffer
    attr_accessor :dirty

    def initialize(name, data = '')
      @modified = false
      @dirty = false
      @data = data
      super name
    end

    def filename
      @name
    end

    def size
      @data.size
    end

    def index(pattern, s=nil, len=nil)
      r = range(s,len)

      if substr = @data[range(s,len)]
        pos = substr.index(pattern)
        pos += r.first if pos
      end
    end

    def rindex(pattern, s=nil, len=nil)
      r = range(s,len)

      if substr = @data[range(s,len)]
        pos = substr.rindex(pattern)
        pos += r.first if pos
      end
    end

    def <<(content)
      @data[@data.size,0] = content
    ensure
      @modified = true
      @dirty = true
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
    ensure
      @modified = true
      @dirty = true
    end

    def modified?
      @modified
    end

    def dirty?
      @dirty
    end

    def grep_cursors(regex, from_pos = 0, to_pos = size)
      cursors = []

      while from_pos < to_pos and idx = @data.index(regex, from_pos)
        if matchdata = $~
          from, to = matchdata.offset(0)
          cursors << new_cursor(from, to)
          from_pos = to + 1
        else
          from_pos = idx + 1
        end
      end

      return cursors
    end
  end
end
