module VER
  module Methods
    # A bunch of methods specific to the Nano keymap.
    module Nano
      module_function

      # Insert the next keystroke verbatim
      def verbatim(buffer, action)
        char = buffer.events.last.unicode
        buffer.insert(:insert, char)
      end

      # Insert the keystroke verbatim
      def verbatim_insert(buffer)
      end

      def ascii_enter(buffer, old, new)
        buffer.store(self, :ascii_digit, [])
      end

      def ascii_leave(buffer, old, new)
        buffer.store(self, :ascii_digit, nil)
      end

      def ascii(buffer)
        unicode = buffer.events.last.unicode
        if unicode =~ /^\d+$/
          digits = buffer.store(self, :ascii_digit)
          digits << unicode.to_i
        else
          # do nothing?
          return
        end

        return if digits.size < 3

        ord = digits.join.to_i
        buffer.at_insert.insert(ord.chr)
      rescue => ex
        VER.error(ex)
        buffer.minor_mode(:ascii_digit, :control)
      else
        buffer.minor_mode(:ascii_digit, :control)
      end

      # Noop
      def redraw(buffer)
        mumble buffer, "Redraw"
      end

      # Noop
      def suspend(buffer)
        mumble buffer, "Suspend"
      end

      def home(buffer)
        if buffer.store(self, :smart_home)
          smart_home(buffer)
        else
          dumb_home(buffer)
        end
      end

      def smart_home(buffer)
        insert = buffer.index(:insert)
        x = buffer.get(insert.linestart, insert.lineend).index(/\S/) || 0
        y = insert.y

        if insert.split == [y, x]
          buffer.mark_set(:insert, 'insert linestart')
        else
          buffer.mark_set(:insert, "#{y}.#{x}")
        end
      end

      def dumb_home(buffer)
        buffer.mark_set(:insert, 'insert linestart')
      end

      # Constant cursor position display enable/disable
      def toggle_cursor_pos(buffer)
        widgets = buffer.status.widgets
        np = widgets.find{|widget| widget.kind_of?(Status::NanoPosition) }

        if np.toggle
          message buffer, "Constant cursor position display enabled"
        else
          message buffer, "Constant cursor position display disabled"
        end
      end

      # Smart home key enable/disable
      # If enabled, this makes the Home key smarter.
      # When Home is pressed anywhere but at the very beginning of non-whitespace
      # characters on a line, the cursor will jump to that beginning (either
      # forwards or backwards).
      # If the cursor is already at that position, it will jump to the true
      # beginning of the line.
      def toggle_smart_home_key(buffer)
        if old = buffer.store(self, :smart_home)
          buffer.store(self, :smart_home, true)
          message buffer, "Smart home key enabled"
        else
          buffer.store(self, :smart_home, false)
          message buffer, "Smart home key disabled"
        end
      end

      # Auto indent enable/disable
      # If enabled, indent new lines to the previous line's indentation.
      # Useful when editing source code.
      def toggle_auto_indent(buffer)
        if buffer.options.autoindent = !buffer.options.autoindent
          message buffer, "Auto indent enabled"
        else
          message buffer, "Auto indent disabled"
        end
      end

      # Conversion of typed tabs to spaces enable/disable
      def toggle_convert_typed_tabs_to_spaces(buffer)
        if buffer.options.expandtab = !buffer.options.expandtab
          message buffer, "Conversion of typed tabs to spaces enabled"
        else
          message buffer, "Conversion of typed tabs to spaces disabled"
        end
      end

      # Soft line wrapping enable/disable
      # VER will attempt to display the entire contents of a line, even if it is
      # longer than the screen width.
      def toggle_soft_line_wrapping(buffer)
        if buffer.cget(:wrap) == :word
          buffer.configure wrap: :none
          message buffer, "Soft line wrapping disabled"
        else
          buffer.configure wrap: :word
          message buffer, "Soft line wrapping enabled"
        end
      end

      # Help mode enable/disable
      def toggle_help_mode(buffer)
        widgets = buffer.status.widgets
        np = widgets.find{|widget| widget.kind_of?(Status::NanoHelp) }

        message(np.toggle ? "Help mode enabled" : "Help mode disabled")
      end

      # Use of one more line for editing enable/disable
      def toggle_one_more_line(buffer)
        mumble buffer, "Toggle one more line ignored"
      end

      # Smooth scrolling enable/disable
      def toggle_smooth_scrolling(buffer)
        mumble buffer, "Toggle smooth scrolling"
      end

      # Whitespace display enable/disable
      def toggle_whitespace_display(buffer)
        mumble buffer, "Toggle whitespace display"
      end

      # Color syntax highlighting enable/disable
      def toggle_color_syntax_highlighting(buffer)
        mumble buffer, "Toggle color syntax highlighting"
      end

      # Cut to end enable/disable
      def toggle_cut_to_end(buffer)
        mumble buffer, "Toggle cut to end"
      end

      # Long line wrapping enable/disable
      def toggle_long_line_wrapping(buffer)
        mumble buffer, "Toggle long line wrapping"
      end

      # Backup files enable/disable
      def toggle_backup_files(buffer)
        mumble buffer, "Toggle backup files"
      end

      # Multiple file buffers enable/disable
      def toggle_multiple_file_buffers(buffer)
        mumble buffer, "Toggle multiple file buffers"
      end

      # Mouse support enable/disable
      def toggle_mouse(buffer)
        mumble buffer, "Toggle mouse support"
      end

      # No conversion from DOS/Mac format enable/disable
      def toggle_dos_mac_format_conversion(buffer)
        mumble buffer, "Toggle no conversion from DOS/Mac format"
      end

      # Suspension enable/disable
      def toggle_suspension(buffer)
        mumble buffer, "Toggle suspension"
      end

      def message(buffer, string)
        buffer.message "[ #{string} ]"
      end

      def mumble(string)
        buffer.message "[ #{string} ignored, mumble mumble ]"
      end
    end
  end
end
