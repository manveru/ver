module VER
  major_mode :Fundamental do
    use :fundamental
  end

  minor_mode :fundamental do
    handler Methods::Basic
    map :quit, '<Control-x><Control-c>'

    handler nil # Buffer instance methods
    map :save,     '<Control-x><Control-s>'
    map :save_all, '<Control-x>s'

    handler Methods::Open
    map :file_open_popup, '<Control-x><Control-f>'

    handler Methods::Help
    map :describe_key, '<Control-h>k'

    handler Methods::Undo
    map :undo, '<Control-slash>', '<Control-x>u', '<Control-underscore>', '<Undo>'
    map :redo, '<Redo>' # emacs redo breaks my brain... undo only for now

    handler :at_insert
    map :last_line,       '<Control-greater>'
    map :last_char,       '<Control-e>', '<End>'
    map :next_char,       '<Control-f>', '<Right>'
    map :next_line,       '<Control-n>', '<Down>'
    map :next_page,       '<Control-v>', '<Next>'
    map :next_word,       '<Alt-f>'
    map :prev_char,       '<Control-b>', '<Left>'
    map :prev_line,       '<Control-p>', '<Up>'
    map :prev_page,       '<Alt-v>',     '<Prior>'
    map :prev_word,       '<Alt-b>'
    map :first_line,      '<Control-less>'
    map :start_of_line,   '<Control-a>', '<Home>'
    map :end_of_sentence, '<Alt-e>'

    map [:deleting, :prev_char],      '<BackSpace>'
    map [:deleting, :next_char],      '<Control-d>', '<Delete>'
    map [:killing, :last_char],       '<Control-k>'
    map [:killing, :end_of_sentence], '<Alt-k>'
    map [:killing, :next_word],       '<Alt-d>'
    map [:killing, :prev_word],       '<Alt-BackSpace>'

    handler VER::Methods::Insert
    map :newline, '<Return>'
    missing :string
  end
end
