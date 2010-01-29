module VER
  major_mode :Fundamental do
    handler Methods::Basic
    map :quit, %w[Control-x Control-c]

    handler Methods::Save
    map :file_save, %w[Control-x Control-s]
    map :save_all, %w[Control-x s]

    handler Methods::Open
    map :file_open_popup, %w[Control-x Control-f]

    handler Methods::Help
    map :describe_key, %w[Control-h k]

    handler Methods::Undo
    map :undo, %w[Control-slash], %w[Control-x u], %w[Control-underscore], %w[Undo]
    map :redo, %w[Redo] # emacs redo breaks my brain... undo only for now

    handler Methods::Move
    map :end_of_file,     %w[Control-greater]
    map :end_of_line,     %w[Control-e], %w[End]
    map :next_char,       %w[Control-f], %w[Right]
    map :next_line,       %w[Control-n], %w[Down]
    map :next_page,       %w[Control-v], %w[Next]
    map :next_word,       %w[Alt-f]
    map :prev_char,       %w[Control-b], %w[Left]
    map :prev_line,       %w[Control-p], %w[Up]
    map :prev_page,       %w[Alt-v],     %w[Prior]
    map :prev_word,       %w[Alt-b]
    map :start_of_file,   %w[Control-less]
    map :start_of_line,   %w[Control-a], %w[Home]
    map :end_of_sentence, %w[Alt-e]

    handler Methods::Delete
    map [:delete_motion, :prev_char],     %w[BackSpace]
    map [:delete_motion, :next_char],     %w[Control-d], %w[Delete]
    map [:kill_motion, :end_of_line],     %w[Control-k]
    map [:kill_motion, :end_of_sentence], %w[Alt-k]
    map [:kill_motion, :next_word],       %w[Alt-d]
    map [:kill_motion, :prev_word],       %w[Alt-BackSpace]

    handler VER::Methods::Insert
    map :newline, %w[Return]
    missing :string
  end
end
