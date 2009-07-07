module VER
  class Frame
    class View < Frame
      def initialize(height = nil, width = nil, top = nil, left = nil)
        super(
          height || Curses.stdscr.maxy - 1,
          width  || 0,
          top    || 0,
          left   || 0
        )

        scrollok true
        setscrreg 0, maxy
        idlok true
        setpos 0, 0
        clear

        CHANNEL.subscribe do |message|
          message.each do |method, arguments|
            case method
            when :key
              key(arguments)
            when :login
              setpos(0, 0)
              deleteln
              addstr(arguments.inspect)
              refresh
            else
              p method => arguments
            end
          end
        end
      end

      def key(key)
        case key
        when 'C-q'
          exit
        end
      end

      def update
        refresh
      end

      def show(buffer)
        @line = @col = 0
      end
    end
  end
end
