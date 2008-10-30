module VER
  module Methods
    module Insert
      # Insert +char+ at position of cursor
      def insert_character(char = @key)
        cursor.insert(char)
      end

      # Insert space at position of cursor
      def insert_space
        insert_character ' '
      end

      # Insert newline at position of cursor
      def insert_return
        cursor.insert_newline
      end

      # Delete character preceeding cursor
      def insert_backspace
        cursor.insert_backspace
      end

      # Delete character after cursor
      def insert_delete
        cursor.insert_delete
      end

      # Insert a newline above current line, move to it and start insert mode
      def insert_newline_above_then_insert
        cursor.beginning_of_line
        cursor.insert_newline
        cursor.up
        into_insert_mode
      end

      # Insert line below current line, move to it and start insert mode
      def insert_newline_below_then_insert
        cursor.end_of_line
        cursor.insert_newline
        into_insert_mode
      end

      # Jump to end of line and start insert mode
      def append_at_end_of_line
        cursor.end_of_line
        into_insert_mode
      end

      # Move one character right and start insert mode
      def append
        right
        into_insert_mode
      end

      def replace(char)
        current = buffer[cursor.pos, 1]
        buffer[cursor.pos, 1] = char unless current == "\n"
      end

      # Takes the name of another method, sets a temporary cursor and performs
      # given movement, taking the delta between old and temporary cursor and
      # performing a delete on it.
      # After this it will restore the old cursor
      def delete_movement(movement, *args)
        old = cursor
        buffer.cursor = buffer.new_cursor(old.pos, old.pos)
        send(movement, *args)
        buffer.cursor.pos -= 1
        delete
        old.rearrange
        buffer.cursor = old
      end

      # Delete contents of buffer between cursor.pos and cursor.mark, stops selecting
      def delete
        buffer[cursor.to_range] = ''
        cursor.pos = cursor.mark
        stop_selection
        cursor.rearrange
      end

      def delete_line
        temp = buffer.new_cursor(cursor.bol, cursor.eol)
        buffer[temp.to_range] = ''
        cursor.rearrange
      end

      # Delete until the end of the current line
      def delete_to_end_of_line
        temp = buffer.new_cursor(cursor.pos, cursor.pos)
        temp.mark = temp.eol
        Log.debug temp.to_range
        buffer[temp.to_range] = ''
      end

      # Jump to beginning of line and start insert mode
      def insert_at_beginning_of_line
        cursor.beginning_of_line
        into_insert_mode
      end

      def delete_selection
        return unless selection = view.selection

        buffer[selection.to_range] = ''

        cursor.pos = selection.mark
        stop_selection
      end
    end
  end
end
