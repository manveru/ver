module VER
  module Methods
    # A bunch of methods specific to the Nano keymap.
    module Nano
      class << self
        # Insert the next keystroke verbatim
        def verbatim(text, action)
          p text.major_mode.event_history.last
          char = text.major_mode.event_history.last[:unicode]
          text.insert(:insert, char)
        end

        # Insert the keystroke verbatim
        def verbatim_insert(text)
        end

        # Noop
        def redraw(text)
          mumble "Redraw"
        end

        # Noop
        def suspend(text)
          mumble "Suspend"
        end

        def home(text)
          if text.store(self, :smart_home)
            smart_home(text)
          else
            dumb_home(text)
          end
        end

        def smart_home(text)
          insert = text.index(:insert)
          x = text.get(insert.linestart, insert.lineend).index(/\S/) || 0
          y = insert.y

          if insert.split == [y, x]
            text.mark_set(:insert, 'insert linestart')
          else
            text.mark_set(:insert, "#{y}.#{x}")
          end
        end

        def dumb_home(text)
          text.mark_set(:insert, 'insert linestart')
        end

        # Constant cursor position display enable/disable
        def toggle_cursor_pos(text)
          status = text.status

          if status.winfo_ismapped
            status.grid_forget
            message "Constant cursor position display disabled"
          else
            status.grid_configure row: 2, column: 0, sticky: :ew, columnspan: 2
            message "Constant cursor position display disabled"
          end
        end

        # Smart home key enable/disable
        # If enabled, this makes the Home key smarter.
        # When Home is pressed anywhere but at the very beginning of non-whitespace
        # characters on a line, the cursor will jump to that beginning (either
        # forwards or backwards).
        # If the cursor is already at that position, it will jump to the true
        # beginning of the line.
        def toggle_smart_home_key(text)
          if old = text.store(self, :smart_home)
            text.store(self, :smart_home, true)
            message "Smart home key enabled"
          else
            text.store(self, :smart_home, false)
            message "Smart home key disabled"
          end
        end

        # Auto indent enable/disable
        # If enabled, indent new lines to the previous line's indentation.
        # Useful when editing source code.
        def toggle_auto_indent(text)
          if text.options.autoindent = !text.options.autoindent
            message "Auto indent enabled"
          else
            message "Auto indent disabled"
          end
        end

        # Conversion of typed tabs to spaces enable/disable
        def toggle_convert_typed_tabs_to_spaces(text)
          if text.options.expandtab = !text.options.expandtab
            message "Conversion of typed tabs to spaces enabled"
          else
            message "Conversion of typed tabs to spaces disabled"
          end
        end

        # Soft line wrapping enable/disable
        # VER will attempt to display the entire contents of a line, even if it is
        # longer than the screen width.
        def toggle_soft_line_wrapping(text)
          if text.cget(:wrap) == :word
            text.configure wrap: :none
            message "Soft line wrapping disabled"
          else
            text.configure wrap: :word
            message "Soft line wrapping enabled"
          end
        end

        # Help mode enable/disable
        def toggle_help_mode(text)
          mumble "Toggle help mode"
        end

        # Use of one more line for editing enable/disable
        def toggle_one_more_line(text)
          mumble "Toggle one more line ignored"
        end

        # Smooth scrolling enable/disable
        def toggle_smooth_scrolling(text)
          mumble "Toggle smooth scrolling"
        end

        # Whitespace display enable/disable
        def toggle_whitespace_display(text)
          mumble "Toggle whitespace display"
        end

        # Color syntax highlighting enable/disable
        def toggle_color_syntax_highlighting(text)
          mumble "Toggle color syntax highlighting"
        end

        # Cut to end enable/disable
        def toggle_cut_to_end(text)
          mumble "Toggle cut to end"
        end

        # Long line wrapping enable/disable
        def toggle_long_line_wrapping(text)
          mumble "Toggle long line wrapping"
        end

        # Backup files enable/disable
        def toggle_backup_files(text)
          mumble "Toggle backup files"
        end

        # Multiple file buffers enable/disable
        def toggle_multiple_file_buffers(text)
          mumble "Toggle multiple file buffers"
        end

        # Mouse support enable/disable
        def toggle_mouse(text)
          mumble "Toggle mouse support"
        end

        # No conversion from DOS/Mac format enable/disable
        def toggle_dos_mac_format_conversion(text)
          mumble "Toggle no conversion from DOS/Mac format"
        end

        # Suspension enable/disable
        def toggle_suspension(text)
          mumble "Toggle suspension"
        end

        def message(string)
          VER.message "[ #{string} ]"
        end

        def mumble(string)
          VER.message "[ #{string} ignored, mumble mumble ]"
        end
      end
    end
  end
end
