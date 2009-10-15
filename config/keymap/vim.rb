module VER
  class Keymap
    def self.vim(options)
      vim = new(options)
      vim.mode = options.fetch(:mode, :control)

      vim.add_mode :basic do |mode|
        mode.map :file_open_popup,    %w[Control-o]
        mode.map :file_open_fuzzy,    %w[Alt-o], %w[Control-m o]
        mode.map :status_evaluate,    %w[Alt-x], %w[Control-m x]
        mode.map :file_save,          %w[Control-s]
        mode.map :file_save_popup,    %w[Control-Alt-s]
        mode.map :quit,               %w[Control-q]
        mode.map :start_control_mode, %w[Escape], %w[Control-c]

        mode.map :buffer_switch, %w[Alt-b], %w[Control-m b]
        mode.map :window_switch, %w[Alt-B], %w[Control-m B]
      end

      vim.add_mode :views do |mode|
        mode.map :view_create,     %w[Control-w c]
        mode.map :view_focus_next, %w[Control-w j]
        mode.map :view_focus_prev, %w[Control-w k]
        mode.map :view_push_down,  %w[Control-w J]
        mode.map :view_push_up,    %w[Control-w K]
        mode.map :view_close,      %w[Control-w w]
      end

      vim.add_mode :move do |mode|
        mode.map :go_beginning_of_line,   %w[KeyPress-0]
        mode.map :go_char_left,           %w[h], %w[Left]
        mode.map :go_char_right,          %w[l], %w[Right]
        mode.map :go_end_of_file,         %w[G]
        mode.map :go_end_of_line,         %w[dollar]
        mode.map :go_line,                %w[g g]
        mode.map :go_line_down,           %w[j], %w[Down]
        mode.map :go_line_up,             %w[k], %w[Up]
        mode.map :go_next_newline_block,  %w[braceleft]
        mode.map :go_page_down,           %w[Control-f], %w[Next]
        mode.map :go_page_up,             %w[Control-b], %w[Prior]
        mode.map :go_prev_newline_block,  %w[braceright]
        mode.map :go_word_left,           %w[b]
        mode.map :go_word_right,          %w[w]
      end

      vim.add_mode :search do |mode|
        mode.map :search_next,                   %w[n]
        mode.map :search_next_word_under_cursor, %w[asterisk]
        mode.map :search_prev,                   %w[N]
        mode.map :search_prev_word_under_cursor, %w[numbersign]
        mode.map :status_search,                 %w[slash]
      end

      vim.add_mode :control do |mode|
        mode.inherits :basic, :move, :views, :search

        mode.map :copy_left_word,                %w[y b]
        mode.map :copy_line,                     %w[y y], %w[Y]
        mode.map :copy_right_word,               %w[y w]
        mode.map :delete_char_left,              %w[X]
        mode.map :delete_char_left_then_insert,  %w[c h]
        mode.map :delete_char_right,             %w[x]
        mode.map :delete_char_right_then_insert, %w[c l]
        mode.map :delete_line,                   %w[d d]
        mode.map :delete_to_eol,                 %w[D]
        mode.map :delete_to_eol_then_insert,     %w[C]
        mode.map :delete_word_left,              %w[d b]
        mode.map :delete_word_left_then_insert,  %w[c b]
        mode.map :delete_word_right,             %w[d w]
        mode.map :delete_word_right_then_insert, %w[c w]
        mode.map :eol_then_insert_mode,          %w[A]
        mode.map :indent_line,                   %w[greater]
        mode.map :insert_indented_newline_above, %w[O]
        mode.map :insert_indented_newline_below, %w[o]
        mode.map :join_lines,                    %w[J]
        mode.map :paste,                         %w[p]
        mode.map :redo,                          %w[Control-r]
        mode.map :replace_char,                  %w[r]
        mode.map :smart_evaluate,                %w[Alt-e], %w[Control-m e]
        mode.map :sol_then_insert_mode,          %w[I]
        mode.map :start_insert_mode,             %w[i]
        mode.map :start_replace_mode,            %w[R]
        mode.map :start_select_block_mode,       %w[Control-v]
        mode.map :start_select_char_mode,        %w[v]
        mode.map :start_select_line_mode,        %w[V]
        mode.map :status_theme_select,           %w[Alt-t], %w[Control-m t]
        mode.map :syntax_switch,                 %w[Control-y]
        mode.map :theme_switch,                  %w[Control-t]
        mode.map :undo,                          %w[u]
        mode.map :unindent_line,                 %w[less]
        mode.map :wrap_line,                     %w[g w]
      end

      vim.add_mode :replace do |mode|
        mode.inherits :basic
      end

      vim.add_mode :readline do |mode|
        mode.arguments = false

        mode.map :delete_char_left,        %w[BackSpace]
        mode.map :delete_char_right,       %w[Delete]
        mode.map :go_char_left,            %w[Left]
        mode.map :go_char_right,           %w[Right]
        mode.map :go_word_left,            %w[Shift-Left]
        mode.map :go_word_right,           %w[Shift-Right]

        KEYSYMS.each do |sym, name|
          mode.map [:insert_string, sym], [name]
        end
      end

      vim.add_mode :insert do |mode|
        mode.inherits :basic, :views, :readline
        mode.arguments = false

        mode.map :go_line_down,            %w[Down]
        mode.map :go_line_up,              %w[Up]
        mode.map :go_page_down,            %w[Control-f], %w[Next]
        mode.map :go_page_down,            %w[Shift-Down]
        mode.map :go_page_up,              %w[Control-b], %w[Prior]
        mode.map :go_page_up,              %w[Shift-Up]
        mode.map :insert_indented_newline, %w[Return]
        mode.map :smart_evaluate,          %w[Alt-e], %w[Control-e]
        mode.map :complete_aspell,         %w[Control-x Control-a]
        mode.map :complete_file,           %w[Control-x Control-f]

        mode.missing :insert_string
      end

      vim.add_mode :select do |mode|
        mode.inherits :basic, :move, :search

        mode.map :copy_selection,               %w[y], %w[Y]
        mode.map :delete_selection,             %w[d], %w[D], %w[x], %w[BackSpace], %w[Delete]
        mode.map :indent_selection,             %w[greater]
        mode.map :pipe_selection,               %w[exclam]
        mode.map :smart_evaluate,               %w[Alt-e], %w[Control-e]
        mode.map :switch_select_block_mode,     %w[Control-v]
        mode.map :switch_select_char_mode,      %w[v]
        mode.map :switch_select_line_mode,      %w[V]
        mode.map :unindent_selection,           %w[less]
        mode.map :comment_selection,            %w[comma c]
        mode.map :uncomment_selection,          %w[comma u]
        mode.map :wrap_selection,               %w[g w]
        mode.map [:finish_selection, :control], %w[Escape], %w[Control-c]
      end

      vim.add_mode :select_char do |mode|
        mode.inherits :select
      end

      vim.add_mode :select_line do |mode|
        mode.inherits :select
      end

      vim.add_mode :select_block do |mode|
        mode.inherits :select
      end

      vim.add_mode :complete do |mode|
        mode.inherits :basic

        mode.to :complete_file, %w[Control-x Control-f]
        mode.to :complete_line, %w[Control-x Control-l]
        mode.to :complete_omni, %w[Control-x Control-o]
        mode.to :complete_word, %w[Control-x Control-i]
      end

      vim.add_mode :status_query do |mode|
        mode.inherits :basic, :readline
        mode.arguments = false

        mode.to :ask_abort,  %w[Escape], %w[Control-c]
        mode.to :ask_submit, %w[Return]

        mode.missing :insert_string
      end

      vim.add_mode :list_view_entry do |mode|
        mode.inherits :basic, :readline
        mode.arguments = false

        # mode.to :update, %w[Key]
        mode.to :pick_selection, %w[Return]
        mode.to :cancel,         %w[Escape], %w[Control-c]
        mode.to :go_line_up,     %w[Up]
        mode.to :go_line_down,   %w[Down]

        mode.missing :insert_string
      end

      vim.add_mode :list_view_list do |mode|
        mode.inherits :basic

        mode.to :pick_selection, %w[Double-Button-1]
        mode.to :go_line_up,     %w[Up]
        mode.to :go_line_down,   %w[Down]
      end

      vim
    end
  end
end
