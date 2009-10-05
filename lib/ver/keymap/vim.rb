module VER
  class Keymap
    def self.vim(options)
      vim = new(options)
      vim.current_mode = options.fetch(:current_mode, :control)

      vim.add_mode :basic do |mode|
        mode.map :file_open_popup,    %w[Control-o]
        mode.map :file_save,          %w[Control-s]
        mode.map :file_save_popup,    %w[Control-Alt-s]
        mode.map :quit,               %w[Control-q]
        mode.map :start_control_mode, %w[Escape], %w[Control-c]

        mode.map :buffer_switch, %w[Alt-b]
      end

      vim.add_mode :views do |mode|
        mode.map :view_create,     %w[Control-w plus]
        mode.map :view_remove,     %w[Control-w plus]
        mode.map :view_focus_next, %w[Control-w j]
        mode.map :view_focus_prev, %w[Control-w k]
      end

      vim.add_mode :move do |mode|
        mode.map :go_line,              %w[g g]
        mode.map :go_char_left,         %w[h], %w[Left]
        mode.map :go_char_right,        %w[l], %w[Right]
        mode.map :go_end_of_file,       %w[G]
        mode.map :go_end_of_line,       %w[dollar]
        mode.map :go_line_down,         %w[j], %w[Down]
        mode.map :go_line_up,           %w[k], %w[Up]
        mode.map :go_page_down,         %w[Control-f], %w[Next]
        mode.map :go_page_up,           %w[Control-b], %w[Prior]
        mode.map :go_beginning_of_line, %w[0]
        mode.map :go_word_left,         %w[b]
        mode.map :go_word_right,        %w[w]
        mode.map :go_next_newline_block, %w[braceleft]
        mode.map :go_prev_newline_block, %w[braceright]
      end

      vim.add_mode :control do |mode|
        mode.inherits :basic, :move, :views

        mode.map :delete_char_right,             %w[x]
        mode.map :delete_char_left,              %w[X]
        mode.map :delete_word_right,             %w[d w]
        mode.map :delete_word_left,              %w[d b]
        mode.map :delete_line,                   %w[d d]
        mode.map :delete_to_eol,                 %w[D]
        mode.map :delete_to_eol_then_insert,     %w[C]
        mode.map :start_replace_mode,            %w[R]
        mode.map :start_insert_mode,             %w[i]
        mode.map :start_select_char_mode,        %w[v]
        mode.map :start_select_line_mode,        %w[V]
        mode.map :start_select_block_mode,       %w[Control-v]
        mode.map :eol_then_insert_mode,          %w[A]
        mode.map :sol_then_insert_mode,          %w[I]

        mode.map :smart_evaluate,                %w[Alt-e]
        mode.map :status_search,                 %w[slash]
        mode.map :search_next,                   %w[n]
        mode.map :search_prev,                   %w[N]
        mode.map :insert_indented_newline_above, %w[O]
        mode.map :insert_indented_newline_below, %w[o]

        mode.map :search_next_word_under_cursor, %w[asterisk]
        mode.map :search_prev_word_under_cursor, %w[numbersign]

        mode.map :undo,                          %w[u]
        mode.map :redo,                          %w[Control-r]

        mode.map :copy_line,                     %w[y y], %w[Y]
        mode.map :copy_right_word,               %w[y w]
        mode.map :copy_left_word,                %w[y b]
        mode.map :paste,                         %w[p]

        mode.missing :ignore_string
      end

      vim.add_mode :replace do |mode|
        mode.inherits :basic
      end

      vim.add_mode :insert do |mode|
        mode.inherits :basic, :views
        mode.arguments = false

        mode.map :go_char_left,            %w[Left]
        mode.map :go_char_right,           %w[Right]
        mode.map :go_line_down,            %w[Down]
        mode.map :go_line_up,              %w[Up]
        mode.map :go_page_down,            %w[Control-f], %w[Next]
        mode.map :go_page_up,              %w[Control-b], %w[Prior]
        mode.map :smart_evaluate,          %w[Alt-e]
        mode.map :insert_indented_newline, %w[Return]
        mode.map :delete_char_left,        %w[BackSpace]
        mode.map :delete_char_right,       %w[Delete]

        mode.map :go_page_up,              %w[Shift-Up]
        mode.map :go_page_down,            %w[Shift-Down]
        mode.map :go_word_left,            %w[Shift-Left]
        mode.map :go_word_right,           %w[Shift-Right]

        0.upto(9){|n| mode.map(["insert_string".to_sym, n.to_s], [n.to_s]) }
        mode.map [:insert_string, '#'], %w[numbersign]
        mode.map [:insert_string, '$'], %w[dollar]
        mode.map [:insert_string, '*'], %w[asterisk]
        mode.map [:insert_string, '+'], %w[plus]
        mode.map [:insert_string, '/'], %w[slash]
        mode.map [:insert_string, '{'], %w[braceleft]
        mode.map [:insert_string, '}'], %w[braceright]

        mode.missing :insert_string
      end

      vim.add_mode :select do |mode|
        mode.inherits :basic, :move

        mode.map :copy_selection, %w[y]
        mode.map :smart_evaluate, %w[Alt-e]

        mode.map :switch_select_char_mode,        %w[v]
        mode.map :switch_select_line_mode,        %w[V]
        mode.map :switch_select_block_mode,       %w[Control-v]
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
        mode.inherits :basic

        mode.to :status_issue, %w[Return]

        mode.missing :insert_string
      end

      vim
    end
  end
end
