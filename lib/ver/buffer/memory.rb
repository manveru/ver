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
      common_index(pattern, s, len){|substr, pattern| substr.index(pattern) }
    end

    def rindex(pattern, s=nil, len=nil)
      common_index(pattern, s, len){|substr, pattern| substr.rindex(pattern) }
    end

    def common_index(pattern, s, len)
      r = range(s,len)

      if substr = @data[range(s,len)]
        pos = yield(substr, pattern)
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

    def start_snapshot
    end

    def stop_snapshot
    end

    def undo
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

    def to_scanner(range)
      StringScanner.new(self[range])
    end

    # Avoid overlaps, pick regexps as they match with lowest possible delta in
    # between them.
    def grep_successive_cursors(*regexps)
      cursors = []

      scanner = StringScanner.new(@data)

      until scanner.eos?
        pos = scanner.pos

        regexps.each do |regex|
          if match = scanner.scan(regex)
            cursors << new_cursor((scanner.pos - match.size), scanner.pos)
          end
        end

        # nothing matches here, go forward one character
        scanner.scan(/./um) if pos == scanner.pos
      end

      return cursors
    end

    def grep_cursor(regex, from_pos = 0, to_pos = size)
      if idx = @data.index(regex, from_pos) and match = $~
        from, to = match.offset(0)
        if to <= to_pos
          return new_cursor(from, to)
        end
      end

      return nil if from_pos == 0
      grep_cursor(regex, 0, to_pos) # wrap around
    end
  end
end
