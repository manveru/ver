module VER
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
        line.gsub!(/\s*$/, ' ')
        store!
      else
        raise ArgumentError, "Cannot join downwards (yet)"
      end
    end

    def store!
      # VER::Log.debug "buffer[%p, %p] = %p" % [range.begin, range.end, line]
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
end
