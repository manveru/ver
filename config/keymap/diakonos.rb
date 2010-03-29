module VER
  major_mode :Fundamental do
    use :control
  end

  major_mode :MiniBuffer do
    use :basic, :readline

    map :abort,          '<Escape>', '<Control-c>'
    map :attempt,        '<Return>'
    map :complete_large, '<Control-d>'
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

  minor_mode :basic do
    handler Methods::Basic
    map :quit, '<Control-q>'
  end

  minor_mode :move do
    handler :at_insert
    map :ask_go_line,     '<Control-g>'
    map :backward_scroll, '<Alt-p>'
    map :end_of_buffer,   '<Alt-greater>'
    map :last_char,       '<End>', '<Control-e>'
    map :forward_scroll,  '<Alt-n>'
    map :next_char,       '<Right>'
    map :next_line,       '<Down>'
    map :next_page,       '<Next>'
    map :next_word,       '<Shift-Right>'
    map :prev_char,       '<Left>'
    map :prev_line,       '<Up>'
    map :prev_page,       '<Prior>'
    map :prev_word,       '<Shift-Left>'
    map :start_of_buffer, '<Alt-less>'
    map :start_of_line,   '<Home>'
  end

  minor_mode :control do
    inherits :basic, :move

    become :select_char, '<Control-space>'
    become :select_line, '<Escape><Control-space>', '<Control-Alt-space>'

    map :save,    '<Control-s>'
    map :save_as, '<Alt-S>'
    map :undo,    '<Control-z>'
    map :redo,    '<Control-y>'

    handler Methods::Open
    map :file_open_ask, '<Control-o>'

    handler Methods::Layout
    map :close, '<Control-w>'
    1.upto 9 do |n|
      map [:focus, n], "<Alt-Key-#{n}>", "<Escape><Key-#{n}>"
    end

    handler :at_insert
    map :insert_newline,    '<Return>'
    map :insert_selection,  '<Shift-Insert>'
    map :insert_tab,        '<Control-t>'

    handler Methods::Control
    map :indent_line,                   '<Alt-i>', '<Escape>i'
    map :unindent_line,                 '<Alt-I>', '<Escape>I'
    map :exec_into_new,                 '<F2>'
    map :exec_into_void,                '<F8>'
    map [:exec_into_new, 'ruby -c $f'], '<Control-Alt-c>'
    map :cursor_vertical_top,           '<Alt-comma>', '<Escape>,'
    map :cursor_vertical_bottom,        '<Alt-period>', '<Escape>.'
    map :join_forward,                  '<Alt-j>', '<Escape>j'
    map :join_backward,                 '<Alt-J>', '<Escape>J'

    handler Methods::Completion
    map :word, '<Alt-e>', '<Escape>e'

    handler Methods::Clipboard
    map :paste, '<Control-v>'

    handler :at_insert
    map :kill_line,                 '<Control-k>', '<Control-d><Control-d>'
    map [:deleting, :last_char],    '<Control-Alt-k>', '<Control-d>$'
    map [:deleting, :prev_char],    '<BackSpace>'
    map [:deleting, :next_char],    '<Delete>'

    handler Methods::Bookmark
    map :add_named,    '<Alt-b><Alt-a>'
    map :next,         '<Alt-b><Alt-n>'
    map :prev,         '<Alt-b><Alt-p>'
    map :remove_named, '<Alt-b><Alt-r>'
    map :toggle,       '<Alt-b><Alt-b>'
    map :visit_named,  '<Alt-b><Alt-g>'
    # these are only valid on US keymap, don't know a better way.
    map [:add_named,   '1'], '<Alt-b><Alt-exclam>'
    map [:add_named,   '2'], '<Alt-b><Alt-at>'
    map [:add_named,   '3'], '<Alt-b><Alt-numbersign>'
    map [:add_named,   '4'], '<Alt-b><Alt-dollar>'
    map [:add_named,   '5'], '<Alt-b><Alt-percent>'
    map [:visit_named, '1'], '<Alt-b><Alt-Key-1>'
    map [:visit_named, '2'], '<Alt-b><Alt-Key-2>'
    map [:visit_named, '3'], '<Alt-b><Alt-Key-3>'
    map [:visit_named, '4'], '<Alt-b><Alt-Key-4>'
    map [:visit_named, '5'], '<Alt-b><Alt-Key-5>'

    handler Methods::CTags
    map :go,           '<Alt-t>'
    map :find_current, '<Alt-parenright>'
    map :prev,         '<Alt-parenleft>'

    handler Methods::Search
    map :status_next, '<Control-f>'
    map :next,        '<F3>'
    map :clear,       '<Control-Alt-u>'

    if x11?
      map :prev, '<XF86_Switch_VT_3>'
    else
      map :prev, '<Shift-F3>'
    end

    handler Methods::Insert
    missing :string
  end

  minor_mode :select do
    handler Methods::Selection
    map :copy,                   '<Control-c>'
    map :kill,                   '<Control-x>'
    map :delete,                 '<BackSpace>', '<Delete>'
    map :replace_with_clipboard, '<Control-v>'
  end

  minor_mode :select_char do
    inherits :move, :select
    become :control, '<Escape>'
    handler Methods::Selection
    enter :enter
    leave :leave
  end

  minor_mode :select_line do
    inherits :move, :select
    become :control, '<Escape>'
    handler Methods::Selection
    enter :enter
    leave :leave
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
    map :paste, '<Control-y>'

    missing :insert_string
  end
end
