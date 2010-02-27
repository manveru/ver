module VER
  minor_mode :help do
    handler Methods::Help

    map :describe_key, %w[Control-h k]
  end

  minor_mode :open do
    handler Methods::Open
    map :file_open_popup, %w[Control-o]
    map :file_open_ask,   %w[colon o space]

    handler Methods::Control
    map [:ex, :fuzzy], %w[Alt-o], %w[Control-m o]
  end

  minor_mode :save do
    handler Methods::Save
    map :save,     %w[Control-s], %w[colon w Return]
    map :save_as,  %w[Control-S], %w[colon w space]
    map :save_all, %w[colon w a]
    map :quit,     %w[colon q a], %w[Z Z]
  end

  minor_mode :preview do
    map :eval_buffer,  %w[Control-R]
    map :tags_tooltip, %w[Control-g t]

    handler Methods::Preview
    map :preview, %w[F5]
  end

  minor_mode :basic do
    inherits :help, :preview, :save, :open

    handler Methods::Basic
    map :minibuf_eval,    %w[Alt-x], %w[Control-m x]
    map :open_terminal,   %w[F9]
    map :open_console,    %w[Control-exclam] if defined?(::EM)
  end

  minor_mode :vim_layout do
    handler :window
    map :split_horizontal, %w[Control-w s], %w[Control-w Control-s], %w[colon s h]
    map :split_vertical,   %w[Control-w v], %w[Control-w Control-v], %w[colon s v]
    map :new_horizontal,   %w[Control-w n], %w[Control-w Control-n], %w[colon n]
    map :quit,             %w[Control-w q], %w[Control-w Control-q], %w[colon q Return]
    map :quit!,            %w[colon q exclam]
    map :close,            %w[Control-w c], %w[colon c l o Return]
    map :close!,           %w[colon c l o exclam]
    map :only,             %w[Control-w o], %w[Control-w Control-o], %w[colon o n Return]
    map :go_below, %w[Control-w Down], %w[Control-w Control-j], %w[Control-w j]
    map :go_above, %w[Control-w Up], %w[Control-w Control-k], %w[Control-w k]
    map :go_left,  %w[Control-w Left], %w[Control-w BackSpace], %w[Control-w Control-h], %w[Control-w h]
    map :go_right, %w[Control-w Right], %w[Control-w Control-l], %w[Control-w l]
  end

  minor_mode :layout do
    inherits :basic
    handler Methods::Layout

    map :hide,          %w[0]
    map :one,           %w[1]
    map :two,           %w[2]

    map :slave_inc,     %w[plus]
    map :slave_dec,     %w[minus]

    map :master_inc,    %w[less]
    map :master_dec,    %w[greater]

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

  minor_mode :layout_control do
    become :layout, %w[Control-w r]

    handler Methods::Layout
    map :change,     ['Control-w', :layout]
    map :focus_next, %w[Control-Tab]
    map :focus_prev, %w[Control-Shift-Tab], %w[Control-ISO_Left_Tab]
    map :cycle_next, %w[Alt-Tab], %w[colon b n]
    map :cycle_prev, %w[Alt-Shift-Tab], %w[Alt-ISO_Left_Tab], %w[colon b p]
    map :close,      %w[colon q Return], %w[colon x]
  end

  minor_mode :move do
    inherits :prefix

    (0..9).each{|n| map :ask_go_line, ['colon', n.to_s] }

    handler Methods::Move
    map :prefix_arg_sol,  %w[0]

    handler :at_insert
    map :end_of_buffer,   %w[G]
    map :end_of_line,     %w[dollar], %w[End]
    map :go_line,         %w[g g]
    map :matching_brace,  %w[percent]
    map :next_char,       %w[l], %w[Right]
    map :next_chunk,      %w[W]
    map :next_chunk_end,  %w[E]
    map :next_line,       %w[j], %w[Down], %w[Control-n]
    map :next_page,       %w[Control-f], %w[Next]
    map :next_word,       %w[w], %w[Shift-Right]
    map :next_word_end,   %w[e]
    map :prev_char,       %w[h], %w[Left]
    map :prev_chunk,      %w[B]
    map :prev_line,       %w[k], %w[Up], %w[Control-p]
    map :prev_page,       %w[Control-b], %w[Prior]
    map :prev_word,       %w[b], %w[Shift-Left]
    map :start_of_line,   %w[Home]
  end

  minor_mode :prefix do
    map(:update_prefix_arg, *('0'..'9'))
  end

  minor_mode :search do
    handler Methods::Search

    map :char_left,               %w[F]
    map :char_right,              %w[f]
    map :next,                    %w[n]
    map :next_word_under_cursor,  %w[asterisk]
    map :prev,                    %w[N]
    map :prev_word_under_cursor,  %w[numbersign]
    map :remove,                  %w[g slash]
    map :status_next,             %w[slash]
    map :status_prev,             %w[question]
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
    handler :at_insert
    map :changing,                  ['c', :move]
    map :change_next_word_end,      %w[c w]
    map :change_line,               %w[c c]
    map :killing,                   ['d', :move]
    map :kill_line,                 %w[d d]
    map [:changing, :end_of_line],  %w[C]
    map [:killing,  :end_of_line],  %w[D]
    map [:killing,  :next_char],    %w[x]
    map [:killing,  :prev_char],    %w[X]
  end

  minor_mode :clipboard do
    handler :at_insert
    map :copy_line,  %w[y y], %w[Y]
    map :copying,    ['y', :move]

    handler Methods::Clipboard
    map :paste,            %w[p]
    map :paste_above,      %w[P]
  end

  minor_mode :undo do
    handler Methods::Undo

    map :redo, %w[Control-r]
    map :undo, %w[u]
  end

  minor_mode :control do
    inherits :basic, :move, :delete, :undo, :layout_control, :search, :ctags,
             :bookmark, :clipboard

    become :select_block,   %w[Control-v]
    become :select_char,    %w[v]
    become :select_line,    %w[V]
    become :insert,         %w[i], %w[Insert]
    become :replace,        %w[R]
    become :replace_char,   %w[r]

    handler :at_insert
    map :insert_newline_above, %w[O]
    map :insert_newline_below, %w[o]

    handler Methods::Control
    enter :enter
    leave :leave
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

    map :join_line_forward,                 %w[J]

    map :open_file_under_cursor,            %w[g f]

    map :repeat_command,                    %w[period]
    map :smart_evaluate,                    %w[Alt-e], %w[Control-m e]

    map [:insert_at, :home_of_line],        %w[I]

    map :executor, %w[colon colon]
    map [:ex, :buffer],       %w[colon b u], %w[Alt-b], %w[Control-m b]
    map [:ex, :edit],         %w[colon e space]
    map [:ex, :fuzzy],        %w[colon f]
    map [:ex, :grep],         %w[colon g]
    map [:ex, :grep_buffers], %w[colon G]
    map [:ex, :locate],       %w[colon l]
    map [:ex, :method],       %w[colon m]
    map [:ex, :open],         %w[colon o Return]
    map [:ex, :syntax],       %w[colon s]
    map [:ex, :theme],        %w[colon t]
    # map [:ex, :write],        %w[colon w]

    map :toggle_case, %w[asciitilde]
    map :wrap_line, %w[g w]

    handler Methods::SearchAndReplace
    map :query, %w[Alt-percent]
  end

  minor_mode :readline do
    map :accept_line,       %w[Return]

    map :end_of_line,       %w[End], %w[Control-e]
    map :insert_selection,  %w[Shift-Insert]
    map :insert_tab,        %w[Control-v Tab], %w[Control-i]
    map :kill_end_of_line,  %w[Control-k]
    map :kill_next_char,    %w[Control-d], %w[Delete]
    map :kill_next_word,    %w[Alt-d]
    map :kill_prev_char,    %w[BackSpace]
    map :kill_prev_word,    %w[Control-w]
    map :next_char,         %w[Right], %w[Control-f]
    map :next_word,         %w[Shift-Right], %w[Alt-f]
    map :prev_char,         %w[Left], %w[Control-b]
    map :prev_word,         %w[Shift-Left], %w[Alt-b]
    map :start_of_line,     %w[Home], %w[Control-a]
    map :transpose_chars,   %w[Control-t]

    map :sel_prev_char,     %w[Shift-Left]
    map :sel_next_char,     %w[Shift-Right]
    map :sel_prev_word,     %w[Shift-Control-Left]
    map :sel_next_word,     %w[Shift-Control-Right]
    map :sel_start_of_line, %w[Shift-Home]
    map :sel_end_of_line,   %w[Shift-End]

    missing :insert_string
  end

  minor_mode :insert do
    inherits :basic, :layout_control, :complete
    become :control, %w[Escape], %w[Control-c]

    handler Methods::AutoFill
    map :auto_fill_space,          %w[space]

    handler :at_insert
    map :end_of_line,            %w[End], %w[Control-e]
    map :insert_newline,         %w[Return]
    map :insert_selection,       %w[Shift-Insert], %w[Insert]
    map :insert_tab,             %w[Control-v Tab], %w[Control-i]
    map :next_char,              %w[Right], %w[Control-f]
    map :next_line,              %w[Down], %w[Control-n]
    map :next_page,              %w[Control-f], %w[Next], %w[Shift-Down]
    map :next_word,              %w[Shift-Right], %w[Alt-f]
    map :prev_char,              %w[Left], %w[Control-b]
    map :prev_line,              %w[Up], %w[Control-p]
    map :prev_page,              %w[Control-b], %w[Prior], %w[Shift-Up]
    map :prev_word,              %w[Shift-Left], %w[Alt-b]
    map :start_of_line,          %w[Home], %w[Control-a]
    map [:killing, :next_char],  %w[Delete], %w[Control-d]
    map [:killing, :prev_char],  %w[BackSpace]
    map [:killing, :prev_word],  %w[Control-w]

    handler Methods::Control
    map :smart_evaluate,           %w[Alt-e], %w[Control-e]
    map :unindent_line,            %w[ISO_Left_Tab]

    handler Methods::Insert
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

  minor_mode :search_and_replace do
    become :control, %w[Escape], %w[Control-c], %w[q]

    handler Methods::SearchAndReplace
    enter :enter
    leave :leave

    map :replace_all,  %w[a], %w[exclam]
    map :replace_once, %w[y]
    map :next,         %w[n], %w[s], %w[j], %w[Control-n]
    map :prev,         %w[k], %w[Control-p]
  end

  minor_mode :select do
    inherits :basic, :move, :search

    handler :at_sel
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

    handler Methods::Control
    map :smart_evaluate,  %w[Alt-e], %w[Control-e]
  end

  minor_mode :select_char do
    inherits :select

    become :control,             %w[Escape], %w[Control-c]
    become :select_line,         %w[V]
    become :select_block,        %w[Control-v]
    become :select_replace_char, %w[r]

    handler :at_sel
    enter :enter
    leave :leave
    map :wrap, %w[g w]
  end

  minor_mode :select_line do
    inherits :select

    become :control,             %w[Escape], %w[Control-c]
    become :select_char,         %w[v]
    become :select_block,        %w[Control-v]
    become :select_replace_char, %w[r]

    handler :at_sel
    enter :enter
    leave :leave
    map :wrap, %w[g w]
  end

  minor_mode :select_block do
    inherits :select

    become :control,             %w[Escape], %w[Control-c]
    become :select_char,         %w[v]
    become :select_line,         %w[V]
    become :select_replace_char, %w[r]

    handler :at_sel
    enter :enter
    leave :leave
  end

  minor_mode :select_replace_char do
    become :control, %w[Escape], %w[Control-c]

    handler :at_sel
    map [:replace_char, "\n"], %w[Return]
    missing :replace_char
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

  major_mode :MiniBuffer do
    use :readline

    map :abort,           %w[Escape], %w[Control-c]
    map :attempt,         %w[Return]
    map :complete_large,  %w[Double-Tab]
    map :complete_small,  %w[Tab]
    map :next_history,    %w[Down]
    map :prev_history,    %w[Up]
  end

  major_mode :Completions do
    handler MiniBuffer
    map :answer_from, %w[Button-1]
  end

  major_mode :Executor do
    use :executor_label
  end

  minor_mode :executor_entry do
    inherits :readline

    map :completion, %w[Tab]
    map :cancel,     %w[Escape]
    map :next_line,  %w[Down], %w[Control-j], %w[Control-n]
    map :prev_line,  %w[Up], %w[Control-k], %w[Control-p]
  end

  minor_mode :executor_label do
    inherits :executor_entry

    map :speed_selection,  %w[space]

    missing :insert_string
  end
end
