# Well begun is half done.
#             -- Aristotle

# lazy stdlib
autoload :Benchmark, 'benchmark'
autoload :FileUtils, 'fileutils'

# 3rd party
require 'eventmachine'

# eager stdlib
require 'digest/sha1'
require 'json'
# require 'pp'
require 'securerandom'
require 'set'

module VER
  autoload :Entry,               'ver/entry'
  autoload :Font,                'ver/font'
  autoload :HoverCompletion,     'ver/hover_completion'
  autoload :Keymap,              'ver/keymap'
  autoload :Layout,              'ver/layout'
  autoload :Methods,             'ver/methods'
  autoload :Mode,                'ver/mode'
  autoload :Status,              'ver/status'
  autoload :Syntax,              'ver/syntax'
  autoload :Text,                'ver/text'
  autoload :Textpow,             'ver/vendor/textpow'
  autoload :Levenshtein,         'ver/vendor/levenshtein'
  autoload :Theme,               'ver/theme'
  autoload :View,                'ver/view'

  home_conf_dir = Pathname('~/.config/ver').expand_path
  core_conf_dir = Pathname(File.expand_path('../../config/', __FILE__))

  # poor man's option system
  # p Tk::Tile.themes # a list of available themes
  #   Linux themes: "classic", "default", "clam", "alt"
  OPTIONS = {
    font_size:     10,
    font_family:   'TkFixedFont',
    encoding:      'UTF-8:UTF-8',
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
    attr_reader :root, :layout, :status, :paths, :options
  end

  module_function

  def loadpath
    options[:loadpath]
  end

  def run(given_options = {})
    @options = OPTIONS.merge(given_options)

    EM.run do
      EM.defer do
        first_startup unless options[:home_conf_dir].directory?
        setup_tk
        load 'rc'
        sanitize_options
        setup_widgets
        open_argv || open_welcome
        emergency_bindings
        Tk.mainloop
      end
    end
  rescue => exception
    VER.error(exception)
    exit
  end

  def setup_tk
    require 'ffi-tk'
    Thread.abort_on_exception = true
  end

  def setup_widgets
    Tk::Tile.set_theme options[:tk_theme]

    @paths = Set.new
    @root = Tk.root
    @root.wm_geometry = '160x80'
    @layout = Layout.new(@root)
    @layout.strategy = Layout::VerticalTiling
    @status = Entry.new(@root, font: options[:font])
    @status.insert :end, 'For information about VER, type F1'
    @status.pack(fill: :x)
  end

  def sanitize_options
    font, family, size = options.values_at(:font, :font_family, :font_size)
    options[:font] = Font[family: family, size: size] unless font.is_a?(Tk::Font)

    tabs = options[:font].measure('0') * (options[:tab_expand] || 2)
    options[:tabs] = tabs

    encoding = options[:encoding]
    unless encoding.is_a?(Encoding)
      external, internal = encoding.to_s.split(':', 2)

      Encoding.default_external = Encoding.find(external) if external
      Encoding.default_internal = Encoding.find(internal) if internal
    end

    tk_theme = options[:tk_theme]
    options[:theme] = 'default' unless Tk::Tile::Style.theme_names.include?(tk_theme)

    letter = /[\w\n.-]/
    space = /[^\w.-]/

    # make sure Tcl already has the vars set
    Tk.interp.eval('catch {tcl_endOfWord}')
    Tk.execute('set', 'tcl_wordchars', letter)
    Tk.execute('set', 'tcl_nonwordchars', space)
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
    @status.value = exception.message
    $stderr.puts("#{exception.class}: #{exception}", *exception.backtrace)
  rescue Errno::EIO
    # The original terminal has disappeared, the $stderr pipe was closed on the
    # other side.
    [$stderr, $stdout, $stdin].each(&:close)
  rescue IOError
    # Our pipes are closed, maybe put some output to a file logger here, or display
    # in a nicer way, maybe let it bubble up to Tk handling.
  end
end
