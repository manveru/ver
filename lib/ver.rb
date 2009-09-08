$LOAD_PATH.unshift File.expand_path('../', __FILE__)

# stdlib
require 'tk'
require 'json'
require 'tmpdir'
require 'digest/sha1'

module VER
  autoload :Keymap,  'ver/keymap'
  autoload :Layout,  'ver/layout'
  autoload :Status,  'ver/status'
  autoload :Syntax,  'ver/syntax'
  autoload :Text,    'ver/text'
  autoload :Textpow, 'ver/textpow'
  autoload :Theme,   'ver/theme'
  autoload :View,    'ver/view'

  module_function

  class << self
    attr_reader :root, :win, :status, :views
  end

  def run
    # p Tk::Tile.themes
    Tk::Tile.set_theme('clam')
    Thread.abort_on_exception = true

    @root = TkRoot.new
    @win = Layout.new(@root)
    @views = []

    @status = Status.new(@root, font: 'Terminus 9', takefocus: 0)
    @status.pack(side: :bottom, fill: :x)
    @status.value = 'Welcome to VER - Quit with Control-q'

    ARGV.each{|arg| file_open(arg) }

    Tk.bind :all, 'Control-q', proc{ exit }

    Tk.mainloop
  end

  def file_open(path)
    create_view{|view|
      view.file_open(path)
      view.raise
    }
    @win.horizontal_tiling top: 1
  end

  def create_view(&block)
    @win.create_view{|view|
      yield(view)
      @views.unshift view
    }
  end
end
