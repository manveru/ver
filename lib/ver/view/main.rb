require 'ver/methods/main'

module VER
  class MainView < View
    METHODS = [ VER::Methods::Main ]
    INITIAL_MODE = :control

    def highlight(color, *cursors)
      cursors.each do |cursor|
        y, x = cursor.to_pos

        next unless visible_pos?(y, x)
        y -= @top

        @window.move(y, x)
        @window.color_set(color)
        @window.printw @buffer[cursor.to_range]
      end

      @window.refresh
      @window.move(*adjust_pos)
      # @skip_draw = true
    end

    def selection=(cursor)
      @selection = cursor
    end

    def show_selection
      return unless @selection
      highlight(Color[:white, :green], @selection)
    end

    def selections=(cursors)
      @selections = cursors
    end

    def show_selections
      show_selection
      return unless @selections
      # Log.debug :selections => @selections.size
      highlight(Color[:white, :green], *@selections)
    end

    def draw
      pos = adjust_pos
      last = 0
      @window.color_set Color[:white]
      @window.move 0, 0

      visible_each do |line|
        @window.print_line(line)
      end

      @window.color_set Color[:yellow]
      (window.height - (window.y + 1)).times do
        @window.print_line("~\n")
      end

      VER.status(status_line)
      @window.move(*pos)
      show_selections
    end

    STATUS_LINE = "%s [%s] (%s) %d,%d  Buffer %d/%d"

    def status_line
      modified = buffer.modified? ? '+' : ' '
      file     = buffer.filename
      modes    = @modes.join(',')
      row, col = cursor.to_pos
      n, m     = @buffers.index(buffer) + 1, @buffers.size

      STATUS_LINE % [file, modified, modes, row + @top, col, n, m]
    rescue ::Exception => ex
      VER.error(ex)
      ''
    end

    def deactivate
      window.hide
    end

    def activate
      window.show
      draw
      focus_input
    end
  end
end
