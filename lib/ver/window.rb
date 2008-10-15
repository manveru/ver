module VER
  # Responsibilities:
  # * Interface to Ncurses::WINDOW and Ncurses::Panel
  # * behave IO like: (print puts write read readline)
  # * hide and show itself

  # There's a very strange bug when i tried subclassing this, as Ncurses seems
  # to overwrite WINDOW::new, which will not return the Window instance we
  # want. So we have to wrap instead of subclass.
  class Window # < Ncurses::WINDOW
    attr_reader :width, :height, :top, :left

    def initialize(height, width, top, left)
      @height, @width, @top, @left = height, width, top, left
      @window = Ncurses::WINDOW.new(height, width, top, left)

      Ncurses::keypad(@window, true)

      @panel = Ncurses::Panel.new_panel(@window)
      @visible = true
    end

    # Ncurses

    def pos
      return y, x
    end

    def y
      Ncurses.getcury(@window)
    end

    def x
      Ncurses.getcurx(@window)
    end

    def x=(n) move(y, n) end
    def y=(n) move(n, x) end

    def move(y, x)
      @window.move(y, x)
    end

    def printw(string)
      @window.printw(string)
    end

    def refresh
      @window.refresh
    end

    def getch
      @window.getch
    rescue Interrupt => ex
      3 # is C-c
    end

    def clear
      0.upto(height) do |y|
        0.upto(width) do |x|
          move y, x
          printw ' '
        end
      end
    end

    # IO

    def print
    end

    def puts
    end

    def write
    end

    def read
    end

    def readline
    end

    # panel

    def hide
      Ncurses::Panel.hide_panel @panel
      Ncurses.refresh
      @visible = false
    end

    def show
      Ncurses::Panel.show_panel @panel
      Ncurses.refresh
      @visible = true
    end

    def visible?
      @visible
    end
  end
end

__END__
  module Window
    LIST = {}

    class Base < Ncurses::WINDOW
      DEFAULT = {:width => nil, :height => nil, :top => 0, :left => 0}

      attr_reader :visible, :width, :height, :top, :left

      def initialize(options = {})
        parse_options(options)
        options = DEFAULT.merge(parse_options(options))

        @width, @height, @top, @left =
          options.values_at(:width, :height, :top, :left)

        super(@width, @height, @top, @left)

        @panel = Ncurses::Panel.new_panel(self)

        Ncurses::keypad(self, true)
        Ncurses::halfdelay(1)

        hide
      end

      def parse_options(hash)
        height = hash[:height] || max_height
        width  = hash[:width]  || max_width
        left   = hash[:left]   || 0
        top    = hash[:top]    || 0

        height = (max_height + height) if height < 0
        width  = (max_width  + width ) if width < 0
        left   = (max_width  + left  ) if left < 0
        top    = (max_height + top   ) if top < 0

        hash.merge(:height => height, :width => width, :top => top, :left => left)
      end

      def max_width
        Ncurses.stdscr.getmaxx
      end

      def max_height
        Ncurses.stdscr.getmaxy
      end

      # make nil optional argument, god knows what this is used for anyway
      def color_set(color, arg = nil)
        super
      end

      def hide
        Ncurses::Panel.hide_panel @panel
        Ncurses.refresh
        @visible = false
      end

      def show
        Ncurses::Panel.show_panel @panel
        Ncurses.refresh
        @visible = true
      end

      def visible?
        @visible
      end

      def visible=(state)
        state ? show : hide
      end

      def y; Ncurses.getcury(self) end
      def x=(n) move(y, n) end
      def x; Ncurses.getcurx(self) end
      def y=(n) move(n, x) end
    end

    class Status < Base
      def initialize
        super :top => -3, :height => 3
      end
    end

    class Main < Base
      def initialize
        super :height => -3
      end
    end
  end
end

__END__

    attr_reader :width, :height, :y, :x

    def self.with_buffer(name, options = nil)
      options ||= self::LAYOUT
      window = new(options || self::LAYOUT)

      buffer = options[:buffer].new(name, window)
      window.post_init
      buffer.post_init
      return buffer
    end

    def initialize(options = {})
      args = parse_options(options)

      @win = Ncurses::WINDOW.new(*args)
      @panel = Ncurses::Panel.new_panel(@win)

      Ncurses::keypad @win, true

      # @win.nodelay false # true will block in C until we get input :(
      Ncurses.halfdelay 1
      @win.box ?| , ?- if @border
      @win.refresh

      @visible = true

      post_init
    end

    def post_init
    end

    def gety; Ncurses.getcury(@win) end
    def getx; Ncurses.getcurx(@win) end
    def move(y,x) @win.move(y,x) end
    def refresh; @win.refresh; end
    def color_set(color, arg = nil) @win.color_set(color, arg); end
    def getch; @win.getch; end

    def parse_options(hash)
      @width  = hash[:width]  || Ncurses.stdscr.getmaxx
      @height = hash[:height] || Ncurses.stdscr.getmaxy
      @border = hash[:border]
      @y = hash[:y] || 0
      @x = hash[:x] || 0

      return @height, @width, @y, @x
    end

    def delete
      Ncurses.delwin(@win)
    end

    def printw(string)
      return unless visible?
      @win.printw(string.gsub('%', '%%'))
    end

    def printlines(*lines)
      return unless visible?
      lines.flatten.each_with_index do |line, idx|
        break if idx >= (@height - 2)
        print_line_at idx, 0, line
      end
    end

    def print_line_at(y, x, line)
      move y, x
      printw line.to_s
      refresh
    end

    def print_color(string, color)
      color_set color
      printw string
      color_set Color[:normal, :white]
      refresh
    end

    def print_attr(string, attr)
      attrset attr
      printw string
      refresh
    end

    def clear
      printlines Array.new(height, ' ' * width)
    end

    def show
      Ncurses::Panel.show_panel @panel
      refresh
      @visible = true
    end

    def hide
      Ncurses::Panel.hide_panel @panel
      refresh
      @visible = false
    end

    def visible?
      @visible
    end
  end

  class TextWindow < Window
    attr_accessor :buffer

    LAYOUT = {:buffer => TextBuffer,
      :x => 0, :y => 0, :border => false }

    def initialize(options = {})
      options[:height] = Ncurses.stdscr.getmaxy - 3
      super
    end

    def post_init
      Buffer::LIST[:active] = buffer
      move 1, 1
    end
  end

  class StatusWindow < Window
    attr_accessor :buffer

    def initialize(options = {})
      options[:y] = Ncurses.stdscr.getmaxy - 3
      super
    end

    LAYOUT = {
      :buffer => StatusBuffer,
      :y => 0,
      :x => 0,
      :height => 3,
      :border => true
    }

    def post_init
      move 1, 1
    end
  end
end
