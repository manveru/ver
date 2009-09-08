module VER
  class Keymap
    def self.vim(callback)
      vim = new(callback, 'VIM alike')
      vim.current_mode = :control

      vim.mode :basic do |map|
        map.to :file_open_popup,    %w[Control-o]
        map.to :file_save,          %w[Control-s]
        map.to :file_save_popup,    %w[Control-Alt-s]
        map.to :quit,               %w[Control-q]
        map.to :start_control_mode, %w[Escape]

        map.to :buffer_switch, %w[Alt-b]
      end

      vim.mode :move do |map|
        map.to :go_line,              %w[g g]
        map.to :go_char_left,         %w[h], %w[Left]
        map.to :go_char_right,        %w[l], %w[Right]
        map.to :go_end_of_file,       %w[G]
        map.to :go_end_of_line,       %w[dollar]
        map.to :go_line_down,         %w[j], %w[Down]
        map.to :go_line_up,           %w[k], %w[Up]
        map.to :go_page_down,         %w[Control-f], %w[Next]
        map.to :go_page_up,           %w[Control-b], %w[Prior]
        map.to :go_beginning_of_line, %w[0]
        map.to :go_word_left,         %w[b]
        map.to :go_word_right,        %w[w]
        map.to :go_next_newline_block, %w[braceleft]
        map.to :go_prev_newline_block, %w[braceright]
      end

      vim.mode :control do |map|
        map.uses :basic, :move

        map.to :delete_char_right,             %w[x]
        map.to :delete_char_left,              %w[X]
        map.to :delete_movement,               ['d', :move]
        map.to :delete_movement_then_insert,   ['c', :move]
        map.to :start_replace_mode,            %w[R]
        map.to :start_insert_mode,             %w[i]
        map.to :start_select_char_mode,        %w[v]

        map.to :smart_evaluate,                %w[Alt-e]
        map.to :status_search,                 %w[slash]
        map.to :search_next,                   %w[n]
        map.to :search_prev,                   %w[N]
        map.to :insert_indented_newline_above, %w[O]
        map.to :insert_indented_newline_below, %w[o]

        map.to :search_next_word_under_cursor, %w[asterisk]
        map.to :search_prev_word_under_cursor, %w[numbersign]

        map.missing :ignore_character
      end

      vim.mode :replace do |map|
        map.uses :basic
      end

      vim.mode :insert do |map|
        map.uses :basic #, :complete

        map.to :go_char_left,            %w[Left]
        map.to :go_char_right,           %w[Right]
        map.to :go_line_down,            %w[Down]
        map.to :go_line_up,              %w[Up]
        map.to :go_page_down,            %w[Control-f], %w[Next]
        map.to :go_page_up,              %w[Control-b], %w[Prior]
        map.to :smart_evaluate,          %w[Alt-e]
        map.to :insert_indented_newline, %w[Return]
        map.to :delete_char_left,        %w[BackSpace]
        map.to :delete_char_right,       %w[Delete]

        map.to :go_page_up,              %w[Shift-Up]
        map.to :go_page_down,            %w[Shift-Down]
        map.to :go_word_left,            %w[Shift-Left]
        map.to :go_word_right,           %w[Shift-Right]

        map.missing :insert_string
      end

      vim.mode :select_char do |map|
        map.uses :basic, :move
        map.to :copy_selection, %w[y]
        map.to :smart_evaluate, %w[Alt-e]
      end

      vim.mode :complete do |map|
        map.uses :basic

        map.to :complete_file, %w[Control-x Control-f]
        map.to :complete_line, %w[Control-x Control-l]
        map.to :complete_omni, %w[Control-x Control-o]
        map.to :complete_word, %w[Control-x Control-i]
      end

      vim.mode :status_query do |map|
        map.uses :basic

        map.to :status_issue, %w[Return]
      end

      vim
    end
  end
end
