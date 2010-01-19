vim = VER::Keymap.define(name: :vim, mode: :control)

vim.in_mode :help do
  no_arguments
  handler VER::Methods::Help

  map :describe_key, %w[Control-h k]
  # map :help_for_help,       %w[Control-h question], %w[F1], %w[Help]
end

vim.in_mode :open do
  no_arguments
  handler VER::Methods::Open

  map :file_open_popup,     %w[Control-o]
  map :file_open_fuzzy,     %w[Alt-o], %w[Control-m o]
end

vim.in_mode :save do
  no_arguments
  handler VER::Methods::Save

  map :file_save,           %w[Control-s]
  map :file_save_popup,     %w[Control-Alt-s]
end

vim.in_mode :preview do
  no_arguments
  handler VER::Methods::Preview

  map :preview, %w[F5]
end

vim.in_mode :basic do
  inherits :help, :preview, :save, :open
  handler VER::Methods::Basic

  mode :control,            %w[Escape], %w[Control-c]

  map :quit,                %w[Control-q]
  map :source_buffer,       %w[Control-R]
  map :status_evaluate,     %w[Alt-x], %w[Control-m x]
  map :tags_at,             %w[Control-g t]

  map :open_terminal,       %w[F9]
  map :open_console,        %w[Control-exclam] if defined?(::EM)

  # to be deprecated
  map :open_buffer_switch,  %w[Alt-b], %w[Control-m b]
  map :open_grep_buffer,    %w[Alt-g], %w[Control-m g]
  map :open_grep_buffers,   %w[Alt-G], %w[Control-m G]
  map :open_grep_list,      %w[Control-Alt-g], %w[Control-m Control-g]
  map :open_method_list,    %w[F10]
  map :open_window_switch,  %w[Alt-B], %w[Control-m B]
end

vim.in_mode :views do
  inherits :basic
  no_arguments
  handler VER::Methods::Views
  # handler VER::Methods::Views

  map :one,           %w[KeyPress-1]
  map :two,           %w[KeyPress-2]

  map :slave_inc,     %w[plus]
  map :slave_dec,     %w[minus]

  map :master_inc,    %w[H]
  map :master_dec,    %w[L]

  map :create,        %w[c]
  map :focus_next,    %w[j], %w[Right]
  map :focus_prev,    %w[k], %w[Left]
  map :push_down,     %w[J], %w[Down]
  map :push_up,       %w[K], %w[Up]
  map :close,         %w[w]
  map :push_top,      %w[Return]
  map :push_bottom,   %w[BackSpace]

  map :master_shrink, %w[h]
  map :master_grow,   %w[l]

  map :peer,          %w[p]
end

vim.in_mode :views_control do
  no_arguments
  handler VER::Methods::Views
  mode :views, %w[Control-w r]

  map :change,     ['Control-w', :views]
  map :focus_next, %w[Control-Tab]
  map :focus_prev, %w[Control-Shift-Tab], %w[Control-ISO_Left_Tab]
  map :cycle_next, %w[Alt-Tab]
  map :cycle_prev, %w[Alt-Shift-Tab], %w[Alt-ISO_Left_Tab]
end

vim.in_mode :move do
  handler VER::Methods::Move

  map :prev_char,       %w[h], %w[Left]
  map :prev_chunk,      %w[B]
  map :prev_word,       %w[b], %w[Shift-Left]
  map :start_of_line,   %w[KeyPress-0], %w[Home]
  map :end_of_file,     %w[G]
  map :end_of_line,     %w[dollar], %w[End]
  map :next_char,       %w[l], %w[Right]
  map :next_chunk,      %w[W]
  map :next_word,       %w[w], %w[Shift-Right]
  map :go_line,         %w[g g]
  map :matching_brace,  %w[percent]
  map :next_line,       %w[j], %w[Down], %w[Control-n]
  map :next_page,       %w[Control-f], %w[Next]
  map :prev_page,       %w[Control-b], %w[Prior]
  map :prev_line,       %w[k], %w[Up], %w[Control-p]
  map :next_word_end,   %w[e]
end

vim.in_mode :search do
  handler VER::Methods::Search

  map :search_char_left,               %w[F]
  map :search_char_right,              %w[f]
  map :search_next,                    %w[n]
  map :search_next_word_under_cursor,  %w[asterisk]
  map :search_prev,                    %w[N]
  map :search_prev_word_under_cursor,  %w[numbersign]
  map :search_remove,                  %w[g slash]
  map :status_search_next,             %w[slash]
  map :status_search_prev,             %w[question]
end

vim.in_mode :ctags do
  handler VER::Methods::CTags

  map :find_current,  %w[Control-bracketright] # C-]
  map :prev,          %w[Control-bracketleft]  # C-[
end

vim.in_mode :bookmark do
  no_arguments
  handler VER::Methods::Bookmark

  map :add_char,    %w[m]
  map :visit_char,  %w[quoteleft]
  # vim also has quoteright to jump to the start of the line, but who
  # needs that *_*
