module VER
  options.horizontal_scrollbar = false
  options.vertical_scrollbar = false

  aliases = Hash.new{|h,k| k }

  major_mode :Fundamental do
    use :control
  end

  major_mode :MiniBuffer do
    use :basic, :readline

    map :abort,          '<Escape>', '<Control-c>', '<Control-x>'
    map :attempt,        '<Return>'
    map :complete_small, '<Tab>'
  end

  major_mode :HoverCompletion do
    use :basic

    map :cancel,              '<Escape>', '<BackSpace>'
    map :continue_completion, '<Right>', '<Tab>'
    map :go_down,             '<Down>', '<Control-p>'
    map :go_up,               '<Up>', '<Control-n>'
    map :submit,              '<Return>'
  end

  minor_mode :readline do
    map :accept_line,       '<Return>'

    map :last_char,         '<End>', '<Control-e>'
    map :insert_selection,  '<Shift-Insert>'
    map :insert_tab,        '<Control-v><Tab>'
    map :kill_end_of_line,  '<Control-k>'
    map :kill_next_char,    '<Control-d>', '<Delete>'
    map :kill_next_word,    '<Alt-d>'
    map :kill_prev_char,    '<BackSpace>'
    map :kill_prev_word,    '<Control-w>'
    map :next_char,         '<Right>', '<Control-f>'
    map :next_word,         '<Shift-Right>', '<Alt-f>'
    map :prev_char,         '<Left>', '<Control-b>'
    map :prev_word,         '<Shift-Left>', '<Alt-b>'
    map :start_of_line,     '<Home>', '<Control-a>'
    map :transpose_chars,   '<Control-t>'

    missing :insert_string
  end

  minor_mode :basic do
    map :quit, '<Control-x>'
  end

  minor_mode :control do
    inherits :basic

    become :ascii_digit, '<Escape><Escape>'

    map :start_select_char_mode, '<Control-asciicircum>'

    map :undo, '<Alt-u>'
    map :redo, '<Alt-e>'
    map :save, '<Control-o>', '<F3>'

    handler Methods::Help
    map :nano, '<Control-g>', '<F1>'

    handler Methods::Layout
    map :close, '<Control-x>', '<F2>'
    map :focus_prev,  '<Alt-less>', '<Alt-comma>'
    map :focus_next,  '<Alt-greater>', '<Alt-period>'

    handler Methods::Control
    map :wrap_line,      '<Control-j>', '<F4>'
    map :unindent_line,  '<Alt-braceleft>'

    handler Methods::Insert
    map :file, '<Control-r>', '<F5>'
    missing :string

    handler Methods::Search
    map :status_next, '<Control-w>', '<F6>'
    map :again,       '<Alt-w>', '<F16>'

    handler :at_insert
    map :ask_go_line,                 '<Control-underscore>', '<F13>'
    map :backward_scroll,             '<Alt-minus>', '<Alt-underscore>'
    map :end_of_buffer,               '<Alt-slash>', '<Alt-question>'
    map :last_char,                   '<End>', '<Control-e>'
    map :forward_scroll,              '<Alt-plus>', '<Alt-equal>'
    map :indent_line,                 '<Alt-bracketright>'
    map :kill_line,                   '<Control-k>', '<F9>'
    map :matching_brace,              '<Control-bracketleft>'
    map :next_char,                   '<Right>', '<Control-f>'
    map :next_line,                   '<Control-n>', '<Down>'
    map :next_page,                   '<Control-v>', '<F8>'
    map :next_word,                   '<Shift-Right>', '<Control-space>'
    map :prev_char,                   '<Left>', '<Control-b>'
    map :prev_line,                   '<Control-p>', '<Up>'
    map :prev_page,                   '<Control-y>', '<F7>'
    map :prev_word,                   '<Shift-Left>', '<Alt-space>'
    map :start_of_buffer,             '<Alt-backslash>', '<Alt-bar>'
    map [:killing, :end_of_buffer],   '<Alt-t>'
    map [:killing, :prev_char],       '<BackSpace>'
    map [:killing, :next_char],       '<Delete>'
    map :newline,                     '<Return>', '<Control-m>'

    # M-(     (M-9)           Go to beginning of paragraph; then of previous paragraph
    map :start_of_paragraph, '<Control-braceleft>', '<Alt-Key-9>'
    # M-)     (M-0)           Go just beyond end of paragraph; then of next paragraph
    map :end_of_paragraph, '<Control-braceright>', '<Alt-Key-0>'

    handler Methods::SearchAndReplace
    map :query, '<Control-backslash>', '<F14>', '<Alt-r>'

    handler Methods::Clipboard
    map :paste, '<Control-u>', '<F10>'
    map :copy_line, '<Alt-asciicircum>'

    handler Methods::Nano
    map :verbatim, ['<Alt-v>', :verbatim]
    map :home, '<Home>', '<Control-a>'
    map :suspend, '<Control-z>'
    map :redraw, '<Control-l>'
    map :toggle_help_mode, '<Alt-x>'
    map :toggle_cursor_pos, '<Alt-c>'
    map :toggle_one_more_line, '<Alt-o>'
    map :toggle_smooth_scrolling, '<Alt-s>'
    map :toggle_whitespace_display, '<Alt-p>'
    map :toggle_color_syntax_highlighting, '<Alt-y>'
    map :toggle_smart_home_key, '<Alt-h>'
    map :toggle_auto_indent, '<Alt-i>'
    map :toggle_cut_to_end, '<Alt-k>'
    map :toggle_long_line_wrapping, '<Alt-l>'
    map :toggle_convert_typed_tabs_to_spaces, '<Alt-q>'
    map :toggle_backup_files, '<Alt-b>'
    map :toggle_multiple_file_buffers, '<Alt-f>'
    map :toggle_mouse, '<Alt-m>'
    map :toggle_dos_mac_format_conversion, '<Alt-n>'
    map :toggle_suspension, '<Alt-z>'
    map :toggle_soft_line_wrapping, '<Alt-dollar>'

    ## Missing
    # M-J                     Justify the entire file
    # M-D                     Count the number of words, lines, and characters
    # ^C      (F11)           Display the position of the cursor
    # ^T      (F12)           Invoke the spell checker, if available
    # ^^      (F15)   (M-A)   Mark text at the cursor position
  end

  minor_mode :verbatim do
    handler Methods::Nano

    # try mapping all possible Control-Key combinations.
    map :verbatim_insert, "<Control-Key>"
    missing :verbatim_insert
  end

  minor_mode :ascii_digit do
    handler Methods::Nano
    enter :ascii_enter
    leave :ascii_leave

    map :ascii, *('<Key-0>'..'<Key-9>')
  end
end
