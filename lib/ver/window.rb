module VER
  # Responsibilities:
  # * Interface to Ncurses::Window and Ncurses::Panel
  # * hide and show itself

  class Window < Ncurses::Window
    attr_reader :width, :height, :top, :left
    attr_accessor :layout

    def initialize(layout)
      reset_layout(layout)

      super(height, width, top, left)
      @panel = Ncurses::Panel.new(self)

      keypad true
    end

    def resize_with(layout)
      reset_layout(layout)
      wresize(height, width)
      wmove(top, left)
      replace_panel
    end

    %w[width height top left].each do |side|
      eval(
      "def #{side}=(n)
         return if n == #{side}
         @layout[:#{side}] = n
         resize_with @layout
       end"
      )
    end

    def resize
      resize_with(@layout)
    end

    # Ncurses

    alias pos getyx
    alias y getcury
    alias x getcurx

    def x=(n) move(y, n) end
    def y=(n) move(n, x) end

    def move(y, x)
      super if visible?
    end

    def print(string, width = width)
      waddnstr(string.to_s, width) if visible?
    end

    def print_yx(string, y = 0, x = 0)
      mvwaddnstr(y, x, string, width) if visible?
    end

    def print_empty_line
      printw(' ' * width) if visible?
    end

    def print_line(string)
      print(string.ljust(width)) if visible?
    end

    def show_colored_chunks(chunks)
      return unless visible?
      chunks.each do |color, chunk|
        wcolor_set(color)
        print_line(chunk)
      end
    end

    def puts(*strings)
      print(strings.join("\n") << "\n") if visible?
    end

    def refresh
      Ncurses::Panel.update_panels if visible?
    end

    def wnoutrefresh
      Ncurses::Panel.update_panels if visible?
    end

    def color=(color)
      wcolor_set @color = color if visible?
    end

    def highlight_line(color, y, x, max)
      mvwchgat(y, x, max, Ncurses::A_NORMAL, color) if visible?
    end

    def getch
      wgetch
    rescue Interrupt
      3 # is C-c
    end

    def clear
      wclear if visible?
    end

    # setup and reset

    def reset_layout(layout)
      @layout = layout

      [:height, :width, :top, :left].each do |name|
        instance_variable_set("@#{name}", layout_value(name))
      end
    end

    def layout_value(name)
      value = @layout[name]
      default = default_for(name)

      value = value.call(default) if value.respond_to?(:call)
      return (value || default).to_i
    end

    def default_for(name)
      case name
      when :height, :top
        Ncurses.getmaxy(Ncurses.stdscr)
      when :width, :left
        Ncurses.getmaxx(Ncurses.stdscr)
      else
        0
      end
    end

    # Ncurses panel

    def hide
      @panel.hide
      Ncurses::Panel.update_panels
    end

    def show
      @panel.show
      Ncurses::Panel.update_panels
    end

    def on_top
      @panel.top
      Ncurses::Panel.update_panels
    end

    def on_bottom
      @panel.bottom
      Ncurses::Panel.update_panels
    end

    def move_panel(y, x)
      @panel.move(y, x)
      Ncurses::Panel.update_panels
    end
    # making sure that we use the right method.
    alias wmove move_panel

    def replace_panel(pointer = nil)
      pointer ||= self.pointer
      @panel.replace_panel(pointer)
      Ncurses::Panel.update_panels
    end

    def visible?
      @panel.hidden?
    end
  end
end
