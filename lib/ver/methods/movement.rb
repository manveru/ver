module VER
  module Methods
    module Movement
      # Move cursor one character right
      def right
        cursor.right
      end

      # Move cursor one character left
      def left(but_only_until = 0)
        cursor.left(but_only_until)
      end

      # Move one line down until end of file
      def down
        cursor.down
      end

      # Move one line up until beginning of file
      def up
        cursor.up
      end

      # Move cursor half a screen down and recenter view around it
      def page_down
        view.scroll(window.height / 2)
        recenter_cursor
      end

      # Move cursor half a screen up and recenter view around it
      def page_up
        view.scroll(-(window.height / 2))
        recenter_cursor
      end

      # Jump to end of buffer
      def goto_end_of_buffer
        cursor.pos = cursor.buffer.size - 1
      end

      def goto_line(number)
        line = buffer.line_range(number..number)
        cursor.pos = line.begin
      end

      # Recenter view around cursor by adjusting the top offset
      def recenter_view
        y = cursor.to_y
        view.scroll(y - view.top - (window.height / 2))
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

      # Jump to beginning of current line
      def beginning_of_line
        cursor.beginning_of_line
      end

      # Jump to the end of line
      def end_of_line
        cursor.end_of_line
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
    end
  end
end
