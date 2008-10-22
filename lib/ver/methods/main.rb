require 'ver/methods/switch'
require 'ver/methods/buffer'

module VER
  module Methods
    module Main
      include Switch
      include Buffer

      def insert_character(char = @key)
        cursor.insert(char)
      end

      def insert_space
        cursor.insert(' ')
      end

      def insert_return
        cursor.insert_newline
      end

      def insert_backspace
        cursor.insert_backspace
      end

      def insert_delete
        cursor.insert_delete
      end

      def right
        cursor.right
      end

      def left(but_only_until = 0)
        cursor.left(but_only_until)
      end

      def down
        cursor.down
      end

      def up
        cursor.up
      end

      def page_down
        view.scroll(window.height / 2)
        recenter_cursor
      end

      def page_up
        view.scroll(-(window.height / 2))
        recenter_cursor
      end

      def goto_end_of_buffer
        cursor.pos = cursor.buffer.size - 1
      end

      def recenter_view
        y = cursor.to_y
        view.scroll(y - view.top - (window.height / 2))
      end

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

      def beginning_of_line
        cursor.beginning_of_line
      end

      def end_of_line
        cursor.end_of_line
      end

      def insert_newline_above_then_insert
        cursor.beginning_of_line
        cursor.insert_newline
        cursor.up
        into_insert_mode
      end

      def insert_newline_below_then_insert
        cursor.end_of_line
        cursor.insert_newline
        into_insert_mode
      end

      def append_at_end_of_line
        cursor.end_of_line
        into_insert_mode
      end

      def append
        right
        into_insert_mode
      end

      def undo
        buffer.undo
      end

      def unundo
        buffer.unundo
      end

      def start_selection
        cursor.mark = cursor.pos
        view.selection = cursor
      end

      def start_selecting_line
        cursor.mark = cursor.bol
        cursor.pos = cursor.eol
        view.selection = cursor
      end

      def stop_selection
        view.selection = nil
      end

      def copy(cursor = cursor)
        VER.clipboard << buffer[cursor.to_range]
        stop_selection
      end

      def paste_before
        text = VER.clipboard.last
        buffer[cursor.pos, 0] = text
        cursor.pos += text.size
      end

      def paste_after
        text = VER.clipboard.last
        buffer[cursor.pos, 0] = text
      end

      def replace(char)
        buffer[cursor.pos, 1] = char
      end

      # install temporary cursor, perform movement, use pos..mark to delete
      def delete_movement(movement, *args)
        old = cursor
        buffer.cursor = buffer.new_cursor(old.pos, old.pos)
        send(movement, *args)
        delete
        old.pos = [old.pos, buffer.size - 1].min
        buffer.cursor = old
      end

      def delete
        buffer[cursor.to_range] = ''
        cursor.pos -= cursor.delta
        stop_selection
      end

      def delete_to_end_of_line
        line = current_line
        line[cursor_x, line.size] = ""
        line.store!
      end

      def insert_at_beginning_of_line
        beginning_of_line
        into_insert_mode
      end

      def window_resize
        View.resize
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
          word_right
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

      WORD_RIGHT = %r([\w.-]+)
      def word_right
        jump_right(WORD_RIGHT)
      end

      WORD_LEFT = %r([^\w.-]+)
      def word_left
        jump_left(WORD_LEFT)
      end

      CHUNK_RIGHT = %r(\S+)
      def chunk_right
        jump_right(CHUNK_RIGHT)
      end

      CHUNK_LEFT = %r(\s+)
      def chunk_left
        jump_left(CHUNK_LEFT)
      end

      def show_help
        VER.help
      end

      EXECUTE_PROC = lambda{|got|
        methods = View.active.methods.singleton_methods.map{|m| m.to_s }
        choices = methods.grep(/^#{got}/)
        valid = methods.include?(got)
        [valid, choices]
      }

      def execute(command = nil)
        if command
          send(*command.to_s.split)
        else
          VER.ask('Execute: ', EXECUTE_PROC) do |cmd|
            send(*cmd.split) if cmd
            View.active.draw
          end
        end
      end

      # TODO: use irbs completion proc?
      RUBY_FILTER_PROC = lambda{|got| }

      def ruby_filter
        VER.ask('Ruby filter: text.', RUBY_FILTER_PROC) do |ruby|
        end
      end

      ASK_HELP_PROC = lambda{|got| }

      def ask_help
        VER.ask('Help: ', HELP_PROC) do |topic|
          VER.help(topic)
        end
      end

      # FIXME: Ruby is very, very, noisy on invalid regular expressions and may
      #       raise two different errors. the raising we can deal with, but
      #       without closing $stderr the warnings are unstoppable.
      #       So we try to use one of the many hacks from DHH (found in facets)
      SEARCH_PROC = lambda{|got|
        valid = false

        unless got.empty?
          view = View.active

          begin
            require 'ver/silence'
            silently do
              if got == got.downcase # go case insensitive
                regex = /#{got}/i
              else
                regex = /#{got}/
              end

              cursors = view.buffer.grep_cursors(regex)
              valid = true unless cursors.empty?
              view.highlights = cursors
            end
          rescue RegexpError, SyntaxError => ex
            Log.error(ex)
            View[:ask].draw_exception(ex)
          end

          view.draw
          view.window.refresh
        end

        [valid, [got]]
      }

      def search
        VER.ask('Search: ', SEARCH_PROC) do |regex|
          # view.highlights = view.buffer.grep_cursors(/#{regex}/i)
          next_highlight
          View.active.draw
        end
      end

      def next_highlight
        sorted = view.highlights.sort_by{|c| [c.pos, c.mark].min }
        if coming = sorted.find{|c| c.pos > cursor.pos and c.mark > cursor.pos }
          view.cursor.pos = coming.pos
        end
      end

      def previous_highlight
        sorted = view.highlights.sort_by{|c| -[c.pos, c.mark].min }

        if coming = sorted.find{|c| c.pos < cursor.pos and c.mark < cursor.pos }
          view.cursor.pos = coming.pos
        end
      end

      def window_resize
        View::LIST.each{|name, view| view.window_resize }
      end
    end
  end
end
