chars_regex = VER::Keyboard::PRINTABLE_REGEX

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

  macro('h',       'left')
  macro('j',       'down')
  macro('k',       'up')
  macro('l',       'right')
  macro('home',    '0')
  macro('end',     '$')
  macro('C-right', 'W')
  macro('C-left',  'B')

  # optimized countmaps for basic movement
  count_map(7, /^down|j$/){ @count.times{ cursor.down } }
  count_map(7, /^up|k$/){ @count.times{ cursor.up } }
  count_map(7, /^left|h$/){ @count.times{ cursor.left } }
  count_map(7, /^right|l$/){ @count.times{ cursor.right } }

  count_map(7, /^[wbWB]$/){ press(@trigger, @count) }
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

  # TODO: should take other mode as list of mappings after prefix key
  movement = /^(up|down|left|right|[0wbWBhjkl$])$/
  map(["d", movement]){ cursor.virtual{ press(@arg); cursor.delete_range } }
  map(["c", movement]){ cursor.virtual{ press(@arg); cursor.delete_range }; press('i') }

  count_map(7, 'g'){ goto_line(@count) }
  count_map(2, '%'){ goto_percent(@count) }

  map(/^(x|dc)$/){ cursor.insert_delete }
  map("X"){ cursor.insert_backspace }

  map(["r", /^[[:print:]]$/]){ cursor.replace(@arg) }
  map(["r", "return"]){ cursor.replace("\n") }

  map('~'){ toggle_case }

  map('>'){ indent_line }
  map('<'){ unindent_line }

  map('v'){   start_selection }
  map('V'){   start_selection(:linewise) }
  map('C-v'){ start_selection(:block) }

  map('Y'){ press('V'); copy }
  map(['y', movement]){ press('v'); press(@arg); press('y') }

  map('p'){ paste_after }
  map('P'){ paste_before }

  map('/'){ search_ask }
  map('n'){ search_next }
  map('N'){ search_previous }

  map('i'){ view.mode = :insert }

  macro('a', 'l i')
  macro('A', '$ i')
  macro('I', '0 i')
  macro('o', "$ i return")
  macro('O', "0 i return up")
  macro('D', 'd $')
  macro('C', 'd $ i')
  macro('y y', 'Y')
  macro('d d', '0 d $ d l')
  macro('g g', '1 g')
end

VER.let :selection => :control do
  map('v'){   selection[:selecting] = nil }
  map('V'){   selection[:selecting] = :linewise }
  map('C-v'){ selection[:selecting] = :block }

  map(/^[dxX]$/){ cut }
  map('y'){ copy }
  map('Y'){ press('V'); press('y') }
  map(/^(C-c|C-q|esc)$/){ view.selection = nil }

  map('~'){ toggle_selection_case }
  map('>'){ indent_selection }
  map('<'){ unindent_selection }
  map('!'){ filter_selection_ask }
end

VER.let :insert => :general do
  map(/^(#{chars_regex})$/){ cursor.insert(@arg) }
  map('backspace'){          cursor.insert_backspace }
  map('dc'){                 cursor.insert_delete }
  map('return'){             cursor.insert_newline }
  map('space'){              cursor.insert(' ') }
  map(/^(C-c|C-q|esc)$/){    view.mode = :control }

  # should be smart and stick to last chosen completion
  map('tab'){ complete }
end

VER.let :ask => [:insert, :general_movement] do
  map('return'){ pick }
  map('tab'){ view.update_choices; view.try_completion }
  map('up'){ history_backward }
  map('down'){ history_forward }
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

VER.let :complete => :ask_large do
  map(/^C-(p|k)$/){ select_above }
  map(/^C-(n|j)$/){ select_below }
  map('tab'){ select_below }

  map(/^(C-g|C-q|C-c|esc)$/){
    view.close
    VER::View[:file].mode = :insert
    VER::View[:file].open
  }
end

completions = {
  'C-w' => :word,
  'C-l' => :line,
  'C-o' => :omni,
  'C-f' => :file,
  'C-s' => :spell,
}

completions.each do |key, value|
  VER.let(:insert){
    map(['C-x', key]){ complete(value) }
  }
  VER.let("complete_#{value}".to_sym => :complete){
    map(['C-x', key]){ select_below }
  }
end
