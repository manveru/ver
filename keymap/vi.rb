VER.map :insert, :control, :replace, :ask, :help, :doc do
  # Basic Movement

  key :up,    :up
  key :down,  :down
  key :left,  :left
  key :right, :right

  key 'C-f', :page_down
  key 'C-b', :page_up
  key 'ppage', :page_up
  key 'npage', :page_down

  # Function keys

  key 'F1',     :show_help
  key 'F2',     :show_doc

  # seems to be triggered only on events, not the actual resize...
  key 'resize', :resize
  key 'C-l',    :resize

  # Switching buffers real fast
  (1..9).each{|n| key("M-#{n}", :buffer_jump, n - 1) }
end

VER.map :insert, :ask, :ask_file, :ask_grep do
  VER::Keyboard::PRINTABLE.each do |char|
    key(char, :insert_character, char)
  end

  key :space,     :insert_space
  key :return,    :insert_return
  key :backspace, :insert_backspace
  key :dc,        :insert_delete

  # Mode switches

  key :esc,  :into_control_mode
  key 'C-c', :into_control_mode # esc is slow due to timeout
end

VER.map :control, :help do
  word_break = VER::Config[:word_break].value
  chunk_break = VER::Config[:chunk_break].value

  key '$',   :end_of_line
  key '0',   :beginning_of_line
  key :A,    :append_at_end_of_line
  key :I,    :insert_at_beginning_of_line
  key :J,    :join_line_up
  key :a,    :append
  key :s,    :delete_then_input
  key :O,    :insert_newline_above_then_insert
  key :o,    :insert_newline_below_then_insert
  # key(:d, :delete_selection){|view| view.selection }

  # Deleting movements
  key [:d, :h],     :delete_movement, :left
  key [:d, :j],     :delete_movement, :down
  key [:d, :k],     :delete_movement, :up
  key [:d, :l],     :delete_movement, :right
  key [:d, :up],    :delete_movement, :up
  key [:d, :down],  :delete_movement, :down
  key [:d, :left],  :delete_movement, :left
  key [:d, :right], :delete_movement, :right
  key [:d, :w],     :delete_movement, :word_right
  key [:d, :W],     :delete_movement, :chunk_right
  key [:d, :b],     :delete_movement, :word_left
  key [:d, :B],     :delete_movement, :chunk_left
  key [:d, :v],     :delete_selection
  key [:d, :V],     :delete_selection
  key [:d, :d],     :delete_line
  key :D,           :delete_to_end_of_line

  # Replacing movements

  key [:r, :space],  :replace, ' '
  key [:r, :return], :replace, "\n"
  VER::Keyboard::PRINTABLE.each do |char|
    key [:r, char], :replace, char
  end

  key :v,       :start_selection
  key :V,       :start_selecting_line
  key :y,       :copy
  key :Y,       :copy_line
  key :p,       :paste_after
  key :P,       :paste_before
  key 'C-l',    :recenter_view
  key :u,       :undo
  key 'C-r',    :unundo
  key 'C-x',    :execute
  key 'F7',     :ruby_filter
  key :G,       :goto_end_of_buffer
  key [:g, :g], :goto_line, 0

  # Searching
  key :/,    :search
  key :n,    :next_highlight
  key :N,    :previous_highlight

  # Grepping
  key 'C-g', :ask_grep
  key [:g, :n], :next_grep
  key [:g, :N], :previous_grep

  # buffer state
  key 'C-o', :ask_file
  key 'M-o', :ask_fuzzy_file
  key 'C-s', :buffer_persist
  key 'M-b', :buffer_select
  key 'C-w', :buffer_close
  key 'C-q', :window_close

  # mode switches

  key :R,   :into_replace_mode
  key :i,   :into_insert_mode
  key :esc,  :into_control_mode
  key 'C-c', :into_control_mode # esc is slow due to timeout

  # move

  key :h, :left
  key :j, :down
  key :k, :up
  key :l, :right

  key :w, :word_right
  key :W, :chunk_right
  key :b, :word_left
  key :B, :chunk_left
end

VER.map :help do
  key :q, :view_close
  key :/, :help_grep
end

VER.map :doc do
  key :q, :view_close
  key :/, :doc_grep
end

VER.map :replace do
  key :space,     :replace_space
  key :return,    :replace_return
  key :backspace, :replace_backspace
  key :dc,        :replace_delete

  # mode switches

  key :esc,  :into_control_mode
  key 'C-c', :into_control_mode # esc is slow due to timeout
end

VER.map :ask, :ask_file, :ask_grep do
  key :return,    :pick
  key :tab,       :completion

  # mode switches

  key 'C-q', :stop
  key 'C-c', :stop
  key :esc,  :stop
end

VER.map :ask_file do
  key :up, :up
  key :down, :down
end

VER.map :ask_grep do
  key :up, :up
  key :down, :down
  key :left, :left
  key :right, :right
end
