# Well begun is half done.
#             -- Aristotle

# TODO: remove before release
$LOAD_PATH.unshift File.expand_path('../', __FILE__)

# stdlib
require 'benchmark'
require 'digest/sha1'
require 'fileutils'
require 'json'
require 'pathname'
require 'pp'
require 'securerandom'
require 'set'
require 'tmpdir'
require 'tk'

class Pathname
  alias / join

  def cp(dest)
    FileUtils.copy_file(expand_path.to_s, dest.to_s, preserve = true)
  end
end

module VER
  autoload :BufferListView,      'ver/view/buffer_list_view'
  autoload :Entry,               'ver/entry'
  autoload :FuzzyFileFinderView, 'ver/view/fuzzy_file_finder_view'
  autoload :Keymap,              'ver/keymap'
  autoload :Layout,              'ver/layout'
  autoload :ListView,            'ver/view/list_view'
  autoload :Methods,             'ver/methods'
  autoload :Mode,                'ver/mode'
  autoload :Status,              'ver/status'
  autoload :SyntaxListView,       'ver/view/syntax_list_view'
  autoload :Syntax,              'ver/syntax'
  autoload :Text,                'ver/text'
  autoload :Textpow,             'ver/textpow'
  autoload :Theme,               'ver/theme'
  autoload :ThemeListView,       'ver/view/theme_list_view'
  autoload :View,                'ver/view'

  home_conf_dir = Pathname('~/.config/ver').expand_path
  core_conf_dir = Pathname(File.expand_path('../../config/', __FILE__))

  # poor man's option system
  # p Tk::Tile.themes # a list of available themes
  #   Linux themes: "classic", "default", "clam", "alt"
  OPTIONS = {
    font:          TkFont.new(family: 'Terminus', size: 9),
    tk_theme:      'clam',
    theme:         'Blackboard',
    keymap:        'vim',
    global_quit:   'Control-q',
    home_conf_dir: home_conf_dir,
    core_conf_dir: core_conf_dir,
    loadpath:      [home_conf_dir, core_conf_dir],
  }

  class << self
    attr_reader :root, :layout, :status, :paths, :options
  end

  module_function

  def loadpath
    options[:loadpath]
  end

  def run(given_options = {})
    @options = OPTIONS.merge(given_options)

    setup
    first_startup unless options[:home_conf_dir].directory?
    load 'rc'
    open_argv || open_welcome
    emergency_bindings

  rescue => exception
    puts "#{exception.class}: #{exception}", *exception.backtrace
    Tk.exit
  else
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

  def first_startup
    home, core = options.values_at(:home_conf_dir, :core_conf_dir)
    home.mkpath

    (core/'rc.rb').cp(home/'rc.rb')
    (core/'scratch').cp(home/'scratch')
    (core/'tutorial').cp(home/'tutorial')
    (core/'welcome').cp(home/'welcome')
  end

  def load(name)
    loadpath.each do |path|
      file = File.join(path, name)

      begin
        require(file)
        return
      rescue LoadError
      end
    end
  end

  def find_in_loadpath(basename)
    loadpath.each do |dirname|
      file = dirname/basename
      return file if file.file?
    end

    nil
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
      welcome = find_in_loadpath('welcome')
      view.open_path(welcome)
    end
  end

  def emergency_bindings
    Tk.bind :all, options[:global_quit], proc{ exit }
  end

  def opened_file(path)
    root['title'] = "VER: #{path}"
    @paths << path
  end
end
