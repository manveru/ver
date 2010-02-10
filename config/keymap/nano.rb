module VER
  PanedLayout::OPTIONS[:slaves] = 0

  major_mode :Fundamental do
    use :control
  end

  major_mode :MiniBuffer do
    use :basic, :readline

    map :abort,          %w[Escape], %w[Control-c], %w[Control-x]
    map :attempt,        %w[Return]
    map :complete_large, %w[Double-Tab]
    map :complete_small, %w[Tab]
  end

  major_mode :HoverCompletion do
    use :basic

    map :cancel,              %w[Escape], %w[BackSpace]
    map :continue_completion, %w[Right], %w[Tab]
    map :go_down,             %w[Down], %w[Control-p]
    map :go_up,               %w[Up], %w[Control-n]
    map :submit,              %w[Return]
  end

  minor_mode :readline do
    map :accept_line,       %w[Return]

    map :end_of_line,       %w[End], %w[Control-e]
    map :insert_selection,  %w[Shift-Insert]
    map :insert_tab,        %w[Control-v Tab]
    map :kill_end_of_line,  %w[Control-k]
    map :kill_next_char,    %w[Control-d], %w[Delete]
    map :kill_next_word,    %w[Alt-d]
    map :kill_prev_char,    %w[BackSpace]
    map :kill_prev_word,    %w[Control-w]
    map :next_char,         %w[Right], %w[Control-f]
    map :next_word,         %w[Shift-Right], %w[Alt-f]
    map :prev_char,         %w[Left], %w[Control-b]
    map :prev_word,         %w[Shift-Left], %w[Alt-b]
    map :start_of_line,     %w[Home], %w[Control-a]
    map :transpose_chars,   %w[Control-t]

    map :sel_prev_char,     %w[Shift-Left]
    map :sel_next_char,     %w[Shift-Right]
    map :sel_prev_word,     %w[Shift-Control-Left]
    map :sel_next_word,     %w[Shift-Control-Right]
    map :sel_start_of_line, %w[Shift-Home]
    map :sel_end_of_line,   %w[Shift-End]

    missing :insert_string
  end

  minor_mode :basic do
    map :quit, %w[Control-x]
  end

  minor_mode :control do
    inherits :basic

    map :start_select_char_mode, %w[Control-asciicircum]

    handler Methods::Help
    map :nano, %w[Control-g], %w[F1]

    handler Methods::Layout
    map :close, %w[Control-x], %w[F2]
    map :focus_prev,  %w[Alt-less], %w[Alt-comma]
    map :focus_next,  %w[Alt-greater], %w[Alt-period]

    handler Methods::Save
    map :save, %w[Control-o], %w[F3]

    handler Methods::Control
    map :wrap_line, %w[Control-j], %w[F4]
    map :indent_line, %w[Alt-bracketright]
    map :unindent_line, %w[Alt-braceleft]

    handler Methods::Insert
    map :file, %w[Control-w], %w[F6]
    map :newline, %w[Return], %w[Control-m]
    missing :string

    handler Methods::Search
    map :status_next, %w[Control-w], %w[F6]
    map :again,       %w[Alt-w], %w[F16]

    handler Methods::Move
    map :ask_go_line, %w[Control-underscore], %w[F13]
    map :backward_scroll, %w[Alt-minus], %w[Alt-underscore]
    map :end_of_file, %w[Alt-slash], %w[Alt-question]
    map :end_of_line, %w[End], %w[Control-e]
    map :forward_scroll, %w[Alt-plus], %w[Alt-equal]
    map :matching_brace, %w[Control-bracketleft]
    map :next_char, %w[Right], %w[Control-f]
    map :next_line, %w[Control-n], %w[Down]
    map :next_page, %w[Control-v], %w[F8]
    map :next_word, %w[Shift-Right], %w[Alt-f], %w[Control-space]
    map :prev_char, %w[Left], %w[Control-b]
    map :prev_line, %w[Control-p], %w[Up]
    map :prev_page, %w[Control-y], %w[F7]
    map :prev_word, %w[Shift-Left], %w[Alt-b], %w[Alt-space]
    map :start_of_file, %w[Alt-backslash], %w[Alt-bar]
    map :start_of_line, %w[Home], %w[Control-a]

    # M-(     (M-9)           Go to beginning of paragraph; then of previous paragraph
    map :start_of_paragraph, %w[Control-braceleft], %w[Alt-9]
    # M-)     (M-0)           Go just beyond end of paragraph; then of next paragraph
    map :end_of_paragraph, %w[Control-braceright], %w[Alt-0]

    handler Methods::SearchAndReplace
    map :query, %w[Control-backslash], %w[F14], %w[Alt-r]

    handler Methods::Delete
    map :kill_line, %w[Control-k], %w[F9]
    # M-T                     Cut from the cursor position to the end of the file
    map [:kill_motion, :end_of_file], %w[Alt-t]

    handler Methods::Clipboard
    map :paste, %w[Control-u], %w[F10]
    map :copy_line, %w[Alt-asciicircum]

    handler Methods::Undo
    map :undo, %w[Alt-u]
    map :redo, %w[Alt-e]

    handler Methods::Nano
    map :verbatim, ['Alt-v', :verbatim]
    map :home, %w[Home]
    map :suspend, %w[Control-z]
    map :redraw, %w[Control-l]
    map :toggle_help_mode, %w[Alt-x]
    map :toggle_cursor_pos, %w[Alt-c]
    map :toggle_one_more_line, %w[Alt-o]
    map :toggle_smooth_scrolling, %w[Alt-s]
    map :toggle_whitespace_display, %w[Alt-p]
    map :toggle_color_syntax_highlighting, %w[Alt-y]
    map :toggle_smart_home_key, %w[Alt-h]
    map :toggle_auto_indent, %w[Alt-i]
    map :toggle_cut_to_end, %w[Alt-k]
    map :toggle_long_line_wrapping, %w[Alt-l]
    map :toggle_convert_typed_tabs_to_spaces, %w[Alt-q]
    map :toggle_backup_files, %w[Alt-b]
    map :toggle_multiple_file_buffers, %w[Alt-f]
    map :toggle_mouse, %w[Alt-m]
    map :toggle_dos_mac_format_conversion, %w[Alt-n]
    map :toggle_suspension, %w[Alt-z]
    map :toggle_soft_line_wrapping, %w[Alt-dollar]

    ## Missing
    # M-J                     Justify the entire file
    # M-D                     Count the number of words, lines, and characters
    # ^C      (F11)           Display the position of the cursor
    # ^T      (F12)           Invoke the spell checker, if available
    # ^^      (F15)   (M-A)   Mark text at the cursor position
  end

  minor_mode :verbatim do
    handler Methods::Nano

    # try mapping all possible combinations.
    mods = %w[Alt Control Control-Alt]
    (0..255).each do |ord|
      chr = ord.chr
      next unless sym = KEYSYMS[chr]
      sym = sym.sub(/<([^>]+)>/, '\1')
      map :verbatim_insert, [sym], *mods.map{|mod| "#{mod}-#{sym}" }
    end

    missing :verbatim_insert
  end
end
