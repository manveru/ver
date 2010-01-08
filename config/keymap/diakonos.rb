diakonos = VER::Keymap.new(name: :diakonos, mode: :buffer)

diakonos.arguments = false

diakonos.in_mode :basic do
  key :quit, %w[Control-q]
end

diakonos.in_mode :buffers do
  key :view_close, %w[Control-w]

  1.upto(9) do |n|
    key [:view_focus, n], ["Alt-#{n}"], ["Escape", n.to_s]
  end
end

diakonos.in_mode :readline do
  key [:kill_motion, :backward_char],   %w[BackSpace]
  key [:kill_motion, :forward_char],    %w[Delete], %w[Control-d]
  key [:kill_motion, :backward_word],   %w[Control-w]
  key :backward_char,                   %w[Left], %w[Control-b]
  key :forward_char,                    %w[Right], %w[Control-f]
  key :backward_word,                   %w[Shift-Left], %w[Alt-b]
  key :forward_word,                    %w[Shift-Right], %w[Alt-f]
  key :beginning_of_line,               %w[Home], %w[Control-a]
  key :end_of_line,                     %w[End], %w[Control-e]
  key :insert_selection,                %w[Shift-Insert]
  key :accept_line,                     %w[Return]
  key :previous_history,                %w[Up], %w[Control-p]
  key :next_history,                    %w[Down], %w[Control-n]
  key :beginning_of_history,            %w[Control-less]
  key :end_of_history,                  %w[Control-greater]
  key :transpose_chars,                 %w[Control-t]
  key :insert_tab,                      %w[Control-v Tab]

  KEYSYMS.each do |sym, name|
    key [:insert_string, sym], [name]
  end
end

diakonos.in_mode :status_query do
  inherits :basic, :readline

  key :ask_abort,        %w[Escape], %w[Control-c]
  key :history_prev,     %w[Up], %w[Control-p]
  key :history_next,     %w[Down], %w[Control-n]
  key :history_complete, %w[Tab]
  key :ask_submit,       %w[Return]

  missing :insert_string
end

diakonos.in_mode :bookmark do
  key :bookmark_toggle, %w[Alt-b Alt-b]
  key :next_bookmark,   %w[Alt-b Alt-n]
  key :prev_bookmark,   %w[Alt-b Alt-p]

  key :named_bookmark_add,    %w[Alt-b Alt-a]
  key :named_bookmark_remove, %w[Alt-b Alt-r]
  key :named_bookmark_visit,  %w[Alt-b Alt-g]

  # these are only valid on US keymap, don't know a better way.
  key [:named_bookmark_add, '1'], %w[Alt-b Alt-exclam]
  key [:named_bookmark_add, '2'], %w[Alt-b Alt-at]
  key [:named_bookmark_add, '3'], %w[Alt-b Alt-numbersign]
  key [:named_bookmark_add, '4'], %w[Alt-b Alt-dollar]
  key [:named_bookmark_add, '5'], %w[Alt-b Alt-percent]

  key [:named_bookmark_visit, '1'], %w[Alt-b Alt-1]
  key [:named_bookmark_visit, '2'], %w[Alt-b Alt-2]
  key [:named_bookmark_visit, '3'], %w[Alt-b Alt-3]
  key [:named_bookmark_visit, '4'], %w[Alt-b Alt-4]
  key [:named_bookmark_visit, '5'], %w[Alt-b Alt-5]
end

diakonos.in_mode :ctags do
  key :ctags_go,           %w[Alt-t]
  key :ctags_find_current, %w[Alt-parenright]
  key :ctags_prev,         %w[Alt-parenleft]
end

diakonos.in_mode :search do
  key :status_search_next, %w[Control-f]
  key :search_next,        %w[F3]
  key :search_clear,       %w[Control-Alt-u]

  # TODO: this doesn't work, investiate.
  key :search_prev,        %w[Shift-F3]
end

diakonos.in_mode :select do
  key :start_select_char_mode, %w[Control-space]
  key :start_select_line_mode, %w[Escape Control-space], %w[Control-Alt-space]
end

diakonos.in_mode :buffer do
  inherits :basic, :buffers, :readline, :bookmark, :search, :select

  key :backward_char,      %w[Left]
  key :forward_char,       %w[Right]
  key :previous_line,      %w[Up]
  key :next_line,          %w[Down]
  key :beginning_of_line,  %w[Home]
  key :end_of_line,        %w[End]
  key :page_up,            %w[Prior]
  key :page_down,          %w[Next]
  key :end_of_file,        %w[Alt-greater]
  key :go_line,            %w[Alt-less]

  key :forward_scroll,  %w[Alt-n]
  key :backward_scroll, %w[Alt-p]

  key [:delete_motion, :backward_char], %w[BackSpace]
  key [:delete_motion, :forward_char],  %w[Delete]
  key :kill_line,                       %w[Control-k], %w[Control-d Control-d]
  key [:delete_motion, :end_of_line],   %w[Control-Alt-k], %w[Control-d dollar]
  key [:delete_motion, :end_of_line],   %w[Control-Alt-k], %w[Control-d dollar]

  key :insert_indented_newline, %w[Return]

  key :indent_line,   %w[Alt-i], %w[Escape i]
  key :unindent_line, %w[Alt-I], %w[Escape I]

  key :complete_word, %w[Alt-e], %w[Escape e]

  key :exec_into_new,  %w[F2]
  key :exec_into_void, %w[F8]
  key [:exec_into_new, 'ruby -c $f'], %w[Control-Alt-c]

  key :insert_tab, %w[Control-t]
  key :paste,      %w[Control-v]
  key :undo,       %w[Control-z]
  key :redo,       %w[Control-y]

=begin
  # TODO
  key :top_of_view,        %w[Alt-comma], %w[Escape comma]
  key :bottom_of_view,     %w[Alt-period], %w[Escape period]
  key :previous_cursor,    %w[Control-j]
  key :forward_cursor,     %w[Control-l]

  key :ask_go_line,        %w[Control-g]


  key :forward_join_lines, %w[Alt-j], %w[Escape j]
  key :backward_join_lines, %w[Alt-J], %w[Escape J]
=end

  KEYSYMS.each do |sym, name|
    key [:insert_string, sym], [name]
  end

  missing :insert_string
end

diakonos.in_mode :select_char do
  inherits :buffer

  key :copy_selection, %w[Control-c]
  key :kill_selection, %w[Control-x]
  key :delete_selection, %w[BackSpace], %w[Delete]
  key :replace_selection_with_clipboard, %w[Control-v]
end

diakonos.in_mode :hover_completion do
  inherits :basic

  key :go_up,               %w[Up], %w[Control-n]
  key :go_down,             %w[Down], %w[Control-p]
  key :continue_completion, %w[Right], %w[Tab]
  key :submit,              %w[Return]
  key :cancel,              %w[Escape], %w[BackSpace]
end
