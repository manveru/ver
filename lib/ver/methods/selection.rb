module VER
  module Methods
    module Selection
      def start_selection
        cursor.mark = cursor.pos
        view.selection = cursor
      end

      def start_selecting_line
        cursor.mark = cursor.bol
        cursor.pos = cursor.eol
        view.selection = cursor
        view.selection[:linewise] = true
      end

      def stop_selection
        view.selection = nil
      end

      # Copy current selection to clipboard and stop selecting
      def copy(cursor = cursor)
        VER.clipboard << buffer[cursor.to_range]
        stop_selection
      end

      # Paste latest contents of clipboard in front of cursor
      def paste_before
        text = VER.clipboard.last
        buffer[cursor.pos, 0] = text
        cursor.pos += text.size
      end

      # Paste latest contents of clipboard after the cursor
      def paste_after
        text = VER.clipboard.last
        buffer[cursor.pos, 0] = text
      end
    end
  end
end
