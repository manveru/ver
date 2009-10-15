module VER
  class Keymap
    def self.emacs(options)
      emacs = new(options)
      emacs.mode = options.fetch(:mode, :control)

      emacs.add_mode :quirks do |mode|
        mode.arguments = false

     		# TODO
        mode.map :universal_argument,   %w[Control-u]
        mode.map :keyboard_quit,        %w[Control-g]
      end

      emacs.add_mode :basic do |mode|
        mode.inherits :quirks
        mode.arguments = false
        mode.missing :insert_string

        mode.map :quit,                   %w[Control-x Control-c]
        mode.map :go_page_down,           %w[Control-v], %w[Next]
        mode.map :go_page_up,             %w[Alt-v], %w[Prior]
        mode.map :go_line_up,             %w[Control-p], %w[Up]
        mode.map :go_line_down,           %w[Control-n], %w[Down]
        mode.map :go_char_left,           %w[Control-b], %w[Left]
        mode.map :go_char_right,          %w[Control-f], %w[Right]
        mode.map :go_word_left,           %w[Alt-b]
        mode.map :go_word_right,          %w[Alt-f]
        mode.map :go_beginning_of_line,   %w[Control-a]
        mode.map :go_end_of_line,         %w[Control-e]
        mode.map :go_line,                %w[Control-less]
        mode.map :go_end_of_file,         %w[Control-greater]
        mode.map :undo,                   %w[Control-slash], %w[Undo]
        mode.map :redo,                   %w[Redo]
        mode.map :join_lines,             %w[Control-j]
        mode.map :insert_newline,         %w[Return]
        mode.map :delete_char_left,       %w[BackSpace]
        mode.map :delete_char_right,      %w[Control-d], %w[Delete]
        mode.map :delete_to_eol,          %w[Control-k]
        mode.map :delete_sentence,        %w[Alt-k]
        mode.map :delete_word_right,      %w[Alt-d]
        mode.map :delete_word_left,       %w[Alt-BackSpace]

        # HACK, this probably shouldn't switch modes.
        mode.map [:start_selection, :block], %w[Control-Space]

        KEYSYMS.each do |sym, name|
          mode.map [:insert_string, sym], [name]
        end

        # TODO
        mode.map :recenter_top_bottom, %w[Control-l]
        mode.map :go_beginning_of_sentence, %w[Alt-a]
        mode.map :go_end_of_sentence, %w[Alt-e]
        mode.map :kill_region,          %w[Control-w]

        mode.map :describe_key_briefly, %w[Control-h c]
        mode.map :describe_key,         %w[Control-h k]
        mode.map :describe_function,    %w[Control-h f]
        mode.map :apropos_command,      %w[Control-h a]
      end
    end
  end
end