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

    def self.refresh
      LIST.each{|name, view| view.refresh }
      Ncurses.doupdate
    end

    def self.open
      new.open
    end

    LAYOUT = { :height => 0, :width => 0, :top => 0, :left => 0 }
    DEFAULT = { :mode => :control, :interactive => false }

    attr_reader :top, :left, :buffer, :buffers, :cursors
    attr_accessor :window, :keyhandler, :methods, :selection, :mode, :name,
      :interactive, :options, :redraw, :syntax, :previous_buffer

    def initialize(name, options = {})
      @name = name
      @options = DEFAULT.merge(self.class::DEFAULT.merge(options))
      @layout = options[:layout] || self.class::LAYOUT

      @methods = Mixer.new(self)
      @window = Window.new(@layout)
      @keyhandler = KeyHandler.new(self)

      @buffer, @interactive, @mode =
        @options.values_at(:buffer, :interactive, :mode)

      @buffers = @buffer ? [@buffer] : []
      @redraw = true
      @cursors = []

      @top = @left = 0
      LIST[name.to_sym] = self
    end

    def open
      window.show
      @redraw = true
      draw
      refresh

      if interactive?
        Keyboard.focus = self
      else
        yield(self) if block_given?
      end
    end

    def top=(n)
      @top = n
      @redraw = true
    end

    def left=(n)
      @left = n
      @redraw = true
    end

    def close
      window.clear
      window.hide
    end

    def press(key)
      # VER.bench("@keyhandler.press(%p)" % key) do

      @keyhandler.press(key)
      draw
      refresh

      # end
    rescue ::Exception => ex
      VER.error(ex)
    end

    def draw_padding
      padding = (window.height + 2) - (window.y + 1)
      window.puts [''] * padding
    end

    def resize
      window.resize_with(@layout)
    end

    def cursor
      buffer.cursor
    end

    def cursor=(cursor)
      buffer.cursor = cursor
    end

    def interactive?
      @interactive
    end

    def redraw?
      @redraw
    end

    def refresh
      window.wnoutrefresh
    end

    # Strings are assumed to be filenames
    def buffer=(buffer)
      previous_buffer = self.buffer

      case buffer
      when nil, false, true
        return
      when Buffer
        if found = buffers.find{|b| b == buffer }
          @buffer = found
        else
          buffers << buffer
          @buffer = buffer
        end
      when String
        path = ::File.expand_path(buffer)

        if found = buffers.find{|b| b.filename == path }
          @buffer = found
        else
          @buffer = FileBuffer.new(@name, buffer)
          buffers << @buffer
        end
      else
        raise(ArgumentError, "Not a buffer: %p" % buffer)
      end

      self.previous_buffer = previous_buffer
      self.syntax = Syntax.from_filename(self.buffer.filename)

      @redraw = true
      draw
    end

    def switch_to_previous_buffer
      return unless previous_buffer
      self.buffer = previous_buffer
    end

    def input=(string)
      buffer[0..-1] = string
      buffer.cursor.pos = buffer.size
    end

    def scroll_border
      window.height / 10
    end

    def adjust_pos(border = scroll_border)
      y, x = cursor.to_pos
      view_y = y - top
      view_x = x - left
      window_height = window.height - border
      window_width  = window.width - border

      if view_y > window_height
        self.top += (view_y - window_height)
      elsif view_y < 0
        self.top += view_y
      end

      if y >= border and view_y > 0 and view_y <= border
        self.top -= (border - view_y)
      end

      if view_x > window_width
        self.left += (view_x - window_width)
      elsif view_x < 0
        self.left += view_x
      end

      return y - @top, x - @left
    end

    def scroll(n)
      @redraw = true
      self.top += n
      self.top = 0 if self.top < 0
    end

    def bottom
      @top + window.height
    end

    def right
      @left + (window.width - 1)
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
      visible_y?(y + top) and visible_x?(x + left)
    end

    def visible_cursor?(cursor)
      y, x = cursor.to_pos
      visible_y?(y) and visible_x?(x)
    end

    def visible_each
      visible_xs = self.visible_xs

      buffer.data_range(visible_ys).each_line do |line|
        if substr = line[visible_xs]
          yield substr.size == 0 ? "\n" : substr
        else
          yield "\n"
        end
      end
    end
  end
end
