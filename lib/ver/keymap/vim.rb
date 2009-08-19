module VER
  class Keymap
    def self.vim(callback)
      map = new(callback, 'VIM alike')

      map.mode :basic do |map|
        map.to :file_open_popup,    %w[Control-o]
        map.to :file_save_popup,    %w[Control-s]
        map.to :file_save_popup,    %w[Control-Alt-s]
        map.to :quit,               %w[Control-q]
        map.to :start_control_mode, %w[Escape]
      end

      map.mode :move do |map|
        map.to :go_char_left,  %w[h], %w[Left]
        map.to :go_char_right, %w[l], %w[Right]
        map.to :go_line_down,  %w[j], %w[Down]
        map.to :go_line_up,    %w[k], %w[Up]
        map.to :go_beginning_of_file, %w[g g]
        map.to :go_end_of_file, %w[G]
        map.to :go_word_right, %w[w]
        map.to :go_word_left, %w[b]
        map.to :go_page_down, %w[Control-f], %w[Next]
        map.to :go_page_up,   %w[Control-b], %w[Prior]
      end

      map.mode :control do |map|
        map.uses :basic, :move

        map.to :delete_right, %w[x]
        map.to :delete_left,  %w[X]
        map.to :replace_with_char, ['r', :insert]
        map.to :delete_movement, ['d', :move]
        map.to :delete_movement_then_insert, ['c', :move]
        map.to :start_replace_mode, %w[R]
        map.to :start_insert_mode, %w[i]
        map.to :start_select_char_mode, %w[v]
      end

      map.mode :replace do |map|
        map.uses :basic
      end

      map.mode :insert do |map|
        map.uses :basic, :complete
      end

      map.mode :select_char do |map|
        map.uses :basic, :move
      end

      map.mode :complete do |map|
        map.uses :basic

        map.to :complete_file, %w[Control-x Control-f]
        map.to :complete_line, %w[Control-x Control-l]
        map.to :complete_omni, %w[Control-x Control-o]
        map.to :complete_word, %w[Control-x Control-i]
      end

      map.current_mode = :control

      map
    end
  end
end
