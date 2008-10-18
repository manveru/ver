VER::KeyMap.let :insert do
  keys VER::Keyboard::PRINTABLE, :insert_character
  key :space,     :insert_space
  key :return,    :insert_return
  key :backspace, :insert_backspace
  key :dc,        :insert_delete

  # move

  key :up, :up
  key :down, :down
  key :left, :left
  key :right, :right

  # mode switches

  key :esc,  :into_control_mode
  key 'C-c', :into_control_mode # esc is slow due to timeout
end

VER::KeyMap.let :control do
  key '$',   :end_of_line
  key '0',   :beginning_of_line
  key :A,    :append_at_end_of_line
  key :I,    :insert_at_beginning_of_line
  key :J,    :join_line_down
  key :a,    :append
  key :s,    :delete_then_input
  key :O,    :insert_newline_above_then_insert
  key :o,    :insert_newline_below_then_insert
  key :D,    :delete_to_end_of_line
  key :u,    :undo
  key 'C-r', :unundo
  key 'C-l', :window_resize
  key 'C-o', :buffer_open
  key 'C-q', :buffer_close
  key 'C-s', :buffer_persist

  # mode switches

  key :R,   :into_replace_mode
  key :esc, :into_control_mode
  key :i,   :into_insert_mode

  key 'F1', :show_help

  # move

  key :h, :left
  key :j, :down
  key :k, :up
  key :l, :right

  key :up, :up
  key :down, :down
  key :left, :left
  key :right, :right

  key :w, :word_right
  key :W, :chunk_right
  key :b, :word_left
  key :B, :chunk_left
end

VER::KeyMap.let :help do
  key :q, :hide_help
end

VER::KeyMap.let :ask do
  keys VER::Keyboard::PRINTABLE, :insert_character
  key :space,     :insert_space
  key :backspace, :insert_backspace
  key :dc,        :insert_delete
  key :return,    :answer_question
  key :tab,       :completion

  # move

  key :up, :up
  key :down, :down
  key :left, :left
  key :right, :right

  # mode switches

  key 'C-q', :stop_asking
  key 'C-c', :stop_asking
end
