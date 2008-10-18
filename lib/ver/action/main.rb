module VER
  class MainAction < Action
    def up
      return unless prev = @buffer.line_at(view_y - 1)
      prev_end = prev.size - 2

      if cursor_y <= @window.top
        @view.scroll -1
      else
        @window.move(cursor_y - 1, cursor_x)
        @window.move(cursor_y, prev_end) if prev_end < cursor_x
      end

      return true
    end

    def down
      return unless following = @buffer.line_at(view_y + 1)
      following_end = following.size - 2

      if (cursor_y + 1) < @window.height
        @window.move(cursor_y + 1, cursor_x)
        @window.move(cursor_y, following_end) if following_end < cursor_x
      else
        @view.scroll(1)
      end

      return true
    end

    def left
      if cursor_x == 0
        end_of_line if up
      else
        @window.move(cursor_y, cursor_x - 1)
      end
    end

    def right
      offset = cursor_x + 1

      if offset > (current_line.size - 2)
        beginning_of_line if down
      elsif @window.width >= offset
        @window.move(cursor_y, offset)
      else
        beginning_of_line if down
      end
    end

    def beginning_of_line
      @window.move(cursor_y, 0)
    end

    def end_of_line
      @window.move(cursor_y, current_line.size - 2)
    end

    def word_right
      this_line, following_line = @buffer.lines_at(view_y, view_y + 1)

      if offset = this_line.to_s.index(WORD_BREAK, cursor_x + 1)
        @window.move(cursor_y, offset + 1)
      elsif following_line
        down
        beginning_of_line
        word_right
      else
        end_of_line
      end
    end

    def chunk_right
      this_line, following_line = @buffer.lines_at(view_y, view_y + 1)

      if offset = this_line.to_s.index(CHUNK_BREAK, cursor_x + 1)
        @window.move(cursor_y, offset + 1)
      elsif following_line
        down
        beginning_of_line
        word_right
      else
        end_of_line
      end
    end

    def word_left
      prev, this = @buffer.lines_at(view_y - 1, view_y)

      if offset = this.to_s.rindex(WORD_BREAK, cursor_x)
        @window.move(cursor_y, offset - 1)
      elsif prev
        up
        end_of_line
        word_left
      end
    end

    def chunk_left
      prev, this = @buffer.lines_at(view_y - 1, view_y)

      if offset = this.to_s.rindex(CHUNK_BREAK, cursor_x)
        @window.move(cursor_y, offset - 1)
      elsif prev
        up
        end_of_line
        word_left
      end
    end

    def insert_newline_below
      line = current_line
      line.append("\n")
      line.store!
    end

    def insert_newline_above
      line = current_line
      line.prepend("\n")
      line.store!
    end

    def insert_newline_below_then_insert
      insert_newline_below
      down
      into_insert_mode
    end

    def insert_newline_above_then_insert
      insert_newline_above
      up
      into_insert_mode
    end

    def append_at_end_of_line
      end_of_line
      append
    end

    def append
      right
      into_insert_mode
    end

    def undo
      @buffer.undo
    end

    def unundo
      @buffer.unundo
    end

    def join_line_up
      prev, this = @buffer.lines_at(view_y - 1, view_y)
      prev.join!(this) if prev
    end

    def join_line_down
      this, following = @buffer.lines_at(view_y, view_y + 1)
      this.join!(following) if following
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

    def insert_return
      insert_string_here("\n")
      down
      beginning_of_line
    end

    def insert_backspace
      if cursor_x == 0
        join_line_up
      else
        line = current_line
        line[cursor_x - 1, 1] = ''
        line.store!
        left
      end
    end

    def insert_delete
      line = current_line
      line[cursor_x, 1] = ''
      line.store!
    end

    def insert_space
      insert_string_here(' ')
    end

    def insert_character
      insert_string_here(@key)
    end

    def window_resize
      View.resize
    end

    def buffer_persist
      filename = @buffer.save_file
      VER.info "Saved to: #{filename}"
    end

    def buffer_close
      if @buffer.modified?
        file = @buffer.filename
        options = %w[yes no cancel]
        answers = options.abbrev

        answer = VER.ask("Save changes to #{@buffer.filename}?"){|got|
          if found = answers[got]
            found
          else
            options
          end
        }
      end

      throw(:close)
    end

    def buffer_open
      filename = VER.ask("File:"){|got|
        first, *rest = all = Dir["#{got}*"]

        if first and rest.empty?
          first
        elsif first
          all
        end
      }

      @view.buffer = filename
    end

=begin
    def buffer_toggle
      main = View[:main]
      Log.debug :visible => main.window.visible?
      main.window.visible? ? main.hide_window : main.show_window
    end
=end

    def show_help
      VER.help
    end

    # mode switching

    def into_control_mode
      into_mode :control
    end

    def into_replace_mode
      into_mode :replace
    end

    def into_insert_mode
      into_mode :insert
    end

    private

    def into_mode(name)
      return if @mode == name
      left if name == :control
      @view.modes = [name]
    end

    def current_line
      line = @buffer.line_at(view_y)
      return line unless block_given?

      yield(line)
      line.store!
    end

    def insert_string_here(string)
      line = current_line
      line[cursor_x, 0] = string
      @window.move(cursor_y, cursor_x + string.size)
      line.store!
    end

    def view_y
      cursor_y + @view.offset
    end

    def pos
      @window.pos
    end
  end
end
