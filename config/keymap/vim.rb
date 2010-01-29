module VER
  minor_mode :help do
    handler Methods::Help

    map :describe_key, %w[Control-h k]
  end

  minor_mode :open do
    handler Methods::Open

    map :file_open_popup, %w[Control-o]
    map :file_open_fuzzy, %w[Alt-o], %w[Control-m o]
  end

  minor_mode :save do
    handler Methods::Save

    map :file_save,       %w[Control-s]
    map :file_save_popup, %w[Control-Alt-s]
  end

  minor_mode :preview do
    handler Methods::Preview

    map :preview, %w[F5]
  end

  minor_mode :basic do
    inherits :help, :preview, :save, :open

    handler Methods::Basic
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

  minor_mode :views do
    inherits :basic
    handler Methods::Views

    map :one,           %w[1]
    map :two,           %w[2]

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
    map :master_equal,  %w[equal]

    map :peer,          %w[p]
  end

  minor_mode :views_control do
    become :views, %w[Control-w r]

    handler Methods::Views
    map :change,     ['Control-w', :views]
    map :focus_next, %w[Control-Tab]
    map :focus_prev, %w[Control-Shift-Tab], %w[Control-ISO_Left_Tab]
    map :cycle_next, %w[Alt-Tab]
    map :cycle_prev, %w[Alt-Shift-Tab], %w[Alt-ISO_Left_Tab]
  end

  minor_mode :move do
    inherits :prefix

    handler Methods::Move
    map :prev_char,       %w[h], %w[Left]
    map :prev_chunk,      %w[B]
    map :prev_word,       %w[b], %w[Shift-Left]
    map :start_of_line,   %w[Home]
    map :prefix_arg_sol,  %w[0]
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

  minor_mode :prefix do
    map(:update_prefix_arg, *('0'..'9'))
  end

  minor_mode :search do
    handler Methods::Search

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

  minor_mode :ctags do
    handler Methods::CTags

    map :find_current,  %w[Control-bracketright] # C-]
    map :prev,          %w[Control-bracketleft]  # C-[
  end

  minor_mode :bookmark do
    handler Methods::Bookmark

    map :add_char,    %w[m]
    map :visit_char,  %w[quoteleft]
    # vim also has quoteright to jump to the start of the line, but who
    # needs that *_*
  end

  minor_mode :complete do
    handler Methods::Completion

    map :aspell,     %w[Control-x Control-a]
    map :contextual, %w[Control-x Control-x]
    map :file,       %w[Control-x Control-f]
    map :line,       %w[Control-x Control-l]
    map :snippet,    %w[Control-x Control-s]
    map :word,       %w[Control-x Control-w]
    map :smart_tab,  %w[Tab]
  end

  minor_mode :delete do
    handler Methods::Delete

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

  minor_mode :clipboard do
    handler Methods::Clipboard

    map :copy_line,        %w[y y], %w[Y]
    map :copy_motion,      ['y', :move]
    map :paste,            %w[p]
    map :paste_above,      %w[P]
  end

  minor_mode :undo do
    handler Methods::Undo

    map :redo, %w[Control-r]
    map :undo, %w[u]
  end

  minor_mode :control do
    inherits :basic, :move, :delete, :undo, :views_control, :search, :ctags,
             :bookmark, :clipboard

    become :select_block,   %w[Control-v]
    become :select_char,    %w[v]
    become :select_line,    %w[V]
    become :insert,         %w[i]
    become :replace,        %w[R]
    become :replace_char,   %w[r]

    handler Methods::Control
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
    map :unindent_line,                     %w[less]

    map :join_lines,                        %w[J]

    map :open_file_under_cursor,            %w[g f]

    map :repeat_command,                    %w[period]
    map :smart_evaluate,                    %w[Alt-e], %w[Control-m e]

    map [:insert_at, :home_of_line],        %w[I]

    map :executor,                          %w[colon]
    map :syntax_switch,                     %w[Control-y]
    map :theme_switch,                      %w[Control-t]
    map :toggle_case,                       %w[asciitilde]

    map :wrap_line,                         %w[g w]

    handler Methods::Insert
    map :newline_above,     %w[O]
    map :newline_below,     %w[o]
  end

  minor_mode :readline do
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

    missing :insert_string
  end

  minor_mode :insert do
    inherits :basic, :views_control, :complete
    become :control, %w[Escape], %w[Control-c]

    handler Methods::AutoFill
    map :auto_fill_space,          %w[space]

    handler Methods::Delete
    map [:kill_motion, :next_char],  %w[Delete], %w[Control-d]
    map [:kill_motion, :prev_char],  %w[BackSpace]
    map [:kill_motion, :prev_word],  %w[Control-w]

    handler Methods::Move
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

    handler Methods::Control
    map :smart_evaluate,           %w[Alt-e], %w[Control-e]


    handler Methods::Insert
    map :newline,    %w[Return]
    map :selection,  %w[Shift-Insert]
    map :tab,        %w[Control-v Tab], %w[Control-i]
    missing :string
  end

  minor_mode :replace do
    become :control, %w[Escape], %w[Control-c]

    handler Methods::Insert
    map [:replace_string, "\n"], %w[Return]
    missing :replace_string
  end

  minor_mode :replace_char do
    become :control, %w[Escape], %w[Control-c]

    handler Methods::Insert
    map [:replace_char, "\n"], %w[Return]
    missing :replace_char
  end

  minor_mode :select do
    inherits :basic, :move, :search

    handler Methods::Selection
    map :comment,         %w[comma c]
    map :copy,            %w[y], %w[Y]
    map :indent,          %w[greater]
    map :kill,            %w[d], %w[D], %w[x], %w[BackSpace], %w[Delete]
    map :pipe,            %w[exclam]
    map :lower_case,      %w[u]
    map :replace_string,  %w[c]
    map :toggle_case,     %w[asciitilde]
    map :upper_case,      %w[U]
    map :uncomment,       %w[comma u]
    map :unindent,        %w[less]
    map :wrap,            %w[g w]

    handler Methods::Control
    map :smart_evaluate,  %w[Alt-e], %w[Control-e]
  end

  minor_mode :select_char do
    inherits :select

    become :control,      %w[Escape], %w[Control-c]
    become :select_line,  %w[V]
    become :select_block, %w[Control-v]
    become :select_replace_char, %w[r]

    handler Methods::Selection
    enter :enter
    leave :leave
  end

  minor_mode :select_line do
    inherits :select

    become :control,      %w[Escape], %w[Control-c]
    become :select_char,  %w[v]
    become :select_block, %w[Control-v]
    become :select_replace_char, %w[r]

    handler Methods::Selection
    enter :enter
    leave :leave
  end

  minor_mode :select_block do
    inherits :select

    become :control,     %w[Escape], %w[Control-c]
    become :select_char, %w[v]
    become :select_line, %w[V]
    become :select_replace_char, %w[r]

    handler Methods::Selection
    enter :enter
    leave :leave
  end

  minor_mode :select_replace_char do
    become :control, %w[Escape], %w[Control-c]

    handler Methods::Selection
    map [:replace_char, "\n"], %w[Return]
    missing :replace_char
  end

  minor_mode :status_query do
    inherits :basic, :readline

    map :ask_abort,         %w[Escape], %w[Control-c]
    map :ask_submit,        %w[Return]

    missing :insert_string
  end

  minor_mode :list_view_entry do
    inherits :basic, :readline

    map :cancel,          %w[Escape], %w[Control-c]
    map :completion,      %w[Tab]
    map :line_down,       %w[Down], %w[Control-j], %w[Control-n]
    map :line_up,         %w[Up], %w[Control-k], %w[Control-p]
    map :pick_selection,  %w[Return]

    missing :insert_string
  end

  minor_mode :list_view_list do
    inherits :basic

    map :cancel,          %w[Escape], %w[Control-c]
    map :pick_selection,  %w[Return], %w[Double-Button-1]
    map :line_up,         %w[Up], %w[Control-k], %w[Control-p]
    map :line_down,       %w[Down], %w[Control-j], %w[Control-n]
  end

  major_mode :HoverCompletion do
    inherits :basic

    map :cancel,               %w[Escape], %w[BackSpace]
    map :continue_completion,  %w[Right], %w[l]
    map :go_down,              %w[Down], %w[j]
    map :go_up,                %w[Up], %w[k]
    map :submit,               %w[Return]
  end

  minor_mode :snippet do
    inherits :readline

    handler Methods::Snippet
    map :cancel, %w[Escape], %w[Control-c]
    map :jump,   %w[Tab]

    missing :insert_string
  end

  major_mode :Fundamental do
    use :control
  end

  major_mode :Status do
    map :ask_abort,         %w[Escape], %w[Control-c]
    map :ask_submit,        %w[Return]

    map :end_of_line,       %w[End], %w[Control-e]
    map :insert_selection,  %w[Shift-Insert]
    map :insert_tab,        %w[Control-v Tab]
    map :next_char,         %w[Right], %w[Control-f]
    map :next_word,         %w[Shift-Right], %w[Alt-f]
    map :prev_char,         %w[Left], %w[Control-b]
    map :prev_word,         %w[Shift-Left], %w[Alt-b]
    map :start_of_line,     %w[Home], %w[Control-a]
    map :transpose_chars,   %w[Control-t]

    map :kill_next_char,    %w[Delete], %w[Control-d]
    map :kill_prev_char,    %w[BackSpace]
    map :kill_prev_word,    %w[Control-w]

    missing :insert_string
  end

  major_mode :Executor do
    use :executor_label
  end

  minor_mode :executor_entry do
    map :cancel,            %w[Escape], %w[Control-c]
    map :completion,        %w[Tab]
    map :end_of_line,       %w[Control-e], %w[End]
    map :insert_selection,  %w[Shift-Insert]
    map :insert_tab,        %w[Control-i]
    map :kill_next_char,    %w[Control-d], %w[Delete]
    map :kill_prev_char,    %w[BackSpace]
    map :kill_prev_word,    %w[Control-w]
    map :kill_next_word,    %w[Alt-d]
    map :kill_end_of_line,  %w[Control-k]
    map :line_down,         %w[Down], %w[Control-j], %w[Control-n]
    map :line_up,           %w[Up], %w[Control-k], %w[Control-p]
    map :next_char,         %w[Control-f], %w[Right]
    map :next_word,         %w[Shift-Right], %w[Alt-f]
    map :pick_selection,    %w[Return]
    map :prev_char,         %w[Control-b], %w[Left]
    map :prev_word,         %w[Shift-Left], %w[Alt-b]
    map :quit,              %w[Control-q]
    map :start_of_line,     %w[Control-a], %w[Home]
    map :transpose_chars,   %w[Control-t]

    missing :insert_string
  end

  minor_mode :executor_label do
    inherits :executor_entry

    map :speed_selection,  %w[space]

    missing :insert_string
  end
end
