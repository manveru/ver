vim = VER::Keymap.new(name: :vim, mode: :control)

vim.in_mode :basic do
  key :file_open_popup,     %w[Control-o]
  key :file_open_fuzzy,     %w[Alt-o], %w[Control-m o]
  key :status_evaluate,     %w[Alt-x], %w[Control-m x]
  key :file_save,           %w[Control-s]
  key :file_save_popup,     %w[Control-Alt-s]
  key :quit,                %w[Control-q]
  key :start_control_mode,  %w[Escape], %w[Control-c]
  key :open_method_list,    %w[F10]
  key :open_terminal,       %w[F9]
  key :describe_key,        %w[Control-h k]
  key :help_for_help,       %w[Control-h question], %w[F1], %w[Help]
  key :tags_at,             %w[Control-g t]
  key :source_buffer,       %w[Control-R]

  key :open_grep_list,      %w[Control-Alt-g], %w[Control-m Control-g]
  key :grep_buffer,         %w[Alt-g], %w[Control-m g]
  key :grep_buffers,        %w[Alt-G], %w[Control-m G]

  key :buffer_switch,       %w[Alt-b], %w[Control-m b]
  key :window_switch,       %w[Alt-B], %w[Control-m B]
  key :open_console,        %w[Control-exclam] if defined?(::EM)
end

vim.in_mode :views do
  inherits :basic

  key :view_one,           %w[KeyPress-1]
  key :view_two,           %w[KeyPress-2]

  key :view_slave_inc,     %w[plus]
  key :view_slave_dec,     %w[minus]

  key :view_master_inc,    %w[H]
  key :view_master_dec,    %w[L]

  key :view_create,        %w[c]
  key :view_focus_next,    %w[j], %w[Right]
  key :view_focus_prev,    %w[k], %w[Left]
  key :view_push_down,     %w[J], %w[Down]
  key :view_push_up,       %w[K], %w[Up]
  key :view_close,         %w[w]
  key :view_push_top,      %w[Return]
  key :view_push_bottom,   %w[BackSpace]

  key :view_master_shrink, %w[h]
  key :view_master_grow,   %w[l]

  key :view_peer,          %w[p]
end

vim.in_mode :views_control do
  key [:view_change], ['Control-w', :views]
  key :view_focus_next, %w[Control-Key-Tab]
  key :view_focus_prev, %w[Control-Shift-Key-Tab], %w[Control-ISO_Left_Tab]

  key :start_views_mode, %w[Control-w r]
end

vim.in_mode :move do
  key :backward_char,       %w[h], %w[Left]
  key :backward_chunk,      %w[B]
  key :backward_word,       %w[b], %w[Shift-Left]
  key :beginning_of_line,   %w[KeyPress-0], %w[Home]
  key :end_of_file,         %w[G]
  key :end_of_line,         %w[dollar], %w[End]
  key :forward_char,        %w[l], %w[Right]
  key :forward_chunk,       %w[W]
  key :forward_word,        %w[w], %w[Shift-Right]
  key :go_line,             %w[g g]
  key :matching_brace,      %w[percent]
  key :next_line,           %w[j], %w[Down], %w[Control-n]
  key :next_newline_block,  %w[braceleft]
  key :page_down,           %w[Control-f], %w[Next]
  key :page_up,             %w[Control-b], %w[Prior]
  key :prev_newline_block,  %w[braceright]
  key :previous_line,       %w[k], %w[Up], %w[Control-p]
  key :word_right_end,      %w[e]
end

vim.in_mode :search do
  key :search_char_left,               %w[F]
  key :search_char_right,              %w[f]
  key :search_next,                    %w[n]
  key :search_next_word_under_cursor,  %w[asterisk]
  key :search_prev,                    %w[N]
  key :search_prev_word_under_cursor,  %w[numbersign]
  key :search_remove,                  %w[g slash]
  key :status_search_next,             %w[slash]
  key :status_search_prev,             %w[question]
end

vim.in_mode :ctags do
  key :ctags_find_current,  %w[Control-bracketright] # C-]
  key :ctags_prev,          %w[Control-bracketleft]  # C-[
end

vim.in_mode :bookmark do
  no_arguments

  key :char_bookmark_add,    %w[m]
  key :char_bookmark_visit,  %w[quoteleft]
  # vim also has quoteright to jump to the start of the line, but who
  # needs that *_*
