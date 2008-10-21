require 'ver/methods/main'

module VER
  class View
    LIST = {}

    def self.[](name)
      LIST[name]
    end

    def self.[]=(name, view)
      LIST[name] = view
    end

    def self.resize
      LIST.each{|name, view| view.resize }
    end

    # FIXME: this doesn't assure only one is active, but would be nice...
    #        LIST.find{|view| view.active }
    def self.active
      @active
    end

    def self.active=(view)
      if @active
        @active.deactivate
        @active.window.hide
      end

      @active = view
      view.activate
      view.window.show
      view.draw
    end

    attr_accessor :window, :methods, :active, :selection, :keyhandler, :highlights
    attr_reader :buffers, :modes, :name, :top, :left, :buffer

    def initialize(name, window, *buffers)
      @name, @window, @buffers = name, window, buffers
      @buffer = @buffers.first
      @top, @left = 0, 0

      @modes = [self.class::INITIAL_MODE]
      @methods = Mixer.new(self, *self.class::METHODS)
      @keyhandler = KeyHandler.new(self)

      @highlights = []

      View::LIST[name] = self
    end

    def mode
      @modes.first
    end

    def press(key)
      @keyhandler.press(key)
      draw
    end

    def cursor
      buffer.cursor
    end

    def cursor=(cursor)
      buffer.cursor = cursor
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
        raise(ArgumentError, "Not a buffer: %p" % buffer)
      else
        raise(ArgumentError, "Not a buffer: %p" % buffer)
      end

      # draw
    end

    def adjust_pos(border = 5)
      y, x = cursor.to_pos
      view_y = y - @top
      view_x = x - @left
      window_height = @window.height - border
      window_width  = @window.width - border

      if view_y > window_height
        @top += (view_y - window_height)
      elsif view_y < 0
        @top += view_y
      end

      if view_x > window_width
        @left += (view_x - window_width)
      elsif view_x < 0
        @left += view_x
      end

      return y - @top, x - @left
    end

    def scroll(n)
      @top += n
      @top = 0 if @top < 0
    end

    def bottom
      @top + @window.height
    end

    def right
      @left + (@window.width - 1)
    end

    def visible_y?(num)
      visible_ys.include?(num)
    end

    def visible_ys
      (top..bottom)
    end

    def visible_x?(num)
      visible_xs.include?(num)
    end

    def visible_xs
      (left..right)
    end

    def visible_pos?(y, x)
      visible_y?(y + @top) and visible_x?(x + @left)
    end

    def visible_each
      visible_xs = self.visible_xs

      buffer.data_range(visible_ys).each do |line|
        if substr = line[visible_xs]
          yield substr.size == 0 ? "\n" : substr
        else
          yield "\n"
        end
      end
    end

    def resize
      window.resize
    end

    def activate
    end

    def deactivate
    end
  end
end