end

vim.in_mode :complete do
  no_arguments
  handler VER::Methods::Completion

  map :aspell,     %w[Control-x Control-a]
  map :contextual, %w[Control-x Control-x]
  map :file,       %w[Control-x Control-f]
  map :line,       %w[Control-x Control-l]
  map :snippet,    %w[Control-x Control-s]
  map :word,       %w[Control-x Control-w]
  map :smart_tab,  %w[Tab]
end

vim.in_mode :delete do
  handler VER::Methods::Delete

  map :change_line,                    %w[c c]
  map :kill_line,                      %w[d d]
  map :kill_motion,                    ['d', :move]
  map :change_motion,                  ['c', :move]
  map [:change_motion, :end_of_line],  %w[C]
  map [:change_word_right_end],        %w[c w]
  map [:kill_motion, :prev_char],  %w[X]
  map [:kill_motion, :end_of_line],    %w[D]
  map [:kill_motion, :next_char],   %w[x]
end

vim.in_mode :clipboard do
  handler VER::Methods::Clipboard

  map :copy_line,        %w[y y], %w[Y]
  map :copy_motion,      ['y', :move]
  map :paste,            %w[p]
  map :paste_above,      %w[P]
end

vim.in_mode :undo do
  handler VER::Methods::Undo

  map :redo, %w[Control-r]
  map :undo, %w[u]
end

vim.in_mode :control do
  inherits :basic, :move, :delete, :undo, :views_control, :search, :ctags,
           :bookmark, :clipboard
  handler VER::Methods::Control

  mode :select_block,   %w[Control-v]
  mode :select_char,    %w[v]
  mode :select_line,    %w[V]
  mode :insert,         %w[i]
  mode :replace,        %w[R]

  map :chdir,                             %w[g c]

  map :cursor_vertical_bottom,            %w[z b]
  map :cursor_vertical_bottom_sol,        %w[z minus]
  map :cursor_vertical_center,            %w[z z]
  map :cursor_vertical_center_sol,        %w[z period]
  map :cursor_vertical_top,               %w[z t]
  map :cursor_vertical_top_sol,           %w[z Return]

  map [:insert_at, :end_of_line],         %w[A]
  map [:insert_at, :next_char],           %w[a]

  map :indent_line,                       %w[greater]

  map :insert_indented_newline_above,     %w[O]
  map :insert_indented_newline_below,     %w[o]

  map :join_lines,                        %w[J]

  map :open_file_under_cursor,            %w[g f]

  map :repeat_command,                    %w[period]
  map :replace_char,                      %w[r]
  map :smart_evaluate,                    %w[Alt-e], %w[Control-m e]

  map [:insert_at, :home_of_line],        %w[I]

  map :executor,                          %w[colon]
  map :syntax_switch,                     %w[Control-y]
  map :theme_switch,                      %w[Control-t]
  map :toggle_case,                       %w[asciitilde]

  map :unindent_line,                     %w[less]
  map :wrap_line,                         %w[g w]
end

vim.in_mode :readline do
  no_arguments

  map :accept_line,                %w[Return]

  map :end_of_line,                %w[End], %w[Control-e]
  map :insert_selection,           %w[Shift-Insert]
  map :insert_tab,                 %w[Control-v Tab]
  map :next_char,                  %w[Right], %w[Control-f]
  map :next_word,                  %w[Shift-Right], %w[Alt-f]
  map :prev_char,                  %w[Left], %w[Control-b]
  map :prev_word,                  %w[Shift-Left], %w[Alt-b]
  map :start_of_line,              %w[Home], %w[Control-a]
  map :transpose_chars,            %w[Control-t]

  map [:kill_motion, :next_char],  %w[Delete], %w[Control-d]
  map [:kill_motion, :prev_char],  %w[BackSpace]
  map [:kill_motion, :prev_word],  %w[Control-w]

  # map :beginning_of_history,       %w[Control-less]
  # map :end_of_history,             %w[Control-greater]
  # map :next_history,               %w[Down], %w[Control-n]
  # map :prev_history,               %w[Up], %w[Control-p]

  KEYSYMS.each do |sym, name|
    map [:insert_string, sym], [name]
  end
end

