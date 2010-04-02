# Man must shape his tools lest they shape him.
#               -- Arthur R. Miller

# lazy stdlib
autoload :Benchmark, 'benchmark'
autoload :FileUtils, 'fileutils'
autoload :Tempfile,  'tempfile'

# eager stdlib
require 'digest/sha1'
require 'forwardable'
require 'logger'
require 'securerandom'
require 'set'
require 'tmpdir'

# vendor stuff, extensions and fixes.
require 'ver/vendor/better_pp_hash'
require 'ver/vendor/pathname'
require 'ver/vendor/sized_array'
require 'ver/vendor/json_store'

# 3rd party dependencies
require 'ffi'

# Small helper method that equivalent to Kernel#p but writes to log.
# Please use this for debugging, log is at /tmp/ver/log/all.log.
#
# Returns the arguments given just like Kernel#p.
#
# Logger takes care of calling #inspect on everything that's not a String.
# We use debug level for this.
def l(arg = nil, *args)
  if args.empty?
    VER.log.debug(arg)
    arg
  else
    VER.log.debug(arg, *args)
    [arg, *args]
  end
end

# This is the doc for VER
module VER
  autoload :Action,              'ver/action'
  autoload :Bookmarks,           'ver/methods/bookmark'
  autoload :Buffer,              'ver/buffer'
  autoload :Clipboard,           'ver/clipboard'
  autoload :Entry,               'ver/entry'
  autoload :EvalCompleter,       'ver/vendor/eval_completer'
  autoload :Event,               'ver/event'
  autoload :ExceptionView,       'ver/exception_view'
  autoload :Executor,            'ver/executor'
  autoload :Font,                'ver/font'
  autoload :Help,                'ver/help'
  autoload :HoverCompletion,     'ver/hover_completion'
  autoload :Keymap,              'ver/keymap'
  autoload :Keymapped,           'ver/keymap/keymapped'
  autoload :Levenshtein,         'ver/vendor/levenshtein'
  autoload :Methods,             'ver/methods'
  autoload :MiniBuffer,          'ver/minibuffer'
  autoload :ModeResolving,       'ver/mode_resolving'
  autoload :NotebookLayout,      'ver/layout/notebook'
  autoload :PanedLayout,         'ver/layout/paned'
  autoload :Platform,            'ver/platform'
  autoload :Register,            'ver/register'
  autoload :RegisterList,        'ver/register'
  autoload :Status,              'ver/status'
  autoload :Struct,              'ver/struct'
  autoload :Syntax,              'ver/syntax'
  autoload :Text,                'ver/text'
  autoload :Textpow,             'ver/vendor/textpow'
  autoload :Theme,               'ver/theme'
  autoload :TilingLayout,        'ver/layout/tiling'
  autoload :ToplevelLayout,      'ver/layout/toplevel'
  autoload :Treeview,            'ver/treeview'
  autoload :Undo,                'ver/undo'
  autoload :WidgetEvent,         'ver/widget_event'
  autoload :WidgetMajorMode,     'ver/widget_major_mode'

  require 'ver/major_mode'
  require 'ver/minor_mode'
  require 'ver/options'

  @options = Options.new(:ver)

  class << self
    attr_reader(:ctag_stack, :keymap, :style_name_pools, :style_name_register,
                :bookmarks, :buffers, :layout, :options, :paths, :root, :status,
                :minibuf)
    attr_accessor :layout_class, :log
  end

  # the rest of the options are in config/rc.rb
  options.dsl do
    o "Fork off on startup to avoid dying with the terminal",
      :fork, Platform.unix?

    o "Start hidden, useful for specs",
      :hidden, false

    o "Use EventMachine inside VER, at the moment only for the console",
      :eventmachine, false

    o "Internal:External encoding",
      :encoding, "UTF-8:UTF-8"

    o "Keymap used",
      :keymap, 'vim'

    o "Load personal rc.rb",
      :load_rc, true

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

    o "Name under which the session is stored (nil means to keep no session)",
      :session, nil

    o "Open welcome file on startup without parameters",
      :welcome, true
  end

  module_function

  def loadpath
    options.loadpath
  end

  def run(given_options = {}, &block)
    # we fork, redirect all output to log files.
    log_dir = Pathname.tmpdir/'ver/log'
    log_dir.mkpath

    self.log = Logger.new(log_dir/'all.log', 10, 1 << 20)

    touch
    setup_tk
    run_startup(given_options)
    pp options if $DEBUG

    run_maybe_forking do
      Event.load!
      options.eventmachine ? run_em(&block) : run_noem(&block)
    end
  rescue => exception
    error(exception)
    exit
  end

  def run_maybe_forking(&block)
    return yield unless options.fork

    fork do
      [$stdout, $stderr].each{|io| io.reopen('/dev/null') }
      trap(:HUP){ l('terminal lost') }
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
    @repeat_blocks = {}
    @load_plugins = Set.new
    @exception_view = nil
    @bookmarks = Bookmarks.new
    @ctag_stack = []
    @style_name_register = []
    @style_name_pools = {}
    @buffers = Set.new

    if given_options[:load_rc] != false
      load 'rc'
    else
      require(options.core_conf_dir/'rc')
    end
    @options.merge!(given_options)
  end

  def run_core
    sanitize_options
    setup_widgets
    open_argv || open_welcome
    open_session
    emergency_bindings
    load_plugins
    run_startup_hooks
  end

  def when_inactive_for(ms, repetitions = 1)
    block = lambda{
      if @cancel_blocks[block]
        @cancel_blocks.delete(block)
      else
        if inactive > ms
          if @repeat_blocks[block] < repetitions
            @repeat_blocks[block] += 1
            yield
            Tk::After.ms(ms, &block)
          else
            Tk::After.ms(ms, &block)
          end
        else
          @repeat_blocks[block] = 0
          Tk::After.ms(ms, &block)
        end
      end
    }

    @cancel_blocks[block] = false
    @repeat_blocks[block] = 0
    Tk::After.idle(&block)
    block
  end

  def touch
    @mtime = Time.now
  end

  def inactive
    (Time.now - @mtime) * 1000
  end

  def defer
    Tk::After.idle do
      begin
        yield
      rescue Exception => ex
        error(ex)
      end
    end
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
      Tk::Event.generate(root, '<<PluginLoaded>>', data: plugin.to_s)
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
    Tk::Tile::Style.configure('Label', font: options.font, sticky: :sw)

    @root = Tk.root
    setup_layout
    load("keymap/#{options.keymap}.rb")
    @minibuf = MiniBuffer.new(@root)
    @minibuf.pack expand: true, fill: :both

    # [:Messages, :Scratch, :Completions].each do |name|
    #   Buffer[name].hide
    # end
  end

  def setup_layout
    @layout = (layout_class || ToplevelLayout).new(root)
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
    store_session
    @cancel_blocks.keys.each{|key| @cancel_blocks[key] = true }
    Tk.exit
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
    openend_any = false

    while arg = argv.shift
      if argv.first =~ /\+\d+/
        line = argv.shift.to_i
        find_or_create_buffer(arg, line)
      else
        find_or_create_buffer(arg)
      end

      opened_any = true
    end

    opened_any
  end

  def open_welcome
    return unless options.welcome
    if welcome = find_in_loadpath('welcome')
      find_or_create_buffer(welcome)
      true
    end
  end

  def open_session
    return unless session_base = options.session
    basename = "sessions/#{session_base}.json"
    return unless file = find_in_loadpath(basename)

    JSON::Store.new(file, true).transaction do |session|
      session['bookmarks'].each do |raw_bm|
        bm = Bookmarks::Bookmark.new
        bm.name  = raw_bm['name']
        bm.file  = Pathname(raw_bm['file'])
        bm.index = raw_bm['index']
        l "Loaded %p" % [bm]
        bookmarks << bm
      end

      session['buffers'].each do |buffer|
        l "Loading Buffer: %p" % [buffer]
        find_or_create_buffer(buffer['filename'], *buffer['insert'])
      end
    end
  end

  # FIXME: there are no buffers anymore when this is called.
  def store_session
    return unless session_base = VER.options.session
    basename = "sessions/#{session_base}.json"
    session_path = loadpath.first/basename
    session_path.parent.mkpath

    JSON::Store.new(session_path.to_s, true).transaction do |session|
      buffers = self.buffers.map do |buffer|
        l buffer: buffer
        { 'name'     => buffer.name.to_s,
          'filename' => buffer.filename.to_s,
          'insert'   => buffer.at_insert.to_a, }
      end
      l "Storing Buffers: %p" % [buffers]
      session['buffers'] = buffers

      bookmarks = self.bookmarks.map do |bm|
        l bookmark: bm
        { 'name'  => bm.name,
          'file'  => bm.file.to_s,
          'index' => bm.index, }
      end
      l "Storing Bookmarks: %p" % [bookmarks]
      session['bookmarks'] = bookmarks
    end
  end

  def find_or_create_buffer(file, line = nil, column = nil, &block)
    buffer = Buffer.find_or_create(file, line, column, &block)
    buffer.show
    buffer
  end

  def emergency_bindings
    Tk::Bind.bind(:all, options.emergency_exit){ exit }
  end

  def opened_file(text)
    @paths << text.filename
  end

  def message(*args)
    minibuf.message(*args)
  end

  def warn(*args)
    minibuf.warn(*args)
  end

  def obtain_style_name(widget_name, widget_class)
    suffix = "#{widget_name}.#{widget_class}"
    pool = style_name_pools[suffix] ||= []
    register = style_name_register

    unless name = pool.shift
      begin
        id = SecureRandom.hex
        name = "#{id}.#{suffix}"
      end while register.include?(name)

      register << name
    end

    return name
  end

  def return_style_name(style_name)
    return unless style_name
    id, widget_name, widget_class = style_name.split('.')
    suffix = "#{widget_name}.#{widget_class}"
    style_name_pools[suffix] << style_name
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

  # low-level information for developers
  def debug(*args)
    log.debug(*args)
    p(*args)
  end

  # generic (useful) information about system operation
  def info(*args)
    log.info(*args)
    p(:info, *args)
  end

  # a warning
  def warn(*args)
    log.warn(*args)
    p(:warn, *args)
  end

  # a handleable error condition
  def error(*args)
    log.error(*args)
    if args.size == 1
      arg = args.first
      case arg
      when Exception
        puts "#{arg.class}: #{arg}", *arg.backtrace
      else
        p(:error, *args)
      end
    else
      p(:error, *args)
    end
  end

  # an unhandleable error that results in a program crash
  def fatal(*args)
    log.fatal(*args)
    p(:fatal, *args)
  end
end
