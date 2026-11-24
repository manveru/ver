require_relative '../../lib/ver/methods/helix'

module VER
  minor_mode :helix_commands do
    map :update_prefix_arg, *('<Key-0>'..'<Key-9>')
    map :change_register, '"'

    handler Methods::Helix
    map :collapse,            ';'
    map :select_all,          '%'
    map :select_lines,        'x'
    map [:select_lines, false], 'X'
    map :yank,                'y'
    map :delete,              'd', '<Delete>'
    map [:delete, false],     '<Alt-d>'
    map :change,              'c'
    map [:change, false],     '<Alt-c>'
    map [:paste, :last],      'p'
    map [:paste, :first],     'P'
    map [:insert_at, :first], 'i'
    map [:insert_at, :last],  'a'
    map [:insert_on_line, :first, :linestart], 'I'
    map [:insert_on_line, :last, :lineend],    'A'
    map [:open_line, :first, :insert_newline_above], 'O'
    map [:open_line, :last, :insert_newline_below],   'o'
    map :replace_character,   'r'
    map :replace_with_yanked, 'R'
    map [:search, :forward],        '/'
    map [:search, :backward],       '?'
    map [:search_match, :forward],  'n'
    map [:search_match, :backward], 'N'
    map [:history, :undo],    'u'
    map [:history, :redo],    'U'

    map :command_prompt, ':'

    handler Methods::Control
    map [:ex, :fuzzy],  '<space>f', '<space>F'
    map [:ex, :buffer], '<space>b'

    handler nil
    map :close, '<Control-w>q', '<space>wq'
  end

  minor_mode :helix_motion do
    handler Methods::Helix
    map [:move, :left],     'h', '<Left>'
    map [:move, :right],    'l', '<Right>'
    map [:move, :next_line], 'j', '<Down>', 'gj'
    map [:move, :prev_line], 'k', '<Up>', 'gk'
    map [:move, :start_of_line], '<Home>', 'gh'
    map [:move, :last_char], '<End>', 'gl'
    map [:move, :home_of_line], 'gs'
    map [:goto_line, 1], 'gg'
    map :goto_line, 'G'
    map [:move, :last_line],  'ge'
    map [:move, :next_page],  '<Control-f>', '<Next>'
    map [:move, :prev_page],  '<Control-b>', '<Prior>'
    map [:move, :matching_brace], 'mm'
    map [:word, :next_start],       'w'
    map [:word, :next_start, true], 'W'
    map [:word, :next_end],         'e'
    map [:word, :next_end, true],   'E'
    map [:word, :previous, true],   'B'
    map [:word, :previous],         'b'
    map [:find_character, :forward], 'f'
    map [:find_character, :forward, true], 't'
    map [:find_character, :backward], 'F'
    map [:find_character, :backward, true], 'T'

    map [:text_object, :inside], 'mi'
    map [:text_object, :around], 'ma'
  end

  minor_mode :control do
    inherits :helix_motion, :helix_commands
    become :select_char, 'v'
    become :control, '<Escape>'
  end

  minor_mode :select_char do
    inherits :helix_motion, :helix_commands
    become :control, 'v', '<Escape>'
  end

  minor_mode :insert do
    become :control, '<Escape>'

    handler :at_insert
    map :insert_newline, '<Return>', '<Control-j>'
    map :insert_tab, '<Tab>'
    map :prev_char, '<Left>'
    map :next_char, '<Right>'
    map :prev_line, '<Up>'
    map :next_line, '<Down>'
    map :start_of_line, '<Home>'
    map :last_char, '<End>'
    map [:deleting, :prev_word], '<Control-w>', '<Alt-BackSpace>'
    map [:deleting, :next_word], '<Alt-d>', '<Alt-Delete>'
    map [:deleting, :start_of_line], '<Control-u>'
    map [:deleting, :last_char], '<Control-k>'

    handler Methods::Helix
    enter :start_insert_undo
    leave :finish_insert
    map [:insert_delete, :left], '<BackSpace>', '<Control-h>', '<Shift-BackSpace>'
    map [:insert_delete, :right], '<Delete>', '<Control-d>'

    handler Methods::Insert
    missing :string
  end

  minor_mode :readline do
    map :start_of_line, '<Home>', '<Control-a>'
    map :last_char, '<End>', '<Control-e>'
    map :prev_char, '<Left>'
    map :next_char, '<Right>'
    map :delete_prev_char, '<BackSpace>'
    map :delete_next_char, '<Delete>'
    missing :insert_string
  end

  major_mode :Fundamental do
    use :control
  end

  major_mode :MiniBuffer do
    use :readline
    map :abort, '<Escape>', '<Control-c>'
    map :attempt, '<Return>'
    map :complete_small, '<Tab>'
    map :next_history, '<Down>'
    map :prev_history, '<Up>'
  end

  major_mode :Executor do
    use :executor_label
  end

  minor_mode :executor_entry do
    inherits :readline
    map :accept_line, '<Return>'
    map :completion, '<Tab>'
    map :cancel, '<Escape>'
    map :next_line, '<Down>'
    map :prev_line, '<Up>'
  end

  minor_mode :executor_label do
    inherits :executor_entry
    map :speed_selection, '<space>'
  end
end
