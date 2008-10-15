module VER
  # Responsibilities:
  # * draw contents
  # * relation between window, buffer (and cursors?)
  # * Define the borders of visibility

  class View
    LIST = {}

    def self.[](name)
      LIST[name]
    end

    def self.[]=(name, view)
      LIST[name] = view
    end

    def self.draw
      LIST.each{|name, view| view.draw }
    end

    attr_accessor :window, :buffers, :modes
    attr_reader :name, :offset

    def initialize(name, window, *buffers)
      @name, @window, @buffers = name, window, buffers
      @modes = [:control]
      @offset = 0
      @bottom = @window.height

      View::LIST[name] = self

      yield(self) if block_given?
    end

    def scroll(n)
      @offset += n
      @offset = 0 if @offset < 0
    end

    def draw
      buffer.draw_on(@window, @offset)
    end

    def show(string)
      buffer[nil] = string
      window.clear
      draw
    end
  end

  class MainView < View
    def press(key)
      KeyMap.press(key, *modes) do |mode, method|
        Action.new(self, mode, key).send(method)
        View[:status].show(status_line)
        draw
      end
    end

    def status_line
      modified = buffer.modified? ? '+' : ' '
      file     = buffer.filename
      modes    = @modes.join(',')
      row, col = window.pos

      "%s [%s] (%s) %d,%d" % [file, modified, modes, row, col]
    end

    def buffer
      @buffers.first
    end

    # Oh, the pain...
    def buffer=(buffer)
      case buffer
      when Remix::Buffer
      when String
        if File.file?(buffer)
          buffer = Remix::FileBuffer.new(@name, buffer)
        else
          buffer = Remix::MemoryBuffer.new(@name, buffer)
        end
      when File
        buffer = Remix::FileBuffer.new(@name, buffer)
      else
        raise(ArgumentError "Not a buffer: %p" % buffer)
      end

      @buffers.unshift(@buffers.delete(buffer) || buffer)
    end
  end

  class StatusView < View
    attr_reader :buffer

    def initialize(name, window, buffer)
      super
      @buffer = buffer
    end
  end
end
