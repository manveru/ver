module VER
  minor_mode :help do
    handler Methods::Help

    map :describe_key, '<Control-h>k'
  end

  minor_mode :open do
    handler Methods::Open
    map :file_open_popup, '<Control-o>'

    handler Methods::Control
    map [:ex, :fuzzy], '<Alt-o>', '<Control-m>o'
  end

  minor_mode :save do
    map :save,     '<Control-s>'
    map :save_as,  '<Control-S>'
  end

  minor_mode :preview do
    map :eval_buffer,  '<Control-R>'
    map :tags_tooltip, '<Control-g>t'

    handler Methods::Preview
    map :preview, '<F5>'
  end

  minor_mode :basic do
    inherits :help, :preview, :save

    handler Methods::Basic
    map :minibuf_eval,    '<Alt-x>', '<Control-m>x'
    map :open_terminal,   '<F9>'
    map :open_console,    '<Control-exlam>' if defined?(::EM)
  end

  minor_mode :vim_layout do
    # map :quit!,            ':q!'
    map :quit,             '<Control-w>q', '<Control-w><Control-q>', ':q<Return>'
    map :close,            '<Control-w>c', ':clo<Return>'
    # map :close!,           ':clo!'

    handler :window
    map :split_horizontal, '<Control-w>s', '<Control-w><Control-s>', ':sh'
    map :split_vertical,   '<Control-w>v', '<Control-w><Control-v>', ':sv'
    map :new_horizontal,   '<Control-w>n', '<Control-w><Control-n>', ':n'
    map :only,             '<Control-w>o', '<Control-w><Control-o>', ':on<Return>'
    map :go_below,         '<Control-w>j', '<Control-w><Control-j>', '<Control-w><Down>'
    map :go_above,         '<Control-w>k', '<Control-w><Control-k>', '<Control-w><Up>'
    map :go_left,          '<Control-w>h', '<Control-w><Control-h>', '<Control-w><Left>', '<Control-w><BackSpace>'
    map :go_right,         '<Control-w>l', '<Control-w><Control-l>', '<Control-w><Right>'
  end

  minor_mode :layout do
    inherits :basic
    handler Methods::Layout

    map :hide,          '<Key-0>'
    map :create,        'c'
    map :close,         'w'
    map :peer,          'p'
  end

  minor_mode :layout_control do
    become :layout, '<Control-w>r'

    handler Methods::Layout
    map :change,     ['<Control-w>', :layout]
  end

  minor_mode :move do
    inherits :prefix

    map :ask_go_line, *(':<Key-1>'..':<Key-9>')

    handler Methods::Move
    map :prefix_arg_sol,  '<Key-0>'
    map :percent,         '%'

    handler :at_insert
    map :last_char,       '$', '<End>'
    map :first_line,      'gg'
    map :last_line,       'G'
    map :next_char,       'l', '<Right>', '<space>'
    map :next_chunk,      'W'
    map :next_chunk_end,  'E'
    map :next_line,       'j', '<Down>', '<Control-n>', '<Control-j>'
    map :next_line_nonblank, '+', '<Control-m>', '<Return>'
    map :next_page,       '<Control-f>', '<Next>'
    map :next_word,       'w'
    map :next_word_end,   'e'
    map :prev_char,       'h', '<Left>', '<BackSpace>'
    map :prev_chunk,      'B'
    map :prev_line,       'k', '<Up>', '<Control-p>'
    map :prev_page,       '<Control-b>', '<Prior>'
    map :prev_word,       'b'
    map :start_of_line,   '<Home>' # 0
    map :home_of_line,    '^'
    map :go_char,         '|'
    map :down_nonblank,   '_'
    map :prev_line_nonblank, '-'
  end

  minor_mode :prefix do
    # Sometimes Range really surprises me...
    map :update_prefix_arg, *('<Key-0>'..'<Key-9>')
  end

  minor_mode :search do
    handler Methods::Search

    map :char_left,               'F'
    map :till_char_left,          'T'
    map :char_right,              'f'
    map :till_char_right,         't'
    map :next,                    'n'
    map :next_word_under_cursor,  '*'
    map :prev,                    'N'
    map :prev_word_under_cursor,  '#'
    map :remove,                  'g/'
    map :status_next,             '/'
    map :status_prev,             '?'
    map :again_char,              ';'
    map :again_char_opposite,     ',,' # ',' is used as prefix for ',c' ',u'
  end

  minor_mode :ctags do
    handler Methods::CTags

    map :find_current,  '<Control-bracketright>' # C-]
    map :prev,          '<Control-bracketleft>'  # C-[
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

    map :aspell,     '<Control-x><Control-a>'
    map :contextual, '<Control-x><Control-x>'
    map :file,       '<Control-x><Control-f>'
    map :line,       '<Control-x><Control-l>'
    map :snippet,    '<Control-x><Control-s>'
    map :word,       '<Control-x><Control-w>'
    map :smart_tab,  '<Tab>'
  end

  minor_mode :delete do
    handler :at_insert
    map :change_next_word_end,    'cw'
    map :change_line,             'cc', 'S'
    map :change,                  's'
    map :changing,                ['c', :move]
    map :kill_line,               'dd'
    map :killing,                 ['d', :move]
    map [:changing, :last_char],  'C'
    map [:killing,  :last_char],  'D'
    map [:killing,  :next_char],  'x', '<Delete>'
    map [:killing,  :prev_char],  'X'
  end

  minor_mode :clipboard do
    handler :at_insert
    map :copy_line,  'yy','Y'
    map :copying,    ['y', :move]

    handler Methods::Clipboard
    map :paste_after,           'p'
    map :paste_before,          'P'
    map :paste_after_adjust,    ']p'
    map :paste_before_adjust,   '[p'
    map :paste_after_go_after,  'gp'
    map :paste_before_go_after, 'gP'
  end

  minor_mode :undo do
    handler Methods::Undo

    map :redo, '<Control-r>'
    map :undo, 'u'
  end

  minor_mode :macro do
    inherits :control

    become :control, 'q'

    handler Methods::Macro
    enter :enter
    leave :leave
  end

  minor_mode :control do
    inherits :basic, :move, :delete, :undo, :layout_control, :search, :ctags,
             :bookmark, :clipboard, :open

    become :insert,         'i', '<Insert>'
    become :replace,        'R'
    become :replace_char,   'r'
    become :select_block,   '<Control-v>'
    become :select_char,    'v'
    become :select_line,    'V'
    become :control,        '<Escape>'
    become :macro,          *('a'..'z').map{|c| "q#{c}" }

    handler Methods::Macro
    map :repeat, '@@'
    ('a'..'z').each{|c| map [:play, c], "@#{c}" }

    handler nil # whatever the widget happens to be
    map :repeat_action,           '.'
    map :quit,                    ':qa', 'ZZ'
    map :close,                   ':q<Return>', ':x'
    map [:touch!, '1.0', 'end'],  '<Control-l>'
    map :save,     ':w<Return>'
    map :save_as,  ':w<space>'
    map :save_all, ':wa'
    map :change_register, '"'

    handler RegisterList
    map :open, ':reg<Return>'
    map :show, ':reg<space>'

    handler Methods::Open
    map :file_open_ask, ':o<space>'

    handler :at_insert
    map :insert_newline_above,         'O'
    map :insert_newline_below,         'o'
    map :increase_number,              '<Control-a>'
    map :decrease_number,              '<Control-x>'
    map :toggle_case!,                 '~'
    map :toggle_casing,                ['g~', :move]
    map :lower_casing,                 ['gu', :move]
    map :upper_casing,                 ['gU', :move]
    map :encoding_rot13,               ['g?', :move]
    map [:change_at, :last_char],      'A'
    map [:change_at, :next_char],      'a'
    map [:change_at, :home_of_line],   'I'
    map [:change_at, :start_of_line],  'gI'

    handler Methods::Control
    enter :enter
    leave :leave

    map :chdir,  'gc'

    handler Methods::Control
    map :cursor_horizontal_center,    'gm'
    map :cursor_vertical_bottom,      'zb'
    map :cursor_vertical_bottom_sol,  'z-'
    map :cursor_vertical_center,      'zz'
    map :cursor_vertical_center_sol,  'z.'
    map :cursor_vertical_top,         'zt'
    map :cursor_vertical_top_sol,     'z<Return>'

    map :executor, '::'
    map [:ex, :buffer],       ':bu', '<Alt-b>', '<Control-m>b'
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

    map :wrap_line,               'gw'
    map :indent_line,             '>'
    map :unindent_line,           '<'
    map :join_forward,            'J'
    map :join_forward_nospace,    'gJ'
    map :open_file_under_cursor,  'gf'
    map :smart_evaluate,          '<Alt-e>', '<Control-m>e'

    handler Methods::SearchAndReplace
    map :query, '<Alt-percent>'
  end

  minor_mode :readline do
    map :accept_line,       '<Return>'

    map :last_char,         '<End>', '<Control-e>'
    map :insert_selection,  '<Shift-Insert>'
    map :insert_tab,        '<Control-v><Tab>', '<Control-i>'
    map :kill_last_char,    '<Control-k>'
    map :delete_next_char,  '<Control-d>', '<Delete>'
    map :delete_next_word,  '<Alt-d>'
    map :delete_prev_char,  '<BackSpace>'
    map :delete_prev_word,  '<Control-w>'
    map :next_char,         '<Right>', '<Control-f>'
    map :next_word,         '<Shift-Right>', '<Alt-f>'
    map :prev_char,         '<Left>', '<Control-b>'
    map :prev_word,         '<Shift-Left>', '<Alt-b>'
    map :start_of_line,     '<Home>', '<Control-a>'
    map :transpose_chars,   '<Control-t>'
    map :paste,             '<Control-y>'

    missing :insert_string
  end

  minor_mode :insert do
    inherits :basic, :layout_control, :complete
    become :control, '<Escape>', '<Control-c>'

    handler Methods::AutoFill
    map :auto_fill_space,  '<space>'

    handler :at_insert
    map :insert_char_above,      '<Control-y>'
    map :insert_char_below,      '<Control-e>'
    map :insert_digraph,         '<Control-k>'
    map :insert_newline,         '<Return>', '<Control-m>', '<Control-j>'
    map :insert_selection,       '<Shift-Insert>', '<Insert>'
    map :insert_tab,             '<Control-i>'
    map :last_char,              '<End>'
    map :next_char,              '<Right>'
    map :next_line,              '<Down>', '<Control-n>'
    map :next_page,              '<Control-f>', '<Next>', '<Shift-Down>'
    map :next_word,              '<Shift-Right>', '<Alt-f>'
    map :prev_char,              '<Left>'
    map :prev_line,              '<Up>', '<Control-p>'
    map :prev_page,              '<Control-b>', '<Prior>', '<Shift-Up>'
    map :prev_word,              '<Shift-Left>', '<Alt-b>'
    map :start_of_line,          '<Home>', '<Control-a>'
    map [:killing, :next_char],  '<Delete>'
    map [:killing, :prev_char],  '<BackSpace>', '<Control-h>'
    map [:killing, :prev_word],  '<Control-w>'

    handler Methods::Control
    map :smart_evaluate,   '<Alt-e>'
    map :temporary,        ['<Control-o>', :control]
    map :indent_line,      '<Control-t>'
    map :unindent_line,    '<Control-d>'
    if x11?
      map :unindent_line,  '<ISO_Left_Tab>'
    else
      map :unindent_line,  '<Shift-Tab>'
    end

    handler Methods::Insert
    map :literal,     '<Control-v>', '<Control-q>'
    missing :string
  end

  minor_mode :replace do
    become :control, '<Escape>', '<Control-c>'

    handler Methods::Insert
    enter :enter_replace
    leave :leave_replace
    map [:replace_string, "\n"], '<Return>'
    missing :replace_string
  end

  minor_mode :replace_char do
    become :control, '<Escape>', '<Control-c>'

    handler Methods::Insert
    map [:replace_char, "\n"], '<Return>'
    missing :replace_char
  end

  minor_mode :search_and_replace do
    become :control, '<Escape>', '<Control-c>', 'q'

    handler Methods::SearchAndReplace
    enter :enter
    leave :leave

    map :replace_all,  'a', '<exclam>'
    map :replace_once, 'y'
    map :next,         'n', 's', 'j', '<Control-n>'
    map :prev,         'k', '<Control-p>'
  end

  minor_mode :select do
    inherits :basic, :move, :search

    handler nil
    map :change_register, '"'

    handler :at_sel
    map :comment,             ',c'
    map :copy,                'y', 'Y'
    map :indent,              '<greater>'
    map :kill,                'd', 'D', 'x', '<BackSpace>', '<Delete>'
    map :lower_case!,         'u'
    map :replace_string,      'c'
    map :replace_string_eol,  'C'
    map :toggle_case!,        '~'
    map :upper_case!,         'U'
    map :uncomment,           ',u'
    map :unindent,            '<less>'
    map :string_operation,    '<F19>'
    map :array_operation,     '<Alt-F7>'
    map :line_operation,      '<F7>'
    map :encode_rot13!,       'g?'
    map [:join, ' '],         'J'
    map [:join, ''],          'gJ'
    map :change_linestart,    'I'
    map :change_lineend,      'A'

    handler Methods::Control
    map :smart_evaluate,   '<Alt-e>', '<Control-e>'

    handler Methods::Selection
    map :pipe,            '<exclam>'
  end

  minor_mode :select_char do
    inherits :select

    become :control,             '<Escape>', '<Control-c>'
    become :select_line,         'V'
    become :select_block,        '<Control-v>'
    become :select_replace_char, 'r'

    handler :at_sel
    enter :enter
    leave :leave
    map :wrap, 'gw'
    map :change, 'c', 's'
  end

  minor_mode :select_line do
    inherits :select

    become :control,             '<Escape>', '<Control-c>'
    become :select_char,         'v'
    become :select_block,        '<Control-v>'
    become :select_replace_char, 'r'

    handler :at_sel
    enter :enter
    leave :leave
    map :wrap, 'gw'
    map :change, 'c', 's'
  end

  minor_mode :select_block do
    inherits :select

    become :control,             '<Escape>', '<Control-c>'
    become :select_char,         'v'
    become :select_line,         'V'
    become :select_replace_char, 'r'

    handler :at_sel
    enter :enter
    leave :leave
  end

  minor_mode :select_replace_char do
    become :control, '<Escape>', '<Control-c>'

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
    map :cancel, '<Escape>', '<Control-c>'
    map :jump,   '<Tab>'

    missing :on_insert
  end

  major_mode :Fundamental do
    use :control
  end

  major_mode :MiniBuffer do
    use :readline

    map :abort,           '<Escape>', '<Control-c>'
    map :attempt,         '<Return>'
    map :complete_large,  '<Control-d>'
    map :complete_small,  '<Tab>'
    map :next_history,    '<Down>'
    map :prev_history,    '<Up>'
  end

  major_mode :Completions do
    handler MiniBuffer
    # map :answer_from, '<Button-1>'
  end

  major_mode :Executor do
    use :executor_label
  end

  minor_mode :executor_entry do
    inherits :readline

    map :completion, '<Tab>'
    map :cancel,     '<Escape>'
    map :next_line,  '<Down>', '<Control-j>', '<Control-n>'
    map :prev_line,  '<Up>', '<Control-k>', '<Control-p>'
  end

  minor_mode :executor_label do
    inherits :executor_entry

    map :speed_selection,  '<space>'

    missing :insert_string
  end
end
