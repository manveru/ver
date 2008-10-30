module VER
  class View
    class File < View
      LAYOUT = {
        :height => lambda{|height| height - 2 },
        :top => 0, :left => 0,
        :width => lambda{|width| width }
      }

      DEFAULT = {
        :mode        => :control,
        :methods     => [Methods::Control, Methods::Insert],
        :interactive => true,
        :status_line => "%s [%s] (%s) %d,%d  Buffer %d/%d",
      }

      attr_accessor :status_line, :selection

      def initialize(*args)
        super
        @status_line = @options[:status_line]
      end

      def draw
        pos = adjust_pos
        window.move 0, 0

        draw_visible
        draw_padding
        draw_status_line
        highlight_selection
      ensure
        refresh
        Log.debug :pos => pos
        window.move(*pos) if pos
      end

      def draw_visible
        visible_each do |line|
          window.print line
        end
      end

      def draw_status_line
        VER.status status_line
      end

      def status_line
        modified = buffer.modified? ? '+' : ' '
        file     = buffer.filename
        row, col = cursor.to_pos
        row, col = row + top + 1, col + 1
        n, m     = buffers.index(buffer) + 1, buffers.size

        @status_line % [file, modified, mode, row + top, col, n, m]
      rescue ::Exception => ex
        VER.error(ex)
        ''
      end

      def highlight_selection
        return unless selection
        selection.end_of_line if selection[:linewise]
        highlight(selection, Color[:white, :green])
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
    end
  end
end
