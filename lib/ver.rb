# Man must shape his tools lest they shape him.
#               -- Arthur R. Miller

# lazy stdlib
autoload :Benchmark, 'benchmark'
autoload :FileUtils, 'fileutils'
autoload :Tempfile,  'tempfile'

# eager stdlib
require 'digest/sha1'
# require 'json'
require 'pp'
require 'securerandom'
require 'set'
require 'pathname'

autoload :SizedArray, 'ver/vendor/sized_array'

module VER
  autoload :Entry,               'ver/entry'
  autoload :Executor,            'ver/executor'
  autoload :Help,                'ver/help'
  autoload :Font,                'ver/font'
  autoload :HoverCompletion,     'ver/hover_completion'
  autoload :Keymap,              'ver/keymap'
  autoload :TilingLayout,        'ver/layout/tiling'
  autoload :NotebookLayout,      'ver/layout/notebook'
  autoload :Methods,             'ver/methods'
  autoload :Mode,                'ver/mode'
  autoload :Status,              'ver/status'
  autoload :Syntax,              'ver/syntax'
  autoload :Text,                'ver/text'
  autoload :Textpow,             'ver/vendor/textpow'
  autoload :Levenshtein,         'ver/vendor/levenshtein'
  autoload :Theme,               'ver/theme'
  autoload :View,                'ver/view'
  autoload :ExceptionView,       'ver/exception_view'
  autoload :Bookmarks,           'ver/methods/bookmark'
  autoload :Undo,                'ver/undo'
  autoload :Keymapped,           'ver/keymap'

  require 'ver/options'
  @options = Options.new(:ver)

  class << self
    attr_reader(:root, :layout, :status, :paths, :options, :bookmarks,
                :ctag_stack, :keymap, :style_name_register, :style_name_pool)
    attr_accessor :layout_class
  end

  # the rest of the options are in config/rc.rb
  options.dsl do
    o "Fork off on startup to avoid dying with the terminal",
      :fork, true

    o "Use EventMachine inside VER, at the moment only for the console",
      :eventmachine, false

    o "Internal:External encoding",
      :encoding, "UTF-8:UTF-8"

    o "Keymap used",
      :keymap, 'vim'

    o "Width of one tab in pixel",
      :tabs, 10

    o "Minimum size of search term to start incremental highlighting",
      :search_incremental_min, 1

    o "Location of personal configuration",
      :home_conf_dir,  Pathname('~/.config/ver').expand_path

    o "Location of system-wide configuration",
      :core_conf_dir, Pathname(File.expand_path('../../config/', __FILE__))

    o "Locations where we look for configuration",
      :loadpath, [home_conf_dir, core_conf_dir]
  end

  module_function

  def loadpath
    options.loadpath
  end

  def run(given_options = {}, &block)
    setup_tk
    run_startup(given_options)
    pp options if $DEBUG

    run_maybe_forking do
      options.eventmachine ? run_em(&block) : run_noem(&block)
    end
  rescue => exception
    VER.error(exception)
    exit
  end

  def run_maybe_forking(&block)
    return yield unless options.fork

    fork do
      trap(:HUP){ 'terminal disconnected' }
      yield
    end
  end

  def run_em(&block)
    require 'eventmachine'

    EM.run do
      if Tk::RUN_EVENTLOOP_ON_MAIN_THREAD
        run_core
        EM.defer(&block) if block
        Tk.mainloop
      else
        EM.defer do
          run_core
          EM.defer(&block) if block
          Tk.mainloop
        end
      end
    end
  end

  def run_noem(&block)
    run_core
    yield if block
    Tk.mainloop
  end

  def run_startup(given_options)
    first_startup unless options.home_conf_dir.directory?

    @startup_hooks = []
    @paths = Set.new
    @cancel_blocks = {}
    @load_plugins = Set.new
    @exception_view = nil
    @bookmarks = Bookmarks.new
    @ctag_stack = []
    @style_name_register = []
    @style_name_pool = []

    load 'rc'
    @options.merge!(given_options)
  end

  def run_core
    sanitize_options
    # dump_options
    setup_widgets
    open_argv || open_welcome
    emergency_bindings
    load_plugins
    run_startup_hooks
  end

  def when_inactive_for(ms)
    block = lambda{
      inactive = Tk.root.tk_inactive

      if @cancel_blocks[block]
        @cancel_blocks.delete(block)
      else
        if inactive > ms
          yield
          Tk.root.tk_inactive('reset')
          Tk::After.ms(ms, &block)
        else
          Tk::After.ms(ms, &block)
        end
      end
    }

    @cancel_blocks[block] = false
    Tk::After.idle(&block)
    block
  end

  def cancel_block(block)
    @cancel_blocks[block] = true
  end

  def run_startup_hooks
    @startup_hooks.each(&:call)
  end

  def startup_hook(&block)
    @startup_hooks << block
  end

  def plugin(name)
    @load_plugins << name.to_s
  end

  def load_plugins
    @load_plugins.each do |plugin|
      load_plugin(plugin)
    end
  end

  def load_plugin(name)
    loadpath.each do |dirname|
      (dirname/"plugin/#{name}.rb").glob do |rb|
        return require(rb.to_s)
      end
    end
  rescue => ex
    error(ex)
  end

  def load_all_plugins
    loadpath.each do |dirname|
      (dirname/'plugin/*.rb').glob do |rb|
        require rb
      end
    end
  rescue => ex
    error(ex)
  end

  def setup_tk
    require 'ffi-tk'
    Thread.abort_on_exception = true
  end

  def setup_widgets
    Tk::Tile.set_theme options.tk_theme

    @root = Tk.root
    @root.wm_geometry = '160x80'

    Tk::Tile::Style.configure('Label', font: options.font, sticky: :sw)
    # Tk::Tile::Style.configure('TLabelframe', background: '#f00')

    setup_layout

    @keymap = Keymap.load(options.keymap)
  end

  def setup_layout
    @layout = (layout_class || TilingLayout).new(root)
    @layout.configure(
      text: 'Welcome to VER, exit by pressing Control-q',
      labelanchor: :sw
    )
  end

  def sanitize_options
    font = options.font

    unless font.respond_to?(:measure)
      font = Tk::Font.new(font)
      actual_hash = font.actual_hash
      options.font = Font.cache[actual_hash] = font
    end

    tabs = font.measure('0') * options.tabstop
    options.tabs = tabs

    encoding = options[:encoding]
    unless encoding.is_a?(Encoding)
      external, internal = encoding.to_s.split(':', 2)

      Encoding.default_external = Encoding.find(external) if external
      Encoding.default_internal = Encoding.find(internal) if internal
    end

    # We supply a reasonable default in case the platform doesn't have the theme
    # wished for.
    unless Tk::Tile::Style.theme_names.include?(options.tk_theme)
      options.tk_theme = 'default'
    end

    letter = /[\w\n.-]/
    space = /[^\w.-]/

    # make sure Tcl already has the vars set
    Tk.interp.eval('catch {tcl_endOfWord}')
    Tk.execute('set', 'tcl_wordchars', letter)
    Tk.execute('set', 'tcl_nonwordchars', space)
  end

  def first_startup
    home, core = options.home_conf_dir, options.core_conf_dir
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
    Tk::Bind.bind(:all, options.emergency_exit){ exit }
  end

  def opened_file(text)
    @paths << text.filename
  end

  def message(string)
    @layout.configure text: string
  end

  def obtain_style_name(widget_name, widget_class)
    unless style_name = style_name_pool.shift
      begin
        id = SecureRandom.hex
        style_name = "#{id}.#{widget_name}.#{widget_class}"
      end while style_name_register.include?(style_name)
      style_name_register << style_name
    end

    style_name
  end

  def return_style_name(style_name)
    style_name_pool << style_name
  end

  def dump_options
    out = []

    options.each_pair do |key, value|
      out << [key,
        case value
        when Tk::Font
          "VER::Font[%p]" % [value.actual_hash]
        when Pathname
          value.to_s
        else
          value
        end
        ]
    end

    out.each do |pair|
      puts("VER.options.%s = %p" % pair)
    end
  end

  def error(exception)
    @status.value = exception.message if @status
    exception_view(exception) if @root
    $stderr.puts("#{exception.class}: #{exception}", *exception.backtrace)
  rescue Errno::EIO
    # The original terminal has disappeared, the $stderr pipe was closed on the
    # other side.
    [$stderr, $stdout, $stdin].each(&:close)
  rescue IOError
    # Our pipes are closed, maybe put some output to a file logger here, or display
    # in a nicer way, maybe let it bubble up to Tk handling.
  end

  def exception_view(exception)
    unless @exception_view
      @exception_view ||= ExceptionView.new(@root)

      @exception_view.bind '<<TreeviewOpen>>' do
        @exception_view.on_treeview_open
      end

      @exception_view.bind '<Escape>' do
        @exception_view.pack_forget
        @layout.views.first.focus
      end
    end

    @exception_view.show(exception)
  end
end