end

vim.in_mode :complete do
  no_arguments

  key :complete_aspell,   %w[Control-x Control-a]
  key :complete_file,     %w[Control-x Control-f]
  key :complete_line,     %w[Control-x Control-l]
  key :complete_snippet,  %w[Control-x Control-s]
  key :complete_tm,       %w[Control-x Control-x]
  key :complete_word,     %w[Control-x Control-w]
  key :smart_tab,         %w[Tab]
end

vim.in_mode :control do
  inherits :basic, :move, :views_control, :search, :ctags, :bookmark

  key :change_line,                       %w[c c]
  key :change_motion,                     ['c', :move]

  key :chdir,                             %w[g c]

  key :copy_left_word,                    %w[y b]
  key :copy_line,                         %w[y y], %w[Y]
  key :copy_right_word,                   %w[y w]

  key :cursor_vertical_bottom,            %w[z b]
  key :cursor_vertical_bottom_sol,        %w[z minus]
  key :cursor_vertical_center,            %w[z z]
  key :cursor_vertical_center_sol,        %w[z period]
  key :cursor_vertical_top,               %w[z t]
  key :cursor_vertical_top_sol,           %w[z Return]

  key :eol_then_insert_mode,              %w[A]
  key :forward_char_then_insert_mode,     %w[a]

  key :indent_line,                       %w[greater]

  key :insert_indented_newline_above,     %w[O]
  key :insert_indented_newline_below,     %w[o]

  key :join_lines,                        %w[J]

  key :kill_line,                         %w[d d]
  key :kill_motion,                       ['d', :move]

  key :open_file_under_cursor,            %w[g f]
  key :paste,                             %w[p]
  key :paste_above,                       %w[P]
  key :preview,                           %w[F5]
  key :redo,                              %w[Control-r]
  key :repeat_command,                    %w[period]
  key :replace_char,                      %w[r]
  key :smart_evaluate,                    %w[Alt-e], %w[Control-m e]

  key :sol_then_insert_mode,              %w[I]
  key :start_insert_mode,                 %w[i]
  key :start_replace_mode,                %w[R]

  key :start_select_block_mode,           %w[Control-v]
  key :start_select_char_mode,            %w[v]
  key :start_select_line_mode,            %w[V]

  key :executor,                          %w[colon]
  key :syntax_indent_file,                %w[equal]
  key :syntax_switch,                     %w[Control-y]
  key :theme_switch,                      %w[Control-t]
  key :toggle_case,                       %w[asciitilde]
  key :undo,                              %w[u]
  key :unindent_line,                     %w[less]
  key :wrap_line,                         %w[g w]
  key [:change_motion, :end_of_line],     %w[C]
  key [:change_word_right_end],           %w[c w]
  key [:kill_motion, :backward_char],     %w[X]
  key [:kill_motion, :end_of_line],       %w[D]
  key [:kill_motion, :forward_char],      %w[x]
end

vim.in_mode :readline do
  no_arguments

  key :accept_line,                    %w[Return]
  key :backward_char,                  %w[Left], %w[Control-b]
  key :backward_word,                  %w[Shift-Left], %w[Alt-b]
  key :beginning_of_history,           %w[Control-less]
  key :beginning_of_line,              %w[Home], %w[Control-a]
  key :end_of_history,                 %w[Control-greater]
  key :end_of_line,                    %w[End], %w[Control-e]
  key :forward_char,                   %w[Right], %w[Control-f]
  key :forward_word,                   %w[Shift-Right], %w[Alt-f]
  key :insert_selection,               %w[Shift-Insert]
  key :insert_tab,                     %w[Control-v Tab]
  key :next_history,                   %w[Down], %w[Control-n]
  key :previous_history,               %w[Up], %w[Control-p]
  key :transpose_chars,                %w[Control-t]
  key [:kill_motion, :backward_char],  %w[BackSpace]
  key [:kill_motion, :backward_word],  %w[Control-w]
  key [:kill_motion, :forward_char],   %w[Delete], %w[Control-d]

  KEYSYMS.each do |sym, name|
    key [:insert_string, sym], [name]
  end
end

