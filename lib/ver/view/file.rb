module VER
  class View
    class File < View
      module Methods
        # Completion

        def complete(what = nil)
          what ||= VER.complete.what || :word
          VER.complete.open(what, view)
        end

        def complete_line
          chunk = nil
          cursor.virtual do
            cursor.mark = cursor.bol
            cursor.pos = (cursor.eol - 1)
            chunk = cursor.to_s
          end

          regex = /^.*#{Regexp.escape(chunk)}.*$/
          lines = []
          buffer.scan(regex) do |line|
            lines << line.gsub(/\n/, '')
          end

          return chunk, lines
        end

        def complete_word
          word, range = cursor.current_word
          word ||= ''

          regex = /\b#{Regexp.escape(word)}\w*/
          words = buffer.to_s.scan(regex).uniq.grep(/\S/)

          return word, words
        end

        def complete_omni
        end

        def complete_file
          word, range = cursor.current_word(/\S+\z/, /\A\S+/)
          word, range = '', (cursor.pos...cursor.pos) unless word

          glob = "#{word}*"
          matches = Dir[glob]
          paths = []

          matches.map! do |match|
            if ::File.directory?(match)
              match = "#{match}/".squeeze('/')
            end

            paths << {:string => match, :range => range}
          end

          Log.debug word => paths
          return word, paths, skip = true
        end

        def complete_spell
          word, range = cursor.current_word

          spelling = aspell_word(word)
          spelling.map! do |spell|
            { :string => spell, :range => range }
          end

          return word, spelling, skip = true
        end

        def aspell_word(word)
          if result = aspell(word)[word.strip]
            result[:suggestions]
          else
            [word]
          end
        end

        ASPELL_PARSE = /^& (.*?) (\d+) (\d+): (.*)$/

        def aspell(string)
          results = {}

          Open3.popen3("aspell pipe"){|stdin, stdout, stderr|
            stdin.print("^#{string}")
            stdin.close
            result = stdout.read
            result.scan(ASPELL_PARSE) do |original, count, offset, suggestions|
              results[original] = {
                :count => count.to_i,
                :offset => offset.to_i,
                :suggestions => suggestions.split(', '),
              }
            end
          }

          return results
        end

        def toggle_case
          chunk = buffer[cursor.pos, 1]
          toggled = chunk.each_char.map{|char|
            downcased = char.downcase
            downcased == char ? char.upcase : downcased
          }
          buffer[cursor.pos, 1] = toggled.join
        end

        def indent_line
          change_indent(cursor.bol..cursor.eol, /^/, '  ')
        end

        def unindent_line
          change_indent(cursor.bol..cursor.eol, /^  /, '')
        end

        def change_indent(range, from, to)
          buffer[range] = buffer[range].gsub(from, to)
        end

        # NOTE:
        #   * This takes the line number, but in the interface lines start at
        #     1, not 0, that's why we decrement by one and check that we're not
        #     getting a negative result.
        def goto_line(number)
          number = [0, number.to_i - 1].max
          range = buffer.line_range(number..number)
          cursor.pos = range.begin
        end

        # same as N% in VIM (0 is beginning of line already)
        def goto_percent(number)
          number = [0, number.to_i, 100].sort[1]
          ln = (number * buffer.line_count + 99) / 100
          goto_line(ln)
          recenter_view
        end

        SAVE_AS_PROC = lambda{|got|
          [true, [got]]
        }

        def save_as_ask(close = false)
          VER.ask('Save as: ', SAVE_AS_PROC) do |path|
            VER.info("Saved as: #{buffer.save_file(path)}")
            view.buffer_close if close
          end
        end

        BUFFER_ASK_PROC = lambda{|got|
          buffer_names = View[:file].buffers.map{|b| b.filename }

          if got =~ /^\s+$/
            choices = buffer_names
          elsif got
            choices = buffer_names.grep(/#{Regexp.escape(got)}/)
          end

          valid = buffer_names.include?(got)

          [valid, choices]
        }

        def buffer_ask
          VER.ask('Buffer: ', BUFFER_ASK_PROC) do |name|
            view.buffer = name if name
          end
        end

        # FIXME:
        #   * should close buffer if modified scratch after asking for
        #     saving, but we lose control
        def buffer_close
          if buffer.scratch? and buffer.modified?
            file = buffer.short_filename

            VER.choice("Save changes to #{file}? ", Y_N_C) do |choice|
              case choice
              when 'yes'
                save_as_ask(close = true)
              when 'no'
                view.buffer_close
                view.open
              when 'cancel'
                view.open
              end
            end
          elsif buffer.modified?
            file = buffer.short_filename

            VER.choice("Save changes to #{file}? ", Y_N_C) do |choice|
              case choice
              when 'yes'
                buffer.save_file
                view.buffer_close
                view.open
              when 'no'
                view.buffer_close
                view.open
              when 'cancel'
                view.open
              end
            end
          else
            view.buffer_close
          end
        end

        Y_N_C = %w[yes no cancel].abbrev

        def buffer_close_context(got)
          if choice = Y_N_C[got.to_s.strip]
            return [true, [choice]]
          else
            return [false, %w[yes no cancel]]
          end
        end

        # FIXME: true number of lines
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
          choices = self.class.methods.grep(/#{regex}/).sort

          return true, choices
        end

        def search_ask
          VER.ask('Search: ', method(:search_ask_context)) do |search|
            view.refresh_search_highlight
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

        def search_word
          word, range = cursor.current_word
          if word
            view.search = /#{Regexp.escape(word)}/
            view.refresh_search_highlight
            search_next
          end
        end

        def search_next
          highlights = view.highlights[:search]
          sorted = highlights.sort_by{|c| [c.pos, c.mark].min }

          post_search(sorted){|c| c.pos > cursor.pos and c.mark > cursor.pos }
        end

        def search_previous
          highlights = view.highlights[:search]
          sorted = highlights.sort_by{|c| -[c.pos, c.mark].min }

          post_search(sorted){|c| c.pos < cursor.pos and c.mark < cursor.pos }
        end

        def post_search(sorted, &block)
          return unless coming = sorted.find(&block)
          view.cursor.pos = coming.pos
          view.adjust_pos
          view.refresh
        end

        # Selection

        def start_selection(selecting = nil)
          sel = view.selection = cursor.dup

          sel.meta = {:selecting => selecting}
          sel.pos = sel.mark = cursor.pos
          sel.color = Color[:white, :blue]
        end

        def operate_on_selection
          return unless prepare_selection

          yield(selection[:selecting])

          cursor.pos = selection.mark
          view.selection = nil
        end

        def prepare_selection
          return unless selection
          selection.pos = cursor.pos

          if selection[:selecting] == :linewise
            selection.end_of_line
            selection.invert!
            selection.beginning_of_line
            selection.invert!
          end

          return true
        end

        # General Selection operations

        def toggle_selection_case
          operate_on_selection do |selecting|
            range = selection.to_range
            buffer[range] = buffer[range].tr('A-Za-z', 'a-zA-Z')
          end
        end

        def indent_selection
          operate_on_selection do |selecting|
            change_indent(selection.to_range, /^/, '  ')
          end
        end

        def unindent_selection
          operate_on_selection do |selecting|
            change_indent(selection.to_range, /^  /, '')
          end
        end

        FILTER_SELECTION_ASK_PROC = lambda{|got|
          [true, [got]]
        }

        def filter_selection_ask
          VER.ask(
            'Filter selection through external program: ',
            FILTER_SELECTION_ASK_PROC
          ) do |cmd|
            operate_on_selection do |selecting|
              range = selection.to_range
              range = (range.begin..-1) if range.end >= (buffer.size - 1)
              Log.debug :range => range, :buffer_size => buffer.size

              Open3.popen3(cmd){|stdin, stdout, stderr|
                stdin.print(buffer[range])
                stdin.close
                output = stdout.read
                buffer[range] = output
              }
            end
          end
        end

        # Selection Copy

        def copy
          operate_on_selection do |selecting|
            selecting == :block ? copy_block : copy_selection
          end
        end

        # NOTE:
        #   * first line start can be cut off since the selection might not
        #     cover it, so we handle that case as well
        def copy_block
          from_x, to_x = [selection.to_x, selection.to_x(true)].sort
          lines = selection.to_s.split("\n")

          chunks = [lines.shift[0..(to_x - from_x)]]
          chunks.concat(lines.map{|l| l[from_x..to_x] })

          VER.clipboard.copy chunks
          VER.info("Copied #{chunks.size} chunks")
        end

        def copy_selection
          VER.clipboard.copy selection.to_s
          VER.info("Copied #{selection.delta} characters")
        end

        # Selection Cut

        def cut
          operate_on_selection do |selecting|
            selecting == :block ? cut_block : cut_selection
          end
        end

        # FIXME: Not so quick, but quite dirty
        def cut_block
          (pos_y, pos_x), (mark_y, mark_x) = selection.to_pos, selection.to_pos(true)
          from_y, to_y = [pos_y, mark_y].sort
          from_x, to_x = [pos_x, mark_x].sort
          lines = (from_y..to_y)

          chunks = []

          buffer.map! do |line|
            next unless lines.include?(line.number)

            chunks << line.line[from_x..to_x]
            line.line[from_x..to_x] = ''
            line.range = (line.range.begin..(line.range.end - 1))
            line.line
          end

          VER.clipboard.copy chunks
          VER.info("Cut #{chunks.size} chunks")
        end

        def cut_selection
          VER.clipboard.copy string = selection.to_s
          buffer[selection.to_range] = ''

          cursor.pos = selection.mark

          VER.info("Cut #{selection.delta} characters")
        end

        # Paste

        def paste_after
          case clip = VER.clipboard.last
          when String
            cursor.virtual{
              cursor.right
              cursor.insert(clip)
            }
          when Array
            cursor.virtual do
              clip.each do |chunk|
                cursor.virtual{ cursor.insert(chunk) }
                cursor.down
              end
            end
          else
            VER.info("Nothing in clipboard")
          end
        end

        def paste_before
          paste_after
        end

        # </Paste>

        def undo
          buffer.undo
        end

        def redo
          buffer.redo
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

        def ver_stop
          VER.stop
        end

        def jump_right(regex)
          buffer[cursor.pos..-1] =~ regex
          unless match = $~
            cursor.pos = buffer.size - 1
            return
          end

          left, right = $~.offset(0)

          if left == 0
            cursor.pos += right
            jump_right(regex)
          else
            cursor.pos += left
          end
        end

        def jump_left(regex)
          return if cursor.pos == 0
          cursor.left

          if jump = buffer[0...cursor.pos].rindex(regex)
            cursor.pos = jump + 1
          end
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
        :status_line => "%s (%s) [%s] (%s - %s)  -  %d,%d  -  Buffer %d/%d  -  %.0f%%"
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

        if @redraw or buffer.dirty? or selection
          window.move 0, 0
          draw_visible
          draw_padding

          # highlight_syntax
          refresh_search_highlight if search and buffer.dirty?
          highlight_search if search
          highlight_selection if selection
          buffer.dirty = false
          refresh
        end

        window.move(*pos) if pos

        draw_status_line
        @redraw = false
      end

      def draw_visible
        visible_each{|line| window.print(line) }
      end

      def draw_status_line
        color =
          case mode
          when    :insert; Color[:white, :red]
          when   :control; Color[:white, :blue]
          when :selection; Color[:white, :magenta]
          else           ; Color[:white, :black]
          end

        VER.status(status_line, color)
      end

      def status_line
        case buffer
        when FileBuffer
          file     = buffer.short_filename
          modified = buffer.modified? ? '+' : ' '
          eol = buffer.eol_name
        when MemoryBuffer
          file = '<MemoryBuffer>'
          modified = '+'
        else
          file, modified = '', '+'
        end

        eol ||= 'unix'
        row, col = (window.y + 1 + top), (@left + window.x + 1)
        n, m     = buffers.index(buffer) + 1, buffers.size
        syntax   = self.syntax ? self.syntax.name : 'Plain'
        percent  = (100.0 / buffer.line_count) * row

        mode = "#{self.mode}"
        mode = "#{mode} - #{selection[:selecting]}" if selection

        # objects = ObjectSpace.each_object{|o| }

        @status_line % [ file, eol, modified, syntax, mode, row, col, n, m, percent ]
      rescue ::Exception => ex
        VER.error(ex)
        ''
      end

      def buffer_close
        case @buffers.size
        when 0
          @buffers << @buffer = FileBuffer.new(:file, 'unnamed')
        when 1
          @buffers.delete(@buffer)
          buffer_close
        else
          @buffers.delete(@buffer)
          @buffer = @buffers.last
        end
      end

      def selection=(selection)
        @selection = selection

        if selection
          self.mode = :selection
          @selection.mark = @selection.pos
        else
          self.mode = :control
        end

        @redraw = true
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

      def refresh_search_highlight
        cursors = highlights[:search] = buffer.grep_successive_cursors(search)
        cursors.each{|c| c.color = colors[:search] }
      end

      def highlight_search
        highlights[:search].each{|cursor| highlight(cursor) }
      end

      def highlight_selection
        selection = self.selection.dup
        selection.pos = cursor.pos

        case selection[:selecting]
        when :linewise
          if selection.mark > selection.pos
            selection.mark = selection.eol(selection.mark)
            selection.pos  = selection.bol(selection.pos)
          else
            selection.mark = selection.bol(selection.mark)
            selection.pos  = selection.eol(selection.pos)
          end
        when :block
          (pos_y, pos_x), (mark_y, mark_x) = selection.to_pos, selection.to_pos(true)

          from_y, to_y = [pos_y, mark_y].sort
          from_x, to_x = [pos_x, mark_x].sort
          from_x -= @left; to_x -= @left
          to_x -= from_x

          color = selection.color

          (from_y..to_y).each do |y|
            highlight_line(color, y, from_x, to_x + 1)
          end

          return
        end

        highlight(selection)
      end

      def highlight_syntax
        return unless syntax

        center = cursor.pos

        if @last_range and @last_range.include?(center) and not buffer.dirty?
          visible = buffer.line_range(top..bottom)
          from, to = visible.begin, visible.end
        else
          offset = (window.height * window.width) / 2
          from, to = (center - offset), (center + offset)
          @last_range = ([0, from].max..[buffer.size, to].min)

          syntax.parse(buffer, @last_range)
        end

        syntax.matches.each do |match|
          next unless from <= match.pos and to >= match.mark

          (from_y, from_x), (to_y, to_x) = match.to_pos, match.to_pos(true)
          from_y -= @top; from_x -= @left; to_y -= @top; to_x -= @left

          window.highlight_line(match.color, from_y, from_x, to_x - from_x)
        end
      end

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
        window.highlight_line(color, y, x, max)
      end
    end
  end
end
