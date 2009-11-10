# Well begun is half done.
#             -- Aristotle

# TODO: remove before release
$LOAD_PATH.unshift File.expand_path('../', __FILE__)

# lazy stdlib
autoload :Benchmark, 'benchmark'
autoload :FileUtils, 'fileutils'

# 3rd party
# require 'eventmachine'

# eager stdlib
require 'digest/sha1'
require 'json'
require 'pathname'
# require 'pp'
require 'securerandom'
require 'set'


# annoying fixes
class Pathname
  alias / join

  def cp(dest)
    FileUtils.copy_file(expand_path.to_s, dest.to_s, preserve = true)
  end

  def =~(regexp)
    to_s =~ regexp
  end
end

# FIXME: remove when eventmachine 0.12.9 comes out.
class Thread
  alias kill! kill unless current.respond_to?(:kill!)
end

module VER
  autoload :BufferListView,      'ver/view/buffer_list_view'
  autoload :Entry,               'ver/entry'
  autoload :Font,                'ver/font'
  autoload :FuzzyFileFinderView, 'ver/view/fuzzy_file_finder_view'
  autoload :HoverCompletion,     'ver/hover_completion'
  autoload :Keymap,              'ver/keymap'
  autoload :Layout,              'ver/layout'
  autoload :ListView,            'ver/view/list_view'
  autoload :Methods,             'ver/methods'
  autoload :Mode,                'ver/mode'
  autoload :Status,              'ver/status'
  autoload :Syntax,              'ver/syntax'
  autoload :SyntaxListView,      'ver/view/syntax_list_view'
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
    font_size:     10,
    font_family:   'TkFixedFont',
    encoding:      Encoding::UTF_8,
    tk_theme:      'clam',
    theme:         'Blackboard',
    keymap:        'vim',
    tab_expand:    2,
    global_quit:   'Control-q',
    home_conf_dir: home_conf_dir,
    core_conf_dir: core_conf_dir,
    loadpath:      [home_conf_dir, core_conf_dir],
  }

  class << self
    attr_reader :root, :layout, :paths, :options
  end

  module_function

  def loadpath
    options[:loadpath]
  end

  def run(given_options = {})
    @options = OPTIONS.merge(given_options)

    # EM.run do
      first_startup unless options[:home_conf_dir].directory?
      setup_tk
      load 'rc'
      sanitize_options
      setup
      open_argv || open_welcome
      emergency_bindings
      FFI::Tk.mainloop
    # end
  rescue => exception
    VER.error(exception)
    exit
  end

  def setup_tk
    require 'ffi-tk'
    Thread.abort_on_exception = true
    # TclTkLib.mainloop_abort_on_exception = true
  end

  def setup
    Tk::Tile.set_theme options[:tk_theme]

    @paths = Set.new
    @root = Tk.root
    @root.wm_geometry = '160x80'
    @layout = Layout.new(@root)
    @layout.strategy = Layout::VerticalTiling
  end

  def sanitize_options
    font, family, size = options.values_at(:font, :font_family, :font_size)
    options[:font] = Font[family: family, size: size] unless font.is_a?(Tk::Font)

    tabs = options[:font].measure('0') * (options[:tab_expand] || 2)
    options[:tabs] = tabs

    encoding = options[:encoding]
    options[:encoding] = Encoding.find(encoding) unless encoding.is_a?(Encoding)

    tk_theme = options[:tk_theme]
    options[:theme] = 'default' unless Tk::Tile::Style.theme_names.include?(tk_theme)
  end

  def first_startup
    home, core = options.values_at(:home_conf_dir, :core_conf_dir)
    home.mkpath

    (core/'rc.rb').cp(home/'rc.rb')
    (core/'scratch').cp(home/'scratch')
    (core/'tutorial').cp(home/'tutorial')
    (core/'welcome').cp(home/'welcome')
  end

  def exit
    Tk.exit rescue nil
    EM.stop rescue nil
    Kernel.exit
  end

  def load(name)
    loadpath.each do |path|
      file = File.join(path, name)

      begin
        require(file)
        return
      rescue LoadError, TypeError => ex
        # TypeError happens on JRuby sometimes...
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
    argv = ARGV.dup
    any = false

    while arg = argv.shift
      layout.create_view do |view|
        if argv.first =~ /\+\d+/
          line = argv.shift.to_i
          view.open_path(arg, line)
        else
          view.open_path(arg)
        end

        any = true
      end
    end

    any
  end

  def open_welcome
    layout.create_view do |view|
      welcome = find_in_loadpath('welcome')
      view.open_path(welcome)
    end
  end

  def emergency_bindings
    Tk::Bind.bind(:all, options[:global_quit]){ exit }
  end

  def opened_file(text)
    @paths << text.filename
  end

  def error(exception)
    $stderr.puts "#{exception.class}: #{exception}"
    $stderr.puts *exception.backtrace
  rescue Errno::EIO
    # The original terminal has disappeared, the $stderr pipe was closed on the
    # other side.
    [$stderr, $stdout, $stdin].each(&:close)
  rescue IOError
    # Our pipes are closed, maybe put some output to a file logger here, or display
    # in a nicer way, maybe let it bubble up to Tk handling.
  end
end
