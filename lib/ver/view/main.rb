require 'ver/methods/main'

module VER
  class MainView < View
    METHODS = [ VER::Methods::Main ]
    INITIAL_MODE = :control
    STATUS_LINE = "%s [%s] (%s) %d,%d  Buffer %d/%d"

    def draw
      pos = adjust_pos
      @window.move 0, 0

      visible_each do |line|
        @window.print_line(line)
      end

      # fill up the rest
      (window.height - (window.y + 1)).times do
        @window.print_line("\n")
      end

      highlight_highlights
      highlight_selection

      VER.status(status_line)
      @window.move(*pos)
    end

    def status_line
      modified = buffer.modified? ? '+' : ' '
      file     = buffer.filename
      row, col = cursor.to_pos
      n, m     = @buffers.index(buffer) + 1, @buffers.size

      STATUS_LINE % [file, modified, mode, row + @top, col, n, m]
    rescue ::Exception => ex
      VER.error(ex)
      ''
    end

    def deactivate
      window.hide
    end

    def activate
      window.show
      window.color_set(Color[:white])
      draw
      focus_input
    end

    # Highlighting

    attr_accessor :selection
    attr_reader :highlights

    # FIXME: adjust using visible_each?
    def highlight_region(color, cursor)
      mark_y, mark_x = cursor.to_pos(from_mark = false)
      pos_y, pos_x = cursor.to_pos(from_mark = true)

      from_y, to_y = [mark_y, pos_y].sort
      from_x, to_x = [mark_x, pos_x].sort

      y_range = from_y..to_y
      x_range = from_x..to_x

      @window.color_set(color)

      visible_ys.each do |y|
        if y_range.include?(y)
          visible_xs.each do |x|
            if x_range.include?(x)
              @window.move(y, x)
              @window.printw('#')
            end
          end
        end
      end
    end

    # TODO:
    #   * abstract the low level code a bit...
    #   * at the moment it only takes into account starting x and ending x, it
    #     should also respect the width of each line
    def highlight(cursor, color)
      window = self.window # reduce lookups

      if cursor.mark >= cursor.pos
        (from_y, from_x), (to_y, to_x) = cursor.to_pos, cursor.to_pos(true)
      else
        (from_y, from_x), (to_y, to_x) = cursor.to_pos(true), cursor.to_pos
      end

      from_y -= @top; from_x -= @left; to_y -= @top; to_x -= @left

      if from_y == to_y # only one line
        highlight_line(color, from_y, from_x, to_x - from_x)
      else
        highlight_line(color, from_y, from_x)

        (from_y + 1).upto(to_y - 1) do |y|
          highlight_line(color, y)
        end

        highlight_line(color, to_y, 0, to_x)
      end
    end

    def highlight_line(color, y, x = 0, max = -1)
      return unless visible_pos?(y, x)
      window.move(y, x)
      window.wchgat(max, Ncurses::A_NORMAL, color, nil)
    end

    def highlight_selection
      return unless selection
      highlight(selection, Color[:white, :green])
    end

    def highlight_highlights
      highlights.each do |cursor|
        highlight(cursor, Color[:white, :blue])
      end
    end

    def highlights=(cursors)
      @highlights = cursors
      draw
    end

=begin
    # yields Enumerable::Enumerator
    def selections=(cursors)
      @selections = cursors.each
    end

    def next_selection
      @selections.next
    rescue StopIteration # wraparound
      @selections.rewind
      retry
    end

    def show_selections
      show_selection
      return unless @selections
      # Log.debug :selections => @selections.size
      highlight(Color[:white, :green], @selections)
    end
=end

  end
end
