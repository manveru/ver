module VER
  class Keymap
    def self.emacs(options)
      emacs = new(options)
      emacs.mode = options.fetch(:mode, :basic)

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

        mode.map :quit,                            %w[Control-x Control-c]
        mode.map :page_down,                       %w[Control-v], %w[Next]
        mode.map :page_up,                         %w[Alt-v], %w[Prior]
        mode.map :previous_line,                   %w[Control-p], %w[Up]
        mode.map :next_line,                       %w[Control-n], %w[Down]
        mode.map :backward_char,                   %w[Control-b], %w[Left]
        mode.map :forward_char,                    %w[Control-f], %w[Right]
        mode.map :backward_word,                   %w[Alt-b]
        mode.map :forward_word,                    %w[Alt-f]
        mode.map :beginning_of_line,               %w[Control-a]
        mode.map :end_of_line,                     %w[Control-e]
        mode.map :go_line,                         %w[Control-less]
        mode.map :end_of_file,                     %w[Control-greater]
        mode.map :undo,                            %w[Control-slash], %w[Undo]
        mode.map :redo,                            %w[Redo]
        mode.map :join_lines,                      %w[Control-j]
        mode.map :insert_newline,                  %w[Return]
        mode.map [:delete_motion, :backward_char], %w[BackSpace]
        mode.map [:delete_motion, :forward_char],  %w[Control-d], %w[Delete]
        mode.map [:kill_motion, :end_of_line],     %w[Control-k]
        mode.map :kill_sentence,                   %w[Alt-k]
        mode.map [:kill_motion, :forward_word],    %w[Alt-d]
        mode.map [:kill_motion, :backward_word],   %w[Alt-BackSpace]

        # HACK, this probably shouldn't switch modes.
        mode.map [:start_selection, :block], %w[Control-space]

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

      emacs
    end
  end
end
