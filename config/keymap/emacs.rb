emacs = VER::Keymap.new(name: :emacs, mode: :basic)

emacs.add_mode :quirks do |mode|
  mode.arguments = false

  # TODO
  mode.map :universal_argument,   %w[Control-u]
  mode.map :keyboard_quit,        %w[Control-g]
end

emacs.in_mode :basic do
  inherits :quirks
  arguments = false
  missing :insert_string

  key :quit,                            %w[Control-x Control-c]
  key :page_down,                       %w[Control-v], %w[Next]
  key :page_up,                         %w[Alt-v], %w[Prior]
  key :previous_line,                   %w[Control-p], %w[Up]
  key :next_line,                       %w[Control-n], %w[Down]
  key :backward_char,                   %w[Control-b], %w[Left]
  key :forward_char,                    %w[Control-f], %w[Right]
  key :backward_word,                   %w[Alt-b]
  key :forward_word,                    %w[Alt-f]
  key :beginning_of_line,               %w[Control-a]
  key :end_of_line,                     %w[Control-e]
  key :go_line,                         %w[Control-less]
  key :end_of_file,                     %w[Control-greater]
  key :undo,                            %w[Control-slash], %w[Undo]
  key :redo,                            %w[Redo]
  key :join_lines,                      %w[Control-j]
  key :insert_newline,                  %w[Return]
  key [:delete_motion, :backward_char], %w[BackSpace]
  key [:delete_motion, :forward_char],  %w[Control-d], %w[Delete]
  key [:kill_motion, :end_of_line],     %w[Control-k]
  key :kill_sentence,                   %w[Alt-k]
  key [:kill_motion, :forward_word],    %w[Alt-d]
  key [:kill_motion, :backward_word],   %w[Alt-BackSpace]

  # HACK, this probably shouldn't switch modes.
  key [:start_selection, :block], %w[Control-space]

  KEYSYMS.each do |sym, name|
    key [:insert_string, sym], [name]
  end

  # TODO
  key :recenter_top_bottom, %w[Control-l]
  key :go_beginning_of_sentence, %w[Alt-a]
  key :go_end_of_sentence, %w[Alt-e]
  key :kill_region,          %w[Control-w]

  key :describe_key_briefly, %w[Control-h c]
  key :describe_key,         %w[Control-h k]
  key :describe_function,    %w[Control-h f]
  key :apropos_command,      %w[Control-h a]
end
