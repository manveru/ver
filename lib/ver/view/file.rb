module VER
  class View
    class File < View
      module Methods
        # NOTE:
        #   * This takes the line number, but in the interface lines start at
        #     1, not 0, that's why we decrement by one and check that we're not
        #     getting a negative result.
        def goto_line(number)
          number = [0, number.to_i - 1].max
          range = buffer.line_range(number..number)
          cursor.pos = range.begin
        end

        BUFFER_ASK_PROC = lambda{|got|
          buffer_names = View[:file].buffers.map{|b| b.filename }
          choices = buffer_names.grep(/#{got}/)
          [got, choices]
        }

        def buffer_ask
          VER.ask('Buffer: ', BUFFER_ASK_PROC) do |name|
            view.buffer = name if name
          end
        end

        GOTO_LINE_ASK_PROC = lambda{|got|
          [true, *(0..100)]
        }

        def goto_line_ask
          VER.ask('Line: ', GOTO_LINE_ASK_PROC) do |line|
            goto_line(line)
          end
        end

        def execute_ask
          VER.ask('Eval: ', method(:execute_ask_context)) do |line|
            result = eval(line.to_s)
            VER.info(result.inspect)
          end
        end

        def execute_ask_context(got)
          regex = Regexp.escape(got)
          choices = methods.grep(/#{regex}/).sort

          return true, choices
        end

        def search_ask
          VER.ask('Search: ', method(:search_ask_context)) do |search|
            search_results_highlight
            search_next
          end
        end

        def search_ask_context(got)
          valid = false

          return valid, [got] if got.empty?

          silently do
            if got == got.downcase
              regex = /#{got}/i
            else
              regex = /#{got}/
            end

            valid = true
            view.search = regex
            VER.info(regex.inspect)
          end

          return valid, [got]
        rescue RegexpError, SyntaxError => ex
          VER.error(ex)
          return valid, [got]
        end

        def search_results_highlight
          cursors = view.highlights[:search] = buffer.grep_successive_cursors(view.search)
          cursors.each{|c| c.color = view.colors[:search] }
        end

        def search_next
          highlights = view.highlights[:search]
          sorted = highlights.sort_by{|c| [c.pos, c.mark].min }

          if coming = sorted.find{|c| c.pos > cursor.pos and c.mark > cursor.pos }
            view.cursor.pos = coming.pos
          end
        end

        def search_previous
          highlights = view.highlights[:search]
          sorted = highlights.sort_by{|c| -[c.pos, c.mark].min }

          if coming = sorted.find{|c| c.pos < cursor.pos and c.mark < cursor.pos }
            view.cursor.pos = coming.pos
          end
        end

        def cut
          string = view.selection.to_s
          VER.clipboard << string
          VER.info("Cut #{string.size} characters")
          buffer[view.selection.to_range] = ''
          cursor.pos = view.selection.mark
          view.selection = nil
        end

        def copy
          string = view.selection.to_s
          VER.clipboard << string
          VER.info("Copied #{string.size} characters")
          view.selection = nil
        end

        def copy_lines
          sel = view.selection ||= cursor.dup
          sel.end_of_line
          sel.invert!
          sel.beginning_of_line
          sel.invert!
          copy
        end

        def page_down
          view.scroll(window.height)
          recenter_cursor
        end

        def page_up
          if view.top == 0
            cursor.pos = 0
          else
            view.scroll(-window.height)
            recenter_cursor
          end
        end

        def scroll(n)
          view.scroll(n)
          view.adjust_pos
        end

        def recenter_view
          view.scroll(cursor.to_y - view.top - (window.height / 2))
        end

        # Recenter cursor into the middle of view
        def recenter_cursor
          center = view.top + (window.height / 2)
          cursor = self.cursor
          y = cursor.to_y

          if y < center
            (center - y).times{ cursor.down }
          elsif y > center
            (y - center).times{ cursor.up }
          end
        end

        def start_selection
          sel = view.selection = cursor.dup
          sel.mark = cursor.pos
          sel.color = view.colors[:search]
        end
      end

      LAYOUT = {
        :height => lambda{|height| height - 2 },
        :top => 0, :left => 0,
        :width => lambda{|width| width }
      }

      DEFAULT = {
        :mode        => :control,
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
        VER.info(VER.info.buffer.to_s) # FIXME

        window.move(*pos) if pos
        refresh
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
#         objects = ObjectSpace.each_object{|o| }

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
