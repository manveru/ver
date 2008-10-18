require 'ver/action/main'

module VER
  class MainView < View
    def press(key)
      KeyMap.press(key, *modes) do |mode, method|
        start = @window.y

        # VER.info "%p in %s mode called: %s" % [key, mode, method]
        MainAction.new(self, mode, key).send(method)
        VER.status(status_line)

        draw
      end
    end

    def status_line
      modified = buffer.modified? ? '+' : ' '
      file     = buffer.filename
      modes    = @modes.join(',')
      row, col = window.pos

      "%s [%s] (%s) %d,%d" % [file, modified, modes, row + offset, col]
    end

    def buffer
      @buffers.first
    end

    # Oh, the pain...
    def buffer=(buffer)
      case buffer
      when Buffer
      when String
        if File.file?(buffer)
          VER.info "Loading #{buffer}..."
          buffer = FileBuffer.new(@name, buffer)
          VER.info "Loaded #{buffer.filename}"
        else
          buffer = MemoryBuffer.new(@name, buffer)
        end
      when File
        VER.info "Loading #{buffer.path}..."
        buffer = FileBuffer.new(@name, buffer)
        VER.info "Loaded #{buffer.path}"
      else
        raise(ArgumentError "Not a buffer: %p" % buffer)
      end

      @buffers.unshift(@buffers.delete(buffer) || buffer)
      @offset = 0
      draw
      VER.status(status_line)
    end
  end
end
