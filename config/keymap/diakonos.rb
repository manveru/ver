module VER
  class Keymap
    def self.diakonos(options)
      diakonos = new(options)
      diakonos.mode = options.fetch(:mode, :buffer)

      diakonos.add_mode :buffer do |mode|
        mode.arguments = false

        mode.map :quit,               %w[Control-q]
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

        # TODO
        mode.map :top_of_view,        %w[Alt-comma]
        mode.map :bottom_of_view,     %w[Alt-period]
        mode.map :previous_cursor,    %w[Control-j]
        mode.map :forward_cursor,     %w[Control-l]
        mode.map :scroll_down,        %w[Alt-n]
        mode.map :scroll_up,          %w[Alt-p]
        mode.map :ask_go_line,        %w[Control-g]

        mode.map :toggle_bookmark,    %w[Alt-b Alt-b]
        mode.map :forward_bookmark,   %w[Alt-b Alt-n]
        mode.map :previous_bookmark,  %w[Alt-b Alt-p]
        mode.map :add_named_bookmark, %w[Alt-b Alt-a]

        mode.map :remove_named_bookmark, %w[Alt-b Alt-r]
        mode.map :go_named_bookmark, %w[Alt-b Alt-g]

        mode.map [:add_named_bookmark, 1], %w[Alt-b Alt-Shift-1]
        mode.map [:add_named_bookmark, 2], %w[Alt-b Alt-Shift-2]
        mode.map [:add_named_bookmark, 3], %w[Alt-b Alt-Shift-3]
        mode.map [:add_named_bookmark, 4], %w[Alt-b Alt-Shift-4]
        mode.map [:add_named_bookmark, 5], %w[Alt-b Alt-Shift-5]

        mode.map [:go_named_bookmark, 1], %w[Alt-b Alt-1]
        mode.map [:go_named_bookmark, 2], %w[Alt-b Alt-2]
        mode.map [:go_named_bookmark, 3], %w[Alt-b Alt-3]
        mode.map [:go_named_bookmark, 4], %w[Alt-b Alt-5]
        mode.map [:go_named_bookmark, 5], %w[Alt-b Alt-5]

        mode.map :go_tag, %w[Alt-t]
        mode.map :go_tag_under_cursor, %w[Alt-greater]
        mode.map :pop_tag, %w[Alt-less]

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

        KEYSYMS.each do |sym, name|
          mode.map [:insert_string, sym], [name]
        end

        mode.missing :insert_string
      end
    end
  end
end