vim.in_mode :insert do
  inherits :basic, :views_control, :complete
  no_arguments

  handler VER::Methods::Insert
  map :insert_indented_newline,  %w[Return]
  map :insert_selection,           %w[Shift-Insert]
  map :insert_tab,                 %w[Control-v Tab]
  KEYSYMS.each{|sym, name| map [:insert_string, sym], [name] }
  missing :insert_string

  handler VER::Methods::Delete
  map [:kill_motion, :next_char],  %w[Delete], %w[Control-d]
  map [:kill_motion, :prev_char],  %w[BackSpace]
  map [:kill_motion, :prev_word],  %w[Control-w]

  handler VER::Methods::Move
  map :next_line,      %w[Down], %w[Control-n]
  map :next_page,      %w[Control-f], %w[Next], %w[Shift-Down]
  map :prev_page,      %w[Control-b], %w[Prior], %w[Shift-Up]
  map :prev_line,      %w[Up], %w[Control-p]
  map :end_of_line,    %w[End], %w[Control-e]
  map :next_char,      %w[Right], %w[Control-f]
  map :next_word,      %w[Shift-Right], %w[Alt-f]
  map :prev_char,      %w[Left], %w[Control-b]
  map :prev_word,      %w[Shift-Left], %w[Alt-b]
  map :start_of_line,  %w[Home], %w[Control-a]

  handler VER::Methods::Control
  map :smart_evaluate,           %w[Alt-e], %w[Control-e]

  handler VER::Methods::AutoFill
  map :auto_fill_space,          %w[space]
end

vim.in_mode :replace do
  inherits :insert
  no_arguments
  handler VER::Methods::Insert

  missing :replace_string
end

vim.in_mode :select do
  inherits :basic, :move, :search
  handler VER::Methods::Selection

  mode :select_block,  %w[Control-v]
  mode :select_char,   %w[v]
  mode :select_line,   %w[V]
  mode :control,       %w[Escape], %w[Control-c]

  map :comment,         %w[comma c]
  map :copy,            %w[y], %w[Y]
  map :indent,          %w[greater]
  map :kill,            %w[d], %w[D], %w[x], %w[BackSpace], %w[Delete]
  map :pipe,            %w[exclam]
  map :lower_case,      %w[u]
  map :replace_char,    %w[r]
  map :replace_string,  %w[c]
  map :toggle_case,     %w[asciitilde]
  map :upper_case,      %w[U]
  map :uncomment,       %w[comma u]
  map :unindent,        %w[less]
  map :wrap,            %w[g w]

  handler VER::Methods::Control
  map :smart_evaluate,  %w[Alt-e], %w[Control-e]
end

vim.in_mode :select_char do
  inherits :select
  enter_mode{|event| VER::Methods::Selection.enter(event) }
  leave_mode{|event| VER::Methods::Selection.leave(event) }
end

vim.in_mode :select_line do
  inherits :select
  enter_mode{|event| VER::Methods::Selection.enter(event) }
  leave_mode{|event| VER::Methods::Selection.leave(event) }
end

vim.in_mode :select_block do
  inherits :select
  enter_mode{|event| VER::Methods::Selection.enter(event) }
  leave_mode{|event| VER::Methods::Selection.leave(event) }
end

vim.in_mode :status_query do
  inherits :basic, :readline
  no_arguments

  map :ask_abort,         %w[Escape], %w[Control-c]
  map :ask_submit,        %w[Return]

  # map :history_complete,  %w[Tab]
  # map :history_next,      %w[Down], %w[Control-n]
  # map :history_prev,      %w[Up], %w[Control-p]

  missing :insert_string
end

vim.in_mode :list_view_entry do
  inherits :basic, :readline
  no_arguments

  # map :update, %w[Key]
  map :cancel,          %w[Escape], %w[Control-c]
  map :completion,      %w[Tab]
  map :line_down,       %w[Down], %w[Control-j], %w[Control-n]
  map :line_up,         %w[Up], %w[Control-k], %w[Control-p]
  map :pick_selection,  %w[Return]

  missing :insert_string
end

vim.in_mode :executor_entry do
  inherits :basic, :readline
  no_arguments

  map :cancel,          %w[Escape], %w[Control-c]
  map :completion,      %w[Tab]
  map :line_down,       %w[Down], %w[Control-j], %w[Control-n]
  map :line_up,         %w[Up], %w[Control-k], %w[Control-p]
  map :pick_selection,  %w[Return]

  missing :insert_string
end

vim.in_mode :executor_label do
  inherits :executor_entry
  no_arguments

  map :speed_selection,  %w[space]

  missing :insert_string
end

vim.in_mode :list_view_list do
  inherits :basic

  map :cancel,          %w[Escape], %w[Control-c]
  map :pick_selection,  %w[Return], %w[Double-Button-1]
  map :line_up,         %w[Up], %w[Control-k], %w[Control-p]
  map :line_down,       %w[Down], %w[Control-j], %w[Control-n]
end

vim.in_mode :hover_completion do
  inherits :basic

  map :cancel,               %w[Escape], %w[BackSpace]
  map :continue_completion,  %w[Right], %w[l]
  map :go_down,              %w[Down], %w[j]
  map :go_up,                %w[Up], %w[k]
  map :submit,               %w[Return]
end

vim.in_mode :snippet do
  inherits :readline

  handler VER::Methods::Snippet
  map :cancel, %w[Escape], %w[Control-c]
  map :jump,   %w[Tab]

  missing :insert_string
end

vim.ignore_sends = [
  :repeat_command,
]

vim.accumulate_sends = [
  :insert_string
]
