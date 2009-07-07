module VER
  class Frame
    class Status < Frame
      def initialize(height = nil, width = nil, top = nil, left = nil)
        super(
          height || 1,
          width  || 0,
          top    || Curses.stdscr.maxy - 1,
          left   || 0
        )

        clear
      end

      def update(watched)
        line = {
          :y    => watched.cury,
          :x    => watched.curx,
          :begy => watched.begy,
          :maxy => watched.maxy,
          :begx => watched.begx,
          :maxx => watched.maxx,
        }

        setpos(0, 0)
        deleteln
        addstr(line.inspect)
        refresh
      end
    end
  end
end
