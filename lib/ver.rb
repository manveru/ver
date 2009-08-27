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

  class << self
    attr_reader :root, :win, :status
  end

  def run
    # p Tk::Tile.themes
    Tk::Tile.set_theme('clam')

    @root = TkRoot.new
    @win = Layout.new(@root)

    ARGV.each{|arg| file_open(arg) }

    @status = Ttk::Entry.new(@root, font: 'Terminus 9', takefocus: 0)
    @status.pack(side: :bottom, fill: :x)
    @status.value = 'Welcome to VER - Quit with Control-q'

    Tk.bind :all, 'Control-q', proc{ exit }

    Tk.mainloop
  end

  def file_open(path)
    @win.create_view{|view|
      view.file_open(path)
      view.raise
    }
    @win.horizontal_tiling top: 1
  end
end
