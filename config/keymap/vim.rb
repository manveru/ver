module VER
  minor_mode :help do
    handler Methods::Help

    map :describe_key, '<M2-h>k'
  end

  minor_mode :open do
    handler Methods::Open
    map :file_open_popup, '<M2-o>'
    map :file_open_ask,   ':o<space>'

    handler Methods::Control
    map [:ex, :fuzzy], '<M1-o>', '<M2-m>o'
  end

  minor_mode :save do
    map :save,     '<M2-s>', ':w<Return>'
    map :save_as,  '<M2-S>', ':w<space>'
    map :save_all, ':wa'
  end

  minor_mode :preview do
    map :eval_buffer,  '<M2-R>'
    map :tags_tooltip, '<M2-g>t'

    handler Methods::Preview
    map :preview, '<F5>'
  end

  minor_mode :basic do
    inherits :help, :preview, :save, :open

    handler Methods::Basic
    map :minibuf_eval,    '<M1-x>', '<M2-m>x'
    map :open_terminal,   '<F9>'
    map :open_console,    '<M2-exlam>' if defined?(::EM)
  end

  minor_mode :vim_layout do
    # map :quit!,            ':q!'
    map :quit,             '<M2-w>q', '<M2-w><M2-q>', ':q<Return>'
    map :close,            '<M2-w>c', ':clo<Return>'
    # map :close!,           ':clo!'

    handler :window
    map :split_horizontal, '<M2-w>s', '<M2-w><M2-s>', ':sh'
    map :split_vertical,   '<M2-w>v', '<M2-w><M2-v>', ':sv'
    map :new_horizontal,   '<M2-w>n', '<M2-w><M2-n>', ':n'
    map :only,             '<M2-w>o', '<M2-w><M2-o>', ':on<Return>'
    map :go_below,         '<M2-w>j', '<M2-w><M2-j>', '<M2-w><Down>'
    map :go_above,         '<M2-w>k', '<M2-w><M2-k>', '<M2-w><Up>'
    map :go_left,          '<M2-w>h', '<M2-w><M2-h>', '<M2-w><Left>', '<M2-w><BackSpace>'
    map :go_right,         '<M2-w>l', '<M2-w><M2-l>', '<M2-w><Right>'
  end

  minor_mode :layout do
    inherits :basic
    handler Methods::Layout

    map :hide,          '<Key-0>'
    map :one,           '<Key-1>'
    map :two,           '<Key-2>'

    map :slave_inc,     '+'
    map :slave_dec,     '-'

    map :master_inc,    '<less>'
    map :master_dec,    '>'

    map :create,        'c'
    map :focus_next,    'j', '<Right>'
    map :focus_prev,    'k', '<Left>'
    map :push_down,     'J', '<Down>'
    map :push_up,       'K', '<Up>'
    map :close,         'w'
    map :push_top,      '<Return>'
    map :push_bottom,   '<BackSpace>'

    map :master_shrink, 'h'
    map :master_grow,   'l'
    map :master_equal,  '='

    map :peer,          'p'
  end

  minor_mode :layout_control do
    become :layout, '<M2-w>r'

    handler Methods::Layout
    map :change,     ['<M2-w>', :layout]
    map :focus_next, '<M2-Tab>'
    map :cycle_next, '<M1-Tab>', ':bn'

    if x11?
      map :focus_prev, '<M2-ISO_Left_Tab>'
      map :cycle_prev, '<M1-ISO_Left_Tab>', ':bp'
    else
      map :focus_prev, '<M2-Shift-Tab>'
      map :cycle_prev, '<M1-Shift-Tab>', ':bp'
    end
  end

  minor_mode :move do
    inherits :prefix

    map :ask_go_line, *(':<Key-1>'..':<Key-9>')

    handler Methods::Move
    map :prefix_arg_sol,  '<Key-0>'

    handler :at_insert
    map :end_of_buffer,   'G'
    map :end_of_line,     '$', '<End>'
    map :go_line,         'gg'
    map :matching_brace,  '%'
    map :next_char,       'l', '<Right>'
    map :next_chunk,      'W'
    map :next_chunk_end,  'E'
    map :next_line,       'j', '<Down>', '<M2-n>'
    map :next_page,       '<M2-f>', '<Next>'
    map :next_word,       'w', '<Shift-Right>'
    map :next_word_end,   'e'
    map :prev_char,       'h', '<Left>'
    map :prev_chunk,      'B'
    map :prev_line,       'k', '<Up>', '<M2-p>'
    map :prev_page,       '<M2-b>', '<Prior>'
    map :prev_word,       'b', '<Shift-Left>'
    map :start_of_line,   '<Home>'
  end

  minor_mode :prefix do
    # Sometimes Range really surprises me...
    map :update_prefix_arg, *('<Key-0>'..'<Key-9>')
  end

  minor_mode :search do
    handler Methods::Search

    map :char_left,               'F'
    map :char_right,              'f'
    map :next,                    'n'
    map :next_word_under_cursor,  '*'
    map :prev,                    'N'
    map :prev_word_under_cursor,  '#'
    map :remove,                  'g/'
    map :status_next,             '/'
    map :status_prev,             '?'
  end

  minor_mode :ctags do
    handler Methods::CTags

    map :find_current,  '<M2-bracketright>' # C-]
    map :prev,          '<M2-bracketleft>'  # C-[
  end

  minor_mode :bookmark do
    handler Methods::Bookmark

    map :add_char,    'm'
    map :visit_char,  '`'
    # vim also has quoteright to jump to the start of the line, but who
    # needs that *_*
  end

  minor_mode :complete do
    handler Methods::Completion

    map :aspell,     '<M2-x><M2-a>'
    map :contextual, '<M2-x><M2-x>'
    map :file,       '<M2-x><M2-f>'
    map :line,       '<M2-x><M2-l>'
    map :snippet,    '<M2-x><M2-s>'
    map :word,       '<M2-x><M2-w>'
    map :smart_tab,  '<Tab>'
  end

  minor_mode :delete do
    handler :at_insert
    map :changing,                  ['c', :move]
    map :change_next_word_end,      'cw'
    map :change_line,               'cc'
    map :killing,                   ['d', :move]
    map :kill_line,                 'dd'
    map [:changing, :end_of_line],  'C'
    map [:killing,  :end_of_line],  'D'
    map [:killing,  :next_char],    'x'
    map [:killing,  :prev_char],    'X'
  end

  minor_mode :clipboard do
    handler :at_insert
    map :copy_line,  'yy','Y'
    map :copying,    ['y', :move]

    handler Methods::Clipboard
    map :paste,            'p'
    map :paste_above,      'P'
  end

  minor_mode :undo do
    handler Methods::Undo

    map :redo, '<M2-r>'
    map :undo, 'u'
  end

  minor_mode :control do
    inherits :basic, :move, :delete, :undo, :layout_control, :search, :ctags,
             :bookmark, :clipboard

    become :insert,         'i', '<Insert>'
    become :replace,        'R'
    become :replace_char,   'r'
    become :select_block,   '<M2-v>'
    become :select_char,    'v'
    become :select_line,    'V'
    become :control,        '<Escape>'

    map :repeat_action, '.'
    map :quit,          ':qa', 'ZZ'
    map :close,         ':q<Return>', ':x'

    handler :at_insert
    map :insert_newline_above,       'O'
    map :insert_newline_below,       'o'
    map [:change_at, :end_of_line],  'A'
    map [:change_at, :next_char],    'a'
    map [:change_at, :home_of_line], 'I'

    handler Methods::Control
    enter :enter
    leave :leave
    map :chdir,                             'gc'

    map :cursor_vertical_bottom,            'zb'
    map :cursor_vertical_bottom_sol,        'z-'
    map :cursor_vertical_center,            'zz'
    map :cursor_vertical_center_sol,        'z.'
    map :cursor_vertical_top,               'zt'
    map :cursor_vertical_top_sol,           'z<Return>'

    map :executor, '::'
    map [:ex, :buffer],       ':bu', '<M1-b>', '<M2-m>b'
    map [:ex, :edit],         ':e<space>'
    map [:ex, :encoding],     ':en<space>'
    map [:ex, :fuzzy],        ':f'
    map [:ex, :grep],         ':g'
    map [:ex, :grep_buffers], ':G'
    map [:ex, :locate],       ':l'
    map [:ex, :method],       ':m'
    map [:ex, :open],         ':o<Return>'
    map [:ex, :syntax],       ':s'
    map [:ex, :theme],        ':t'
    # map [:ex, :write],        ':w'

    map :toggle_case, '~'
    map :wrap_line,   'gw'
    map :indent_line,                       '>'
    map :unindent_line,                     '<less>'
    map :join_line_forward,                 'J'
    map :open_file_under_cursor,            'gf'
    map :smart_evaluate,                    '<M1-e>', '<M2-m>e'

    handler Methods::SearchAndReplace
    map :query, '<M1-percent>'
  end

  minor_mode :readline do
    map :accept_line,       '<Return>'

    map :end_of_line,       '<End>', '<M2-e>'
    map :insert_selection,  '<Shift-Insert>'
    map :insert_tab,        '<M2-v><Tab>', '<M2-i>'
    map :kill_end_of_line,  '<M2-k>'
    map :kill_next_char,    '<M2-d>', '<Delete>'
    map :kill_next_word,    '<M1-d>'
    map :kill_prev_char,    '<BackSpace>'
    map :kill_prev_word,    '<M2-w>'
    map :next_char,         '<Right>', '<M2-f>'
    map :next_word,         '<Shift-Right>', '<M1-f>'
    map :prev_char,         '<Left>', '<M2-b>'
    map :prev_word,         '<Shift-Left>', '<M1-b>'
    map :start_of_line,     '<Home>', '<M2-a>'
    map :transpose_chars,   '<M2-t>'

    # TODO
    map :sel_prev_char,     '<Shift-Left>'
    map :sel_next_char,     '<Shift-Right>'
    map :sel_prev_word,     '<Shift-M2-Left>'
    map :sel_next_word,     '<Shift-M2-Right>'
    map :sel_start_of_line, '<Shift-Home>'
    map :sel_end_of_line,   '<Shift-End>'

    missing :insert_string
  end

  minor_mode :insert do
    inherits :basic, :layout_control, :complete
    become :control, '<Escape>', '<M2-c>'

    handler Methods::AutoFill
    map :auto_fill_space,          '<space>'

    handler :at_insert
    map :end_of_line,            '<End>', '<M2-e>'
    map :insert_newline,         '<Return>'
    map :insert_selection,       '<Shift-Insert>', '<Insert>'
    map :insert_tab,             '<M2-v><Tab>', '<M2-i>'
    map :next_char,              '<Right>', '<M2-f>'
    map :next_line,              '<Down>', '<M2-n>'
    map :next_page,              '<M2-f>', '<Next>', '<Shift-Down>'
    map :next_word,              '<Shift-Right>', '<M1-f>'
    map :prev_char,              '<Left>', '<M2-b>'
    map :prev_line,              '<Up>', '<M2-p>'
    map :prev_page,              '<M2-b>', '<Prior>', '<Shift-Up>'
    map :prev_word,              '<Shift-Left>', '<M1-b>'
    map :start_of_line,          '<Home>', '<M2-a>'
    map [:killing, :next_char],  '<Delete>', '<M2-d>'
    map [:killing, :prev_char],  '<BackSpace>'
    map [:killing, :prev_word],  '<M2-w>'

    handler Methods::Control
    map :smart_evaluate,           '<M1-e>', '<M2-e>'
    if x11?
      map :unindent_line,            '<ISO_Left_Tab>'
    else
      map :unindent_line,            '<Shift-Tab>'
    end

    handler Methods::Insert
    missing :string
  end

  minor_mode :replace do
    become :control, '<Escape>', '<M2-c>'

    handler Methods::Insert
    map [:replace_string, "\n"], '<Return>'
    missing :replace_string
  end

  minor_mode :replace_char do
    become :control, '<Escape>', '<M2-c>'

    handler Methods::Insert
    map [:replace_char, "\n"], '<Return>'
    missing :replace_char
  end

  minor_mode :search_and_replace do
    become :control, '<Escape>', '<M2-c>', 'q'

    handler Methods::SearchAndReplace
    enter :enter
    leave :leave

    map :replace_all,  'a', '<exclam>'
    map :replace_once, 'y'
    map :next,         'n', 's', 'j', '<M2-n>'
    map :prev,         'k', '<M2-p>'
  end

  minor_mode :select do
    inherits :basic, :move, :search

    handler :at_sel
    map :comment,         ',c'
    map :copy,            'y', 'Y'
    map :indent,          '<greater>'
    map :kill,            'd', 'D', 'x', '<BackSpace>', '<Delete>'
    map :lower_case,      'u'
    map :replace_string,  'c'
    map :toggle_case,     '<asciitilde>'
    map :upper_case,      'U'
    map :uncomment,       ',u'
    map :unindent,        '<less>'

    handler Methods::Control
    map :smart_evaluate,  '<M1-e>', '<M2-e>'

    handler Methods::Selection
    map :pipe,            '<exclam>'
  end

  minor_mode :select_char do
    inherits :select

    become :control,             '<Escape>', '<M2-c>'
    become :select_line,         'V'
    become :select_block,        '<M2-v>'
    become :select_replace_char, 'r'

    handler :at_sel
    enter :enter
    leave :leave
    map :wrap, 'gw'
  end

  minor_mode :select_line do
    inherits :select

    become :control,             '<Escape>', '<M2-c>'
    become :select_char,         'v'
    become :select_block,        '<M2-v>'
    become :select_replace_char, 'r'

    handler :at_sel
    enter :enter
    leave :leave
    map :wrap, 'gw'
  end

  minor_mode :select_block do
    inherits :select

    become :control,             '<Escape>', '<M2-c>'
    become :select_char,         'v'
    become :select_line,         'V'
    become :select_replace_char, 'r'

    handler :at_sel
    enter :enter
    leave :leave
  end

  minor_mode :select_replace_char do
    become :control, '<Escape>', '<M2-c>'

    handler :at_sel
    map [:replace_char, "\n"], '<Return>'
    missing :replace_char
  end

  major_mode :HoverCompletion do
    inherits :basic

    map :cancel,               '<Escape>', '<BackSpace>'
    map :continue_completion,  '<Right>', 'l'
    map :go_down,              '<Down>', 'j'
    map :go_up,                '<Up>', 'k'
    map :submit,               '<Return>'
  end

  minor_mode :snippet do
    inherits :readline

    handler Methods::Snippet
    map :cancel, '<Escape>', '<M2-c>'
    map :jump,   '<Tab>'

    missing :insert_string
  end

  major_mode :Fundamental do
    use :control
  end

  major_mode :MiniBuffer do
    use :readline

    map :abort,           '<Escape>', '<M2-c>'
    map :attempt,         '<Return>'
    map :complete_large,  '<Tab><Tab>'
    map :complete_small,  '<Tab>'
    map :next_history,    '<Down>'
    map :prev_history,    '<Up>'
  end

  major_mode :Completions do
    handler MiniBuffer
    map :answer_from, '<Button-1>'
  end

  major_mode :Executor do
    use :executor_label
  end

  minor_mode :executor_entry do
    inherits :readline

    map :completion, '<Tab>'
    map :cancel,     '<Escape>'
    map :next_line,  '<Down>', '<M2-j>', '<M2-n>'
    map :prev_line,  '<Up>', '<M2-k>', '<M2-p>'
  end

  minor_mode :executor_label do
    inherits :executor_entry

    map :speed_selection,  '<space>'

    missing :insert_string
  end
end
