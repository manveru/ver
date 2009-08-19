$LOAD_PATH.unshift File.expand_path('../', __FILE__)

# stdlib
require 'tk'
require 'yaml'
require 'tmpdir'
require 'digest/sha1'

# lib
require 'ver/view'
require 'ver/layout'
require 'ver/syntax'
require 'ver/textpow'
require 'ver/theme'
require 'ver/keymap'
require 'ver/keymap/vim'
require 'ver/text'
require 'ver/theme/murphy'

module VER
  module_function

  def status
    @status
  end

  def run
    # p Tk::Tile.themes
    Tk::Tile.set_theme('clam')

    root = TkRoot.new
    win = Layout.new(root)

    ARGV.each do |arg|
      win.create_view{|view| view.file_open(arg) }
    end

    win.horizontal_tiling top: 1

    @status = Ttk::Entry.new(root, font: 'Terminus 9', takefocus: 0)
    @status.pack(side: :bottom, fill: :x)
    @status.value = 'Welcome to VER - Quit with Control-q'

    Tk.bind :all, 'Control-q', proc{ exit }

    Tk.mainloop
  end
end

__END__

  def setup_input_mode
    input = text_frame.modes[:input]

    input.bind('Key'){|key|
      p key
      case keysym = key.keysym
      when /^.$/
        char = keysym
      else
        unless char = key.char
          status_frame.value = "Nothing mapped to: #{key.keysym}"
        end
      end

      text_frame.insert(:insert, char)
      Tk.callback_break
    }

    input.bind_key :Left,       :go_char_left
    input.bind_key :Right,      :go_char_right
    input.bind_key :Up,         :go_line_up
    input.bind_key :Down,       :go_line_down

    input.bind_key :BackSpace,  :delete_char_left
    input.bind_key :Delete,     :delete_char_right

    input.bind_key :Return,     :insert_newline
    input.bind_key :space,      :insert_space
    input.bind_key :Tab,        :insert_tab

    input.bind_key :Escape,     :start_control_mode
    input.bind_key 'Control-c', :start_control_mode

    input.bind_key :Prior,      :go_page_up
    input.bind_key 'Control-b', :go_page_up

    input.bind_key :Next,       :go_page_down
    input.bind_key 'Control-f', :go_page_down

    input.bind_key 'Control-z', :undo
    input.bind_key 'Control-Z', :redo

    input.bind_key :Home,       :go_beginning_of_file
    input.bind_key :End,        :go_end_of_file

    input.bind 'Control-q', proc{ exit }
  end

  def setup_control_mode
    control = text_frame.modes[:control]

    control.bind('Key'){|key|
      status_frame.value = "Nothing mapped to: #{key.keysym}"
      Tk.callback_break
    }

    control.bind_key :i, :start_input_mode
    control.bind_key :v, :start_visual_char_mode
    control.bind_key :V, :start_visual_line_mode
    control.bind_key 'Control-v', :start_visual_block_mode

    control.bind_key :Left,  :go_char_left
    control.bind_key :h,     :go_char_left
    control.bind_key :Right, :go_char_right
    control.bind_key :l,     :go_char_right
    control.bind_key :Up,    :go_line_up
    control.bind_key :k,     :go_line_up
    control.bind_key :Down,  :go_line_down
    control.bind_key :j,     :go_line_down

    control.bind_key :w,     :go_word_right
    control.bind_key :b,     :go_word_left

    control.bind_key :o,     :insert_newline_below
    control.bind_key :O,     :insert_newline_above

    control.bind_key :BackSpace, :go_char_left
    control.bind_key :Delete,    :delete_char_right
    control.bind_key :x,         :delete_char_right

    control.bind_key 'Control-b', :go_page_up
    control.bind_key :Prior, :go_page_up

    control.bind_key 'Control-f', :go_page_down
    control.bind_key :Next,  :go_page_down

    control.bind_key :Home,  :go_beginning_of_file
    control.bind_key :End,   :go_end_of_file
    control.bind_key :G,   :go_end_of_file

    control.bind_key 'u', :undo
    control.bind_key 'Control-r', :redo

    control.bind 'Control-q', proc{ exit }
  end

  def setup_visual_mode
    visual_char  = text_frame.modes[:visual_char]
    visual_line  = text_frame.modes[:visual_line]
    visual_block = text_frame.modes[:visual_block]

    [visual_char, visual_line, visual_block].each do |v|
      v.bind_key :v, :start_visual_char_mode
      v.bind_key :V, :start_visual_line_mode
      v.bind_key 'Control-v', :start_visual_block_mode

      v.bind_key :Left,  :go_char_left
      v.bind_key :h,     :go_char_left
      v.bind_key :Right, :go_char_right
      v.bind_key :l,     :go_char_right
      v.bind_key :Up,    :go_line_up
      v.bind_key :k,     :go_line_up
      v.bind_key :Down,  :go_line_down
      v.bind_key :j,     :go_line_down

      v.bind_key :w,     :go_word_right
      v.bind_key :b,     :go_word_left

      v.bind_key 'Control-b', :go_page_up
      v.bind_key :Prior, :go_page_up

      v.bind_key 'Control-f', :go_page_down
      v.bind_key :Next,  :go_page_down

      v.bind_key :Escape,     :start_control_mode
      v.bind_key 'Control-c', :start_control_mode

      v.bind 'Control-q', proc{ exit }
    end
  end

  def font
    case Tk::PLATFORM['os']
    when 'Linux'
      TkFont.new(['Terminus', -9])
    else
      TkFont.new(['Monospace', -10])
    end
  end
end
