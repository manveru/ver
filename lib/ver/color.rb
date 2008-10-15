module VER
  module Color
    NAME_COLOR = {}

    COLOR_CONSTANTS = Ncurses.constants.grep(/^(COLOR|A)_/)

    # Filling NAME_COLOR
    COLOR_CONSTANTS.each do |const|
      key = const[/^.*?_(.*)/, 1].downcase
      NAME_COLOR[key] = Ncurses.const_get(const)
    end

    # Cache for created colors
    COLOR = {}

    def self.[](bg, fg, *fg_rest)
      key = [bg, fg, *fg_rest]
      COLOR[key] ||= create_color(*key)
    end

    private

    def self.create_color(bg, fg, *fg_rest)
      idx = COLOR.size
      Log.debug("create_color(%p, %p, %p)" % [bg, fg, fg_rest])
      combined_fg = fg_rest.inject(fetch(fg)){|s,v| s | fetch(v) }
      Ncurses.init_pair(idx, combined_fg, fetch(bg) )
      return idx
    end

    def self.fetch(name)
      c = NAME_COLOR[name.to_s.downcase] or raise("No color for: %p" % name)
      Log.debug("%p: %p" % [name, c])
      Log.debug NAME_COLOR
      c
    end
  end
end
