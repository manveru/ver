module VER
  class Keymap
    def self.diakonos(options)
      diakonos = new(options)
      diakonos.mode = options.fetch(:mode, :buffer)
      diakonos.arguments = false

      diakonos.add_mode :basic do |mode|
        mode.map :quit, %w[Control-q]
      end

      diakonos.add_mode :buffers do |mode|
        mode.map :view_close, %w[Control-w]

        1.upto(9) do |n|
          mode.map [:view_focus, n], ["Alt-#{n}"]
        end
      end

      diakonos.add_mode :readline do |mode|
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

        mode.to :ask_abort,        %w[Escape], %w[Control-c]
        mode.to :history_prev,     %w[Up], %w[Control-p]
        mode.to :history_next,     %w[Down], %w[Control-n]
        mode.to :history_complete, %w[Tab]
        mode.to :ask_submit,       %w[Return]

        mode.missing :insert_string
      end

      diakonos.add_mode :bookmark do |mode|
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
      end

      diakonos.add_mode :ctags do |mode|
        mode.map :ctags_go,           %w[Alt-t]
        mode.map :ctags_find_current, %w[Alt-parenright]
        mode.map :ctags_prev,         %w[Alt-parenleft]
      end

      diakonos.add_mode :search do |mode|
        mode.map :status_search_next, %w[Control-f]
        mode.map :search_next,        %w[F3]
        mode.map :search_clear,       %w[Control-Alt-u]

        # TODO: this doesn't work, investiate.
        mode.map :search_prev,        %w[Shift-F3]
      end

      diakonos.add_mode :buffer do |mode|
        mode.inherits :basic, :buffers, :readline, :bookmark, :search
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

        mode.map :forward_scroll,  %w[Alt-n]
        mode.map :backward_scroll, %w[Alt-p]

        mode.map [:delete_motion, :backward_char], %w[BackSpace]
        mode.map [:delete_motion, :forward_char],  %w[Delete]
        mode.map :kill_line,                       %w[Control-k], %w[Control-d Control-d]
        mode.map [:delete_motion, :end_of_line],   %w[Control-Alt-k], %w[Control-d dollar]
        mode.map [:delete_motion, :end_of_line],   %w[Control-Alt-k], %w[Control-d dollar]

        mode.map :insert_indented_newline, %w[Return]

        mode.map :indent_line,   %w[Alt-i], %w[Escape i]
        mode.map :unindent_line, %w[Escape I]

        mode.map :complete_word, %w[Alt-e]

        mode.map :exec_into_new,  %w[F2]
        mode.map :exec_into_void, %w[F8]
        mode.map [:exec_into_new, 'ruby -c $f'], %w[Control-Alt-c]

        mode.map :insert_tab, %w[Control-t]

=begin
        # TODO
        mode.map :top_of_view,        %w[Alt-comma]
        mode.map :bottom_of_view,     %w[Alt-period]
        mode.map :previous_cursor,    %w[Control-j]
        mode.map :forward_cursor,     %w[Control-l]

        mode.map :ask_go_line,        %w[Control-g]


        mode.map :forward_join_lines, %w[Alt-j]
        mode.map :backward_join_lines, %w[Escape J]
=end

        KEYSYMS.each do |sym, name|
          mode.map [:insert_string, sym], [name]
        end

        mode.missing :insert_string
      end

      diakonos.add_mode :hover_completion do |mode|
        mode.inherits :basic

        mode.to :go_up,               %w[Up], %w[Control-n]
        mode.to :go_down,             %w[Down], %w[Control-p]
        mode.to :continue_completion, %w[Right], %w[Tab]
        mode.to :submit,              %w[Return]
        mode.to :cancel,              %w[Escape], %w[BackSpace]
      end

      diakonos
    end
  end
end
