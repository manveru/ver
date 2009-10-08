# Well begun is half done.
#             -- Aristotle

$LOAD_PATH.unshift File.expand_path('../', __FILE__)

# stdlib
require 'benchmark'
require 'digest/sha1'
require 'json'
require 'pp'
require 'set'
require 'tmpdir'
require 'tk'

module VER
  autoload :BufferListView,      'ver/view/buffer_list_view'
  autoload :FuzzyFileFinderView, 'ver/view/fuzzy_file_finder_view'
  autoload :Keymap,              'ver/keymap'
  autoload :Layout,              'ver/layout'
  autoload :ListView,            'ver/view/list_view'
  autoload :Methods,             'ver/methods'
  autoload :Mode,                'ver/mode'
  autoload :Status,              'ver/status'
  autoload :Syntax,              'ver/syntax'
  autoload :Text,                'ver/text'
  autoload :Textpow,             'ver/textpow'
  autoload :Theme,               'ver/theme'
  autoload :View,                'ver/view'

  # poor man's option system
  # p Tk::Tile.themes # a list of available themes
  #   Linux themes: "classic", "default", "clam", "alt"
  OPTIONS = {
    tk_theme: 'clam',
    keymap: 'vim',
    global_quit: 'Control-q',
  }

  module_function

  class << self
    attr_reader :root, :layout, :status, :paths, :options
  end

  def run(given_options = {})
    @options = OPTIONS.merge(given_options)

    setup
    open_argv || open_welcome
    emergency_bindings

    Tk.mainloop
  end

  def setup
    Thread.abort_on_exception = true

    Tk::Tile.set_theme options[:tk_theme]

    @paths = Set.new
    @root = TkRoot.new
    @layout = Layout.new(@root)
    @layout.strategy = Layout::VerticalTiling
  end

  def open_argv
    ARGV.each{|arg|
      layout.create_view do |view|
        view.open_path(arg)
      end
    }.any?
  end

  def open_welcome
    layout.create_view do |view|
      view.open_path(File.expand_path('../../blueprint/welcome', __FILE__))
    end
  end

  def emergency_bindings
    Tk.bind :all, options[:global_quit], proc{ exit }
  end

  def opened_file(path)
    @paths << path
  end
end
