module VER
  # TODO:
  #   * Add the A_ constants, but they need set_attr
  #   * Add 256 colors if possible
  module Color
    NAME_COLOR = {}

    COLOR_CONSTANTS = Ncurses.constants.grep(/^COLOR_/)

    # Filling NAME_COLOR
    COLOR_CONSTANTS.each do |const|
      key = const[/^.*?_(.*)/, 1].downcase
      NAME_COLOR[key] = Ncurses.const_get(const)
    end

    # Cache for created colors
    COLOR = {}

    module_function

    def [](*args)
      COLOR[args] ||= create_color(*args)
    end

    def start
      Ncurses.start_color
      setup_default_colors
    end

    def background
      @background ||= determine_background
    end

    def setup_default_colors(bg = background)
      Color[:white]
      Color[:blue]
    end

    def determine_background
      bg = Ncurses::COLOR_BLACK
      bg = -1 if Ncurses.use_default_colors == Ncurses::OK
    rescue NameError
      bg
    end

    # Ncurses.init_pair(1, Ncurses::COLOR_BLUE, bg);
    # Ncurses.init_pair(2, Ncurses::COLOR_CYAN, bg);

    def create_color(fg, bg = nil)
      bg = bg ? fetch(bg) : background
      idx = COLOR.size

      Ncurses.init_pair(idx, fetch(fg), bg)

      return idx
    end

    def fetch(name)
      NAME_COLOR[name.to_s.downcase] or raise("No color for: %p" % name)
    end
  end
end
