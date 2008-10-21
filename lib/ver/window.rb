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

    def initialize(&block) # height, width, top, left)
      setup(&block)
      @visible = true
    end

    def height; @options[:height] end
    def width; @options[:width] end
    def left; @options[:left] end
    def top; @options[:top] end

    def setup(&block)
      @setup = block if block
      @options = @setup.call

      @panel.delete if @panel
      @window.delete if @window
      @window = Ncurses::WINDOW.new(height, width, top, left)
      @panel = Ncurses::Panel.new_panel(@window)

      Ncurses::keypad(@window, true)
    end

    # Ncurses

    def resize
      setup
    end

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

    # FIXME:
    #   * printw seems to use printf which interprets stuff starting with '%'
    #   * line endings have to be correct for the terminal
    #     on linux at least it has to be \n
    def printw(string)
      return unless visible?
      line = string.to_s.gsub(/[\r\n]/, "\n").gsub(/%/, '%%')
      @window.printw(line)
    end

    def print_line(string)
      return unless visible?
      @window.waddnstr(string.to_s, width)
    end

    def print_empty_line
      return unless visible?
      @window.printw(' ' * width)
    end

    def show_colored_chunks(chunks)
      return unless visible?
      chunks.each do |color, chunk|
        color_set(color)
        printw(chunk.to_s)
      end
    end

    def refresh
      return unless visible?
      @window.refresh
    end

    def color_set(color, arg = nil)
      @window.color_set(color, arg)
    end

    def getch
      @window.getch
    rescue Interrupt => ex
      3 # is C-c
    end

    def clear
      return unless visible?
      move 0, 0
      printw Array.new(height){ (' ' * (width - 1))}.join("\n")
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
