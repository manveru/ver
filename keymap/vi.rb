chars = (0..255).map{|c| c.chr }.grep(/[[:print:]]/)
chars_regex = Regexp.union(*chars)

VER.let :general_movement do
  # Movement
  map(/^(up|down|left|right)$/){ cursor.send(@arg) }
end

VER.let :general => :general_movement do
  map(/C-f|npage/){ methods.page_down }
  map(/C-b|ppage/){ methods.page_up }

  # Function keys

  map('F1'){ VER.doc(/ver/) }
  map('F2'){ VER.help }

  # seems to be triggered only on events, not the actual resize
  map(/C-l|resize/){ VER::View.resize }

  # Switching buffers real fast
  # (1..9).each{|n| key("M-#{n}", :buffer_jump, n - 1) }
  map(/M-(\d)/){|m| view.buffer = view.buffers[m.to_i - 1] }
end

VER.let :control_movement => :general_movement do
  map('0'){ cursor.beginning_of_line }
  map('$'){ cursor.end_of_line }

  map('w'){ jump_right(:word)  }
  map('b'){ jump_left(:word)   }
  map('W'){ jump_right(:chunk) }
  map('B'){ jump_left(:chunk)  }

  macro('h', 'left')
  macro('j', 'down')
  macro('k', 'up')
  macro('l', 'right')
end

VER.let :control => [:general, :control_movement] do
  map(/q (#{chars_regex})/){ start_macro(@arg) }
  map(/q (#{chars_regex})/){ play_macro(@arg) }

  map('C-g'){ VER::View::AskGrep.open }
  map('C-o'){ VER::View::AskFile.open }
  map('C-q'){ VER.stop }
  map('C-s'){ VER.info("Saved to: #{buffer.save_file}") }
  map('C-w'){ methods.buffer_close }
  map('C-x'){ methods.execute_ask }

  map('M-b'){ methods.buffer_ask }
  map('M-o'){ VER::View::AskFuzzyFile.open }

  map('G'){
    cursor.pos = buffer.size - 1
    cursor.beginning_of_line
  }
  0.upto(7) do |n|
    key = [/[1-9]/] + ([/\d/] * n) << 'g'
    map(key){ methods.goto_line(@args.join.to_i) }
  end

  # TODO: should take other mode as list of mappings after prefix key
  movement = /^(up|down|left|right|[0wbWBhjkl$])$/
  map(["d", movement]){ cursor.virtual{ press(@arg); cursor.delete_range } }
  map(["c", movement]){ cursor.virtual{ press(@arg); cursor.delete_range }; press('i') }

  map('v'){ methods.start_selection }
  map('V'){ press('v'); view.selection[:linewise] = true }

  map('y'){ methods.copy }
  map('Y'){ methods.copy_lines }

  map('p'){ cursor.insert(VER.clipboard.last) }
  map('P'){ cursor.insert(VER.clipboard.last) }

  map('/'){ methods.search_ask }
  map('n'){ methods.search_next }
  map('N'){ methods.search_previous }

  map('i'){ view.mode = :insert }

  macro('a', 'l i')
  macro('A', '$ a')
  macro('I', '0 i')
  macro('O', "0 i return C-c k")
  macro('o', "$ i return C-c j")
  macro('D', 'd $')
  macro('C', 'd $ i')
  macro('d d', '0 d $')
  macro('g g', '1 g')
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
  map('return'){              methods.pick }
  map('tab'){                 view.update_choices; view.try_completion }
  map('up'){                  methods.history_backward }
  map('down'){                methods.history_forward }
  map(/^(C-g|C-q|C-c|esc)$/){ view.close; VER::View[:file].open }
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
