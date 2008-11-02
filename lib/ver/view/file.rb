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
        :status_line => "%s [%s] (%s - %s) %d,%d  Buffer %d/%d",
      }

      attr_accessor :status_line, :redraw, :highlights
      attr_reader :search, :colors

      def initialize(*args)
        super
        @status_line = @options[:status_line]
        @highlights = { :search => [] }
        @colors = {
          :search    => Color[:white, :blue],
          :selection => Color[:white, :green],
        }
        @redraw = true
        @threads = []
      end

      def draw
        pos = adjust_pos
        window.move 0, 0

        if @redraw or buffer.dirty? or selection
          draw_visible
          draw_padding

          highlight_syntax
          highlight_search if search
          highlight_selection if selection
          buffer.dirty = false
        end

        VER.status status_line

        refresh
        window.move(*pos) if pos
        @redraw = false
      end

      def redraw?
        @redraw
      end

      def draw_visible
        visible_each{|line| window.print(line) }
      end

      def status_line
        modified = buffer.modified? ? '+' : ' '
        file     = buffer.filename
        row, col = cursor.to_pos
        row, col = row + top + 1, col + left + 1
        n, m     = buffers.index(buffer) + 1, buffers.size
        syntax   = syntax ? syntax.name : 'Plain'

        @status_line % [file, modified, syntax, mode, row + top, col, n, m]
      rescue ::Exception => ex
        VER.error(ex)
        ''
      end

      def selection=(s)
        @selection = s
        @redraw = true unless s
      end

      def search=(regex)
        @search = regex
        if hl = buffer.grep_cursor(regex, cursor.pos)
          hl.color = @colors[:search]
          highlights[:search] = [hl]

          @redraw = true
          draw
        else
          highlights[:search].clear
        end
      end

      def highlight_search
        highlights[:search].each{|cursor| highlight(cursor) }
      end

      def highlight_selection
        selection.pos = cursor.pos
        selection.end_of_line if selection[:linewise]

        highlight(selection)
      end

      def highlight_syntax
        return unless syntax

        if syntax.matches.empty? or buffer.dirty?
          syntax.parse(buffer)
        end

        syntax.matches.each do |cursor|
          highlight(cursor)
        end
#         @threads.each{|t|
#           t.kill unless visible_cursor?(t[:cursor])
#         }
#         @threads.delete_if{|t| not t.alive? }
#
#         @threads += syntax.matches.map{|cursor|
#           Thread.new{
#             Thread.current[:cursor] = cursor
#             sleep 1
#             highlight(cursor)
#           }
#         }
      end

      # TODO:
      #   * abstract the low level code a bit...
      #   * at the moment it only takes into account starting x and ending x, it
      #     should also respect the width of each line
      def highlight(cursor, color = cursor.color)
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
