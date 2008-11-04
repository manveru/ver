chars = (0..255).map{|c| c.chr }.grep(/[[:print:]]/)
chars_regex = Regexp.union(*chars)

VER.let :insert do
  map(/^(#{chars_regex})$/){ cursor.insert(@arg) }
  map('backspace'){          cursor.insert_backspace }
  map('dc'){                 cursor.insert_delete }
  map('return'){             cursor.insert_newline }
  map('space'){              cursor.insert(' ') }
  map(/^(C-c|C-q|esc)$/){    view.mode = :control }
end

VER.let :control => [:insert, :movement] do
  # Movement
  map(/^(up|down|left|right)$/){ cursor.send(@arg) }

  map('npage'){ methods.page_down }
  map('ppage'){ methods.page_up }

  map('C-c'){ methods.copy }
  map('C-g'){ methods.goto_line_ask }
  map('C-q'){ methods.ver_stop }
  map('C-w'){ methods.buffer_close }
  map('C-space'){ methods.start_selection }
  map('C-v'){ cursor.insert(VER.clipboard.last) }
  map('C-x'){ methods.cut }
  map('C-o'){ VER::View::AskFile.open }
  map('C-s'){ VER.info("Saved to: #{buffer.save_file}") }
  map('M-n'){ methods.scroll(1) }
  map('M-p'){ methods.scroll(-1) }
end

VER.let :ask => :insert do
  map('return'){ methods.pick }
  map('tab'){ view.update_choices; view.try_completion }
  map('up'){ methods.history_backward }
  map('down'){ methods.history_forward }
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
