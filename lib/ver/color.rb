module VER
  # TODO:
  #   * Add the A_ constants, but they need set_attr
  #   * Add 256 colors if possible
  module Color
    ANSI_COLORS = [
      [0x00, 0x00, 0x00],
      [0xcd, 0x00, 0x00],
      [0x00, 0xcd, 0x00],
      [0xcd, 0xcd, 0x00],
      [0x00, 0x00, 0xcd],
      [0xcd, 0x00, 0xcd],
      [0x00, 0xcd, 0xcd],
      [0xe5, 0xe5, 0xe5],
      [0x4d, 0x4d, 0x4d],
      [0xff, 0x00, 0x00],
      [0x00, 0xff, 0x00],
      [0xff, 0xff, 0x00],
      [0x00, 0x00, 0xff],
      [0xff, 0x00, 0xff],
      [0x00, 0xff, 0xff],
      [0xff, 0xff, 0xff],
    ]

    steps = [0x00, 0x5f, 0x87, 0xaf, 0xd7, 0xff]
    steps.each do |r|
      steps.each do |g|
        steps.each do |b|
          ANSI_COLORS << [r, g, b]
        end
      end
    end

    8.step 238, 10 do |n|
      ANSI_COLORS << [n, n, n]
    end

    COLOR_CONSTANTS = Ncurses.constants.grep(/^COLOR_/)
    NAME_COLOR = {}

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
      if found = NAME_COLOR[name.to_s.downcase]
        return found
      elsif name.respond_to?(:to_int)
        return name.to_int
      elsif name.respond_to?(:each_char)
        return ANSI_COLORS.index(hex_to_ansi_rgb(name))
      end

      raise("No color for: %p" % name)
    end

    # Give it any hex String in the 'RRGGBB' format, it will return the closest
    # ANSI RGB value.
    #
    # @example Usage
    #
    #   hex_to_ansi_rgb('a0afaf') # => [175, 175, 175]
    #
    # TODO: try to make the needle creation faster, pack/unpack might work, but
    #       couldn't figure out how...
    def hex_to_ansi_rgb(hex)
      r, g, b = hex.each_char.each_slice(2).map{|e| e.join.to_i(16) }
      rgb_to_ansi_rgb(r, g, b)
    end

    # @example Usage
    #
    #   rgb_to_ansi_rgb(64, 175, 175) # => [95, 175, 175]
    def rgb_to_ansi_rgb(*rgb)
      ANSI_COLORS.min_by{|color| color.zip(rgb).map{|l,r| (l - r).abs }.inject(:+) }
    end

    def rgb_to_ansi_int(*rgb)
      ANSI_COLORS.index(rgb)
    end
  end
end