vim.in_mode :insert do
  inherits :basic, :views_control, :complete, :readline
  no_arguments

  key :insert_indented_newline,  %w[Return]
  key :next_line,                %w[Down], %w[Control-n]
  key :page_down,                %w[Control-f], %w[Next], %w[Shift-Down]
  key :page_up,                  %w[Control-b], %w[Prior], %w[Shift-Up]
  key :previous_line,            %w[Up], %w[Control-p]
  key :smart_evaluate,           %w[Alt-e], %w[Control-e]
  key :auto_fill_space,          %w[space]

  missing :insert_string
end

vim.in_mode :replace do
  inherits :insert
  no_arguments

  missing :replace_string
end

vim.in_mode :select do
  inherits :basic, :move, :search

  key :comment_selection,             %w[comma c]
  key :copy_selection,                %w[y], %w[Y]
  key :indent_selection,              %w[greater]
  key :kill_selection,                %w[d], %w[D], %w[x], %w[BackSpace], %w[Delete]
  key :pipe_selection,                %w[exclam]
  key :selection_lower_case,          %w[u]
  key :selection_replace_char,        %w[r]
  key :selection_replace_string,      %w[c]
  key :selection_toggle_case,         %w[asciitilde]
  key :selection_upper_case,          %w[U]
  key :smart_evaluate,                %w[Alt-e], %w[Control-e]
  key :switch_select_block_mode,      %w[Control-v]
  key :switch_select_char_mode,       %w[v]
  key :switch_select_line_mode,       %w[V]
  key :uncomment_selection,           %w[comma u]
  key :unindent_selection,            %w[less]
  key :wrap_selection,                %w[g w]
  key [:finish_selection, :control],  %w[Escape], %w[Control-c]
end

vim.in_mode :select_char do
  inherits :select
end

vim.in_mode :select_line do
  inherits :select
end

vim.in_mode :select_block do
  inherits :select
end

vim.in_mode :status_query do
  inherits :basic, :readline
  no_arguments

  key :ask_abort,         %w[Escape], %w[Control-c]
  key :ask_submit,        %w[Return]
  key :history_complete,  %w[Tab]
  key :history_next,      %w[Down], %w[Control-n]
  key :history_prev,      %w[Up], %w[Control-p]

  missing :insert_string
end

vim.in_mode :list_view_entry do
  inherits :basic, :readline
  no_arguments

  # key :update, %w[Key]
  key :cancel,          %w[Escape], %w[Control-c]
  key :completion,      %w[Tab]
  key :line_down,       %w[Down], %w[Control-j], %w[Control-n]
  key :line_up,         %w[Up], %w[Control-k], %w[Control-p]
  key :pick_selection,  %w[Return]

  missing :insert_string
end

vim.in_mode :executor_entry do
  inherits :basic, :readline
  no_arguments

  key :cancel,          %w[Escape], %w[Control-c]
  key :completion,      %w[Tab]
  key :line_down,       %w[Down], %w[Control-j], %w[Control-n]
  key :line_up,         %w[Up], %w[Control-k], %w[Control-p]
  key :pick_selection,  %w[Return]

  missing :insert_string
end

vim.in_mode :executor_label do
  inherits :executor_entry
  no_arguments

  key :speed_selection,  %w[space]

  missing :insert_string
end

vim.in_mode :list_view_list do
  inherits :basic

  key :cancel,          %w[Escape], %w[Control-c]
  key :pick_selection,  %w[Return], %w[Double-Button-1]
  key :line_up,         %w[Up], %w[Control-k], %w[Control-p]
  key :line_down,       %w[Down], %w[Control-j], %w[Control-n]
end

vim.in_mode :hover_completion do
  inherits :basic

  key :cancel,               %w[Escape], %w[BackSpace]
  key :continue_completion,  %w[Right], %w[l]
  key :go_down,              %w[Down], %w[j]
  key :go_up,                %w[Up], %w[k]
  key :submit,               %w[Return]
end

vim.in_mode :snippet do
  inherits :readline

  key :snippet_cancel, %w[Escape], %w[Control-c]
  key :snippet_jump,   %w[Tab]

  missing :snippet_insert_string
end

vim.ignore_sends = [
  :repeat_command,
  :start_control_mode,
  :start_insert_mode,
  :start_replace_mode,
  :start_select_block_mode,
  :start_select_char_mode,
  :start_select_line_mode,
]

vim.accumulate_sends = [
  :insert_string
]
