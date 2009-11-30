module VER
  class Keymap
    def self.diakonos(options)
      diakonos = new(options)
      diakonos.mode = options.fetch(:mode, :buffer)

      diakonos.add_mode :basic do |mode|
        mode.map :quit, %w[Control-q]
      end

      diakonos.add_mode :readline do |mode|
        mode.arguments = false

        mode.map [:kill_motion, :backward_char],   %w[BackSpace]
        mode.map [:kill_motion, :forward_char],    %w[Delete], %w[Control-d]
        mode.map [:kill_motion, :backward_word],   %w[Control-w]
        mode.map :backward_char,                   %w[Left], %w[Control-b]
        mode.map :forward_char,                    %w[Right], %w[Control-f]
        mode.map :backward_word,                   %w[Shift-Left], %w[Alt-b]
        mode.map :forward_word,                    %w[Shift-Right], %w[Alt-f]
        mode.map :beginning_of_line,               %w[Home], %w[Control-a]
        mode.map :end_of_line,                     %w[End], %w[Control-e]
        mode.map :insert_selection,                %w[Shift-Insert]
        mode.map :accept_line,                     %w[Return]
        mode.map :previous_history,                %w[Up], %w[Control-p]
        mode.map :next_history,                    %w[Down], %w[Control-n]
        mode.map :beginning_of_history,            %w[Control-less]
        mode.map :end_of_history,                  %w[Control-greater]
        mode.map :transpose_chars,                 %w[Control-t]
        mode.map :insert_tab,                      %w[Control-v Tab]

        KEYSYMS.each do |sym, name|
          mode.map [:insert_string, sym], [name]
        end
      end

      diakonos.add_mode :status_query do |mode|
        mode.inherits :basic, :readline
        mode.arguments = false

        mode.to :ask_abort,        %w[Escape], %w[Control-c]
        mode.to :history_prev,     %w[Up], %w[Control-p]
        mode.to :history_next,     %w[Down], %w[Control-n]
        mode.to :history_complete, %w[Tab]
        mode.to :ask_submit,       %w[Return]

        mode.missing :insert_string
      end

      diakonos.add_mode :buffer do |mode|
        mode.inherits :basic, :readline
        mode.arguments = false

        mode.map :backward_char,      %w[Left]
        mode.map :forward_char,       %w[Right]
        mode.map :previous_line,      %w[Up]
        mode.map :next_line,          %w[Down]
        mode.map :beginning_of_line,  %w[Home]
        mode.map :end_of_line,        %w[End]
        mode.map :page_up,            %w[Prior]
        mode.map :page_down,          %w[Next]
        mode.map :end_of_file,        %w[Alt-greater]
        mode.map :go_line,            %w[Alt-less]

        mode.map :bookmark_toggle, %w[Alt-b Alt-b]
        mode.map :next_bookmark,   %w[Alt-b Alt-n]
        mode.map :prev_bookmark,   %w[Alt-b Alt-p]

        mode.map :named_bookmark_add,    %w[Alt-b Alt-a]
        mode.map :named_bookmark_remove, %w[Alt-b Alt-r]
        mode.map :named_bookmark_visit,  %w[Alt-b Alt-g]

        # these are only valid on US keymap, don't know a better way.
        mode.map [:named_bookmark_add, '1'], %w[Alt-b Alt-exclam]
        mode.map [:named_bookmark_add, '2'], %w[Alt-b Alt-at]
        mode.map [:named_bookmark_add, '3'], %w[Alt-b Alt-numbersign]
        mode.map [:named_bookmark_add, '4'], %w[Alt-b Alt-dollar]
        mode.map [:named_bookmark_add, '5'], %w[Alt-b Alt-percent]

        mode.map [:named_bookmark_visit, '1'], %w[Alt-b Alt-1]
        mode.map [:named_bookmark_visit, '2'], %w[Alt-b Alt-2]
        mode.map [:named_bookmark_visit, '3'], %w[Alt-b Alt-3]
        mode.map [:named_bookmark_visit, '4'], %w[Alt-b Alt-4]
        mode.map [:named_bookmark_visit, '5'], %w[Alt-b Alt-5]

        mode.map :ctags_go,           %w[Alt-t]
        mode.map :ctags_find_current, %w[Alt-parenright]
        mode.map :ctags_prev,         %w[Alt-parenleft]

        mode.map :forward_scroll,  %w[Alt-n]
        mode.map :backward_scroll, %w[Alt-p]
=begin
        # TODO
        mode.map :top_of_view,        %w[Alt-comma]
        mode.map :bottom_of_view,     %w[Alt-period]
        mode.map :previous_cursor,    %w[Control-j]
        mode.map :forward_cursor,     %w[Control-l]

        mode.map :ask_go_line,        %w[Control-g]

        mode.map [:delete_motion, :backward_char], %w[BackSpace]
        mode.map [:delete_motion, :forward_char], %w[Delete]
        mode.map :kill_line, %w[Control-k], %w[Control-d Control-d]
        mode.map [:delete_motion, :end_of_line], %w[Control-Alt-k], %w[Control-d dollar]
        mode.map [:delete_motion, :end_of_line], %w[Control-Alt-k], %w[Control-d dollar]
        mode.map :insert_indented_newline, %w[Return]
        mode.map :indent_line, %w[Alt-i], %w[Escape i]
        mode.map :unindent_line, %w[Escape I]
        mode.map :forward_join_lines, %w[Alt-j]
        mode.map :backward_join_lines, %w[Escape J]
=end

        KEYSYMS.each do |sym, name|
          mode.map [:insert_string, sym], [name]
        end

        mode.missing :insert_string
      end

      diakonos
    end
  end
end
