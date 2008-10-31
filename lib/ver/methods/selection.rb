module VER
  module Methods
    module Selection
      def start_selection
        sel = view.selection = cursor.dup
        sel.mark = sel.pos
        sel.color = Color[:white, :green]
      end

      def start_selecting_line
        sel = view.selection = cursor.dup
        sel.mark, sel.pos = sel.bol, sel.eol
        sel[:linewise] = true
        sel.color = Color[:white, :green]
      end

      def stop_selection
        view.selection = nil
      end

      # Copy current selection to clipboard and stop selecting
      def copy(cursor = cursor)
        VER.clipboard << (string = view.selection.to_s)
        VER.info "Copied #{string.size} characters"
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
