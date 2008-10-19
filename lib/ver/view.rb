require 'ver/action/main'

module VER
  class View
    LIST = {}

    def self.[](name)
      LIST[name]
    end

    def self.[]=(name, view)
      LIST[name] = view
    end

    attr_accessor :window, :buffers, :modes
    attr_reader :name, :offset, :buffer

    def initialize(name, window, *buffers)
      @name, @window, @buffers = name, window, buffers
      @buffer = @buffers.first
      @modes = [:control]
      @offset = 0
      View::LIST[name] = self
    end

    def cursor
      buffer.cursor
    end

    def focus_input
      Keyboard.focus(self)
      Keyboard.poll
    end

    # Strings are assumed to be filenames
    def buffer=(buffer)
      case buffer
      when Buffer
        if found = buffers.find{|b| b == buffer }
          @buffer = found
        else
          buffers << buffer
          @buffer = buffer
        end
      when String
        path = File.expand_path(buffer)

        if found = buffers.find{|b| b.filename == path }
          @buffer = found
        else
          @buffer = FileBuffer.new(@name, buffer)
          buffers << @buffer
        end
      when IO
        raise(ArgumentError "Not a buffer: %p" % buffer)
      else
        raise(ArgumentError "Not a buffer: %p" % buffer)
      end

      @buffer.cursor ||= @buffer.new_cursor(0)
      draw
    end

    def adjust_offset(border = 5)
      y, x = cursor.to_pos
      view_y = y - @offset
      window_height = (@window.height - border)

      if view_y > window_height
        @offset += (view_y - window_height)
      elsif view_y < 0
        @offset += view_y
      end

      return y - @offset, x
    end

    def scroll(n)
      @offset += n
      @offset = 0 if @offset < 0
    end

    def visible_line?(num)
      visible_lines.include?(num)
    end

    def visible_pos?(y, x)
      visible_lines.include?(y + @offset)
    end

    def visible_lines
      (top..bottom)
    end

    def top
      @offset
    end

    def bottom
      @offset + (@window.height - 1)
    end

    def window_resize
      window.resize
    end
  end
end
