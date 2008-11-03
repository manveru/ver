chars = (0..255).map{|c| c.chr }.grep(/[[:print:]]/)
chars_regex = Regexp.union(*chars)

VER.let :control do
  # Movement
  map(/^(up|down|left|right)$/){ cursor.send(@arg) }

  map('npage'){ methods.page_down }
  map('ppage'){ methods.page_up }

  map('M-n'){ methods.scroll(1) }
  map('M-p'){ methods.scroll(-1) }
  map('C-space'){ methods.start_selection }
  map('C-c'){ methods.copy }
  map('C-x'){ methods.cut }
  map('C-v'){ cursor.insert(VER.clipboard.last) }

  map(/^(#{chars_regex})$/){ cursor.insert(@arg) }
  map('backspace'){ cursor.insert_backspace }
  map('dc'){ cursor.insert_delete }
  map('return'){ cursor.insert_newline }
  map('space'){ cursor.insert(' ') }

  map('C-g'){ methods.goto_line_ask }
  map('C-q'){ VER.stop }
end
