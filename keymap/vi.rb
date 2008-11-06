chars = (0..255).map{|c| c.chr }.grep(/[[:print:]]/)
chars_regex = Regexp.union(*chars)

VER.let :general_movement do
  # Movement
  map(/^(up|down|left|right)$/){ cursor.send(@arg) }
end

VER.let :general => :general_movement do
  map(/^(C-f|npage)$/){ page_down }
  map(/^(C-b|ppage)$/){ page_up }

  # Function keys

  map('F1'){ VER.doc(/ver/) }
  map('F2'){ VER.help }

  # seems to be triggered only on events, not the actual resize
  map(/^(C-l|resize)$/){ VER::View.resize }

  # Switching buffers real fast
  map(/^M-(\d)$/){ view.buffer = view.buffers[@arg.to_i - 1] }
end

VER.let :control_movement => :general_movement do
  map('0'){ cursor.beginning_of_line }
  map('$'){ cursor.end_of_line }

  map('w'){ jump_right(/[\w.-]+/)  }
  map('b'){ jump_left(/[^\w.-]+/)   }
  map('W'){ jump_right(/\S+/) }
  map('B'){ jump_left(/\s+/)  }

  macro('h', 'left')
  macro('j', 'down')
  macro('k', 'up')
  macro('l', 'right')
end

VER.let :control => [:general, :control_movement] do
  map(/^q (#{chars_regex})$/){ start_macro(@arg) }
  map(/^q (#{chars_regex})$/){ play_macro(@arg) }

  map('C-g'){ VER::View::AskGrep.open }
  map('C-o'){ VER::View::AskFile.open }
  map('C-q'){ VER.stop }
  map('C-s'){ VER.info("Saved to: #{buffer.save_file}") }
  map('M-s'){ save_as_ask }
  map('C-w'){ buffer_close }
  map('C-x'){ execute_ask }

  map('M-b'){ buffer_ask }
  map('M-o'){ VER::View::AskFuzzyFile.open }

  map('G'){
    cursor.pos = buffer.size - 1
    cursor.beginning_of_line
  }
  0.upto(7) do |n|
    key = [/^[1-9]$/] + ([/^\d$/] * n) << 'g'
    map(key){ goto_line(@args.join.to_i) }
  end

  # TODO: should take other mode as list of mappings after prefix key
  movement = /^(up|down|left|right|[0wbWBhjkl$])$/
  map(["d", movement]){ cursor.virtual{ press(@arg); cursor.delete_range } }
  map(["c", movement]){ cursor.virtual{ press(@arg); cursor.delete_range }; press('i') }

  map('v'){ start_selection }
  map('V'){ start_selection(linewise = true) }

  map('y'){ copy }
  map('Y'){ copy_lines }

  map('p'){ cursor.insert(VER.clipboard.last) }
  map('P'){ cursor.insert(VER.clipboard.last) }

  map('/'){ search_ask }
  map('n'){ search_next }
  map('N'){ search_previous }

  map('i'){ view.mode = :insert }

  macro('a', 'l i')
  macro('A', '$ a')
  macro('I', '0 i')
  macro('o', "$ i return")
  macro('O', "0 i return up")
  macro('D', 'd $')
  macro('C', 'd $ i')
  macro('d d', '0 d $')
  macro('g g', '1 g')
end

VER.let :selection => :control do
  map('d'){ cut }
  map(/^(C-c|C-q|esc)$/){ view.selection = nil }
end

VER.let :insert => :general do
  map(/^(#{chars_regex})$/){ cursor.insert(@arg) }
  map('backspace'){          cursor.insert_backspace }
  map('dc'){                 cursor.insert_delete }
  map('return'){             cursor.insert_newline }
  map('space'){              cursor.insert(' ') }
  map(/^(C-c|C-q|esc)$/){    view.mode = :control }
end

VER.let :ask => [:insert, :general_movement] do
  map('return'){              pick }
  map('tab'){                 view.update_choices; view.try_completion }
  map('up'){                  history_backward }
  map('down'){                history_forward }
  map(/^(C-g|C-q|C-c|esc)$/){ view.close; VER::View[:file].open }
end

VER.let :ask_choice => [:insert, :general_movement] do
  map(/^(C-g|C-q|C-c|esc)$/){ view.close; VER::View[:file].open }
  map('return'){ pick }
end

VER.let :ask_large => :ask do
  map('up'){   view.select_above }
  map('down'){ view.select_below }
  map('tab'){  view.expand_input }

  after(/^(#{chars_regex})$/, 'backspace', 'space', 'dc'){ view.update_choices }
end

VER.let :ask_file => :ask_large
VER.let :ask_fuzzy_file => :ask_large
VER.let :ask_grep => :ask_large
