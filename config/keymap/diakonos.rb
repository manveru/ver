module VER
  PanedLayout::OPTIONS[:slaves] = 0

  major_mode :Fundamental do
    use :control
  end

  major_mode :Status do
    use :basic, :readline

    map :ask_abort,  %w[Escape], %w[Control-c]
    map :ask_submit, %w[Return]
  end

  major_mode :HoverCompletion do
    use :basic

    map :cancel,              %w[Escape], %w[BackSpace]
    map :continue_completion, %w[Right], %w[Tab]
    map :go_down,             %w[Down], %w[Control-p]
    map :go_up,               %w[Up], %w[Control-n]
    map :submit,              %w[Return]
  end

  minor_mode :basic do
    handler Methods::Basic
    map :quit, %w[Control-q]
  end

  minor_mode :move do
    handler Methods::Move
    map :ask_go_line,     %w[Control-g]
    map :end_of_line,     %w[End], %w[Control-e]
    map :end_of_text,     %w[Alt-greater]
    map :next_char,       %w[Right], %w[Control-f]
    map :next_line,       %w[Down], %w[Control-n]
    map :next_page,       %w[Next]
    map :next_word,       %w[Shift-Right], %w[Alt-f]
    map :prev_char,       %w[Left], %w[Control-b]
    map :prev_line,       %w[Up], %w[Control-p]
    map :prev_page,       %w[Prior]
    map :prev_word,       %w[Shift-Left], %w[Alt-b]
    map :start_of_line,   %w[Home], %w[Control-a]
    map :start_of_text,   %w[Alt-less]
    map :forward_scroll,  %w[Alt-n]
    map :backward_scroll, %w[Alt-p]
  end

  minor_mode :control do
    inherits :basic, :move

    become :select_char, %w[Control-space]
    become :select_line, %w[Escape Control-space], %w[Control-Alt-space]

    handler Methods::Save
    map :save,    %w[Control-s]
    map :save_as, %w[Alt-S]

    handler Methods::Layout
    map :close, %w[Control-w]
    1.upto(9){|n| map([:focus, n], ["Alt-#{n}"], ["Escape", n.to_s]) }

    handler Methods::Insert
    map :newline,    %w[Return]
    map :selection,  %w[Shift-Insert]
    map :tab,        %w[Control-t]
    missing :string

    handler Methods::Control
    map :indent_line,                   %w[Alt-i], %w[Escape i]
    map :unindent_line,                 %w[Alt-I], %w[Escape I]
    map :exec_into_new,                 %w[F2]
    map :exec_into_void,                %w[F8]
    map [:exec_into_new, 'ruby -c $f'], %w[Control-Alt-c]
    map :cursor_vertical_top,           %w[Alt-comma], %w[Escape comma]
    map :cursor_vertical_bottom,        %w[Alt-period], %w[Escape period]
    map :join_line_forward,             %w[Alt-j], %w[Escape j]
    map :join_line_backward,            %w[Alt-J], %w[Escape J]

    handler Methods::Completion
    map :word, %w[Alt-e], %w[Escape e]

    handler Methods::Clipboard
    map :paste, %w[Control-v]

    handler Methods::Undo
    map :undo, %w[Control-z]
    map :redo, %w[Control-y]

    handler Methods::Delete
    map :kill_line,                      %w[Control-k], %w[Control-d Control-d]
    map [:delete_motion, :end_of_line],  %w[Control-Alt-k], %w[Control-d dollar]
    map [:delete_motion, :prev_char],    %w[BackSpace]
    map [:delete_motion, :next_char],    %w[Delete]

    handler Methods::Bookmark
    map :add_named,    %w[Alt-b Alt-a]
    map :next,         %w[Alt-b Alt-n]
    map :prev,         %w[Alt-b Alt-p]
    map :remove_named, %w[Alt-b Alt-r]
    map :toggle,       %w[Alt-b Alt-b]
    map :visit_named,  %w[Alt-b Alt-g]
    # these are only valid on US keymap, don't know a better way.
    map [:add_named, '1'],   %w[Alt-b Alt-exclam]
    map [:add_named, '2'],   %w[Alt-b Alt-at]
    map [:add_named, '3'],   %w[Alt-b Alt-numbersign]
    map [:add_named, '4'],   %w[Alt-b Alt-dollar]
    map [:add_named, '5'],   %w[Alt-b Alt-percent]
    map [:visit_named, '1'], %w[Alt-b Alt-1]
    map [:visit_named, '2'], %w[Alt-b Alt-2]
    map [:visit_named, '3'], %w[Alt-b Alt-3]
    map [:visit_named, '4'], %w[Alt-b Alt-4]
    map [:visit_named, '5'], %w[Alt-b Alt-5]

    handler Methods::CTags
    map :go,           %w[Alt-t]
    map :find_current, %w[Alt-parenright]
    map :prev,         %w[Alt-parenleft]

    handler Methods::Search
    map :status_next, %w[Control-f]
    map :next,        %w[F3]
    map :clear,       %w[Control-Alt-u]
    # TODO: this doesn't work, investiate.
    map :prev,        %w[Shift-F3]
  end

  minor_mode :select do
    handler Methods::Selection
    map :copy,                   %w[Control-c]
    map :kill,                   %w[Control-x]
    map :delete,                 %w[BackSpace], %w[Delete]
    map :replace_with_clipboard, %w[Control-v]
  end

  minor_mode :select_char do
    inherits :move, :select
    become :control, %w[Escape]
    handler Methods::Selection
    enter :enter
    leave :leave
  end

  minor_mode :select_line do
    inherits :move, :select
    become :control, %w[Escape]
    handler Methods::Selection
    enter :enter
    leave :leave
  end

  minor_mode :readline do
    map :accept_line,       %w[Return]

    map :end_of_line,       %w[End], %w[Control-e]
    map :insert_selection,  %w[Shift-Insert]
    map :insert_tab,        %w[Control-v Tab]
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
end
