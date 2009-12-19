module VER
  class Keymap
    def self.nano(options)
      nano = new(options)
      nano.mode = options.fetch(:mode, :buffer)

      nano.in_mode :basic do
        key :quit, %w[Control-x]
      end

      nano.in_mode :readline do
        ## traditional mapping
        # ^H                      Delete the character to the left of the cursor
        key [:kill_motion, :backward_char], %w[BackSpace]
        # ^D                      Delete the character under the cursor
        key [:kill_motion, :forward_char], %w[Delete], %w[Control-d]
        # ^F                      Go forward one character
        key :backward_char, %w[Left], %w[Control-b]
        # ^B                      Go back one character
        key :forward_char, %w[Right], %w[Control-f]
        # ^A                      Go to beginning of current line
        key :beginning_of_line, %w[Home], %w[Control-a]
        # ^E                      Go to end of current line
        key :end_of_line, %w[End], %w[Control-e]
        # ^I                      Insert a tab at the cursor position
        key :insert_tab, %w[Control-i], %w[Control-v Tab]

        ## extended mapping
        key :previous_line, %w[Up]
        key :next_line, %w[Down]
        key :backward_word, %w[Shift-Left], %w[Alt-b]
        key :forward_word, %w[Shift-Right], %w[Alt-f]
        key :insert_selection, %w[Shift-Insert]

        KEYSYMS.each do |sym, name|
          key [:insert_string, sym], [name]
        end
      end

      nano.in_mode :buffer do
        inherits :readline

        # ^G      (F1)            Display this help text
        key :help, %w[Control-g], %w[F1]
        # ^X      (F2)            Close the current file buffer / Exit from nano
        key :view_close, %w[Control-x], %w[F2]
        # ^O      (F3)            Write the current file to disk
        key :file_save, %w[Control-o], %w[F3]
        # ^J      (F4)            Justify the current paragraph
        # key :wrap_paragraph, %w[Control-j], %w[F4]

        # ^R      (F5)            Insert another file into the current one
        key :insert_file, %w[Control-w], %w[F6]
        # ^W      (F6)            Search for a string or a regular expression
        key :status_search_next, %w[Control-w], %w[F6]
        # ^Y      (F7)            Go to previous screen
        key :previous_screen, %w[Control-y], %w[F7]
        # ^V      (F8)            Go to next screen
        key :next_screen, %w[Control-v], %w[F8]

        # ^K      (F9)            Cut the current line and store it in the cutbuffer
        key :kill_line, %w[Control-k], %w[F9]
        # ^U      (F10)           Uncut from the cutbuffer into the current line
        key :paste, %w[Control-u], %w[F10]
        # ^C      (F11)           Display the position of the cursor
        # ^T      (F12)           Invoke the spell checker, if available

        # M-\     (M-|)           Go to the first line of the file
        key :go_line, %w[Alt-backslash], %w[Alt-bar]
        # M-/     (M-?)           Go to the last line of the file
        key :end_of_file, %w[Alt-slash], %w[Alt-question]

        # ^_      (F13)   (M-G)   Go to line and column number
        # ^\      (F14)   (M-R)   Replace a string or a regular expression
        # ^^      (F15)   (M-A)   Mark text at the cursor position
        key :start_select_char_mode, %w[Control-asciicircum]
        # M-W     (F16)           Repeat last search

        # M-^     (M-6)           Copy the current line and store it in the cutbuffer
        key :copy_line, %w[Alt-asciicircum]
        # M-}                     Indent the current line
        key :indent_line, %w[Alt-bracketright]
        # M-{                     Unindent the current line
        key :unindent_line, %w[Alt-braceleft]

        # ^Space                  Go forward one word
        key :forward_word, %w[Control-space]
        # M-Space                 Go back one word
        key :backward_word, %w[Alt-space]
        # ^P                      Go to previous line
        key :previous_line, %w[Control-p]
        # ^N                      Go to next line
        key :next_line, %w[Control-n]

        # M-(     (M-9)           Go to beginning of paragraph; then of previous paragraph
        # M-)     (M-0)           Go just beyond end of paragraph; then of next paragraph
        # M-]                     Go to the matching bracket
        key :matching_brace, %w[Control-bracketleft]
        # M--     (M-_)           Scroll up one line without scrolling the cursor
        # M-+     (M-=)           Scroll down one line without scrolling the cursor
        # M-<     (M-,)           Switch to the previous file buffer
        key :view_focus_prev,  %w[Control-less], %w[Alt-comma]
        # M->     (M-.)           Switch to the next file buffer
        key :view_focus_next,  %w[Control-greater], %w[Alt-period]

        # M-V                     Insert the next keystroke verbatim

        # ^M                      Insert a newline at the cursor position
        key :insert_indented_newline, %w[Return], %w[Control-m]

        # M-T                     Cut from the cursor position to the end of the file

        # M-J                     Justify the entire file
        # M-D                     Count the number of words, lines, and characters
        # ^L                      Refresh (redraw) the current screen
        # ^Z                      Suspend the editor (if suspend is enabled)

        # (M-X)                   Help mode enable/disable
        key :toggle_help_mode, %w[Alt-x]
        # (M-C)                   Constant cursor position display enable/disable
        key :toggle_cursor_pos, %w[Alt-c]
        # (M-O)                   Use of one more line for editing enable/disable
        key :toggle_one_more_line, %w[Alt-o]
        # (M-S)                   Smooth scrolling enable/disable
        key :toggle_smooth_scrolling, %w[Alt-s]
        # (M-P)                   Whitespace display enable/disable
        key :toggle_whitespace_display, %w[Alt-p]
        # (M-Y)                   Color syntax highlighting enable/disable
        key :toggle_color_syntax_highlighting, %w[Alt-y]
        # (M-H)                   Smart home key enable/disable
        key :toggle_smart_home_key, %w[Alt-h]
        # (M-I)                   Auto indent enable/disable
        key :toggle_auto_indent, %w[Alt-i]
        # (M-K)                   Cut to end enable/disable
        key :toggle_cut_to_end, %w[Alt-k]
        # (M-L)                   Long line wrapping enable/disable
        key :toggle_long_line_wrapping, %w[Alt-l]
        # (M-Q)                   Conversion of typed tabs to spaces enable/disable
        key :toggle_convert_typed_tabs_to_spaces, %w[Alt-q]
        # (M-B)                   Backup files enable/disable
        key :toggle_backup_files, %w[Alt-b]
        # (M-F)                   Multiple file buffers enable/disable
        key :toggle_multiple_file_buffers, %w[Alt-f]
        # (M-M)                   Mouse support enable/disable
        key :toggle_mouse, %w[Alt-m]
        # (M-N)                   No conversion from DOS/Mac format enable/disable
        key :toggle_dos_mac_format_conversion, %w[Alt-n]
        # (M-Z)                   Suspension enable/disable
        key :toggle_suspension, %w[Alt-z]
        # (M-$)                   Soft line wrapping enable/disable
        key :toggle_soft_line_wrapping, %w[Alt-dollar]

        KEYSYMS.each do |sym, name|
          key [:insert_string, sym], [name]
        end

        missing :insert_string
      end

      nano.in_mode :status_query do
        inherits :basic, :readline

        key :ask_abort,        %w[Escape], %w[Control-c]
        key :history_prev,     %w[Up], %w[Control-p]
        key :history_next,     %w[Down], %w[Control-n]
        key :history_complete, %w[Tab]
        key :ask_submit,       %w[Return]

        missing :insert_string
      end

      nano
    end
  end
end
