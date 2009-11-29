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
  autoload :Help,                'ver/help'
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

  require 'ver/options'
  @options = Options.new(:ver)

  class << self
    attr_reader :root, :layout, :status, :paths, :options
  end

  options.dsl do
    o "Default Font for all widgets",
      :font, "TkFixedFont 10"

    o "Internal:External encoding",
      :encoding, "UTF-8:UTF-8"

    o "Tk Tile Theme",
      :tk_theme, 'clam'

    o "Syntax highlighting theme",
      :theme, "Blackboard"

    o "Keymap used",
      :keymap, 'vim'

    o "Expand all tabs into spaces",
      :expandtab, true

    o "Use automatic indentation",
      :autoindent, true

    o "Number of spaces used in autoindent",
      :shiftwidth, 2

    o "Number of spaces a tab stands for",
      :tabstop, 8

    o "Number of characters after which wrap commands will wrap",
      :textwidth, 80

    o "Show vertical scrollbar",
      :vertical_scrollbar, false

    o "Show horizontal scrollbar",
      :horizontal_scrollbar, false

    o "In case of a total failure, this key binding should bail you out",
      :emergency_exit, "<Control-q>"

    o "Fork off on startup to avoid dying with the terminal",
      :fork, true

    o "Milliseconds that the cursor is visible when blinking",
      :insertontime, 500

    o "Milliseconds that the cursor is invisible when blinking",
      :insertofftime, 0

    o "Width of one tab in pixel",
      :tabs, 10

    o "Sequence to comment a line, may change through file type preferences",
      :comment_line, '#'

    o "Start and end sequence to comment a region, may change through file type preferences",
      :comment_region, ['=begin', '=end']

    o "Default filetype if no matching syntax can be found",
      :filetype, "Plain Text"

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

  def run(given_options = {})
    @options.merge!(given_options)

    setup_tk

    if Tk::RUN_EVENTLOOP_ON_MAIN_THREAD
      run_aqua
    else
      run_x11
    end
  rescue => exception
    VER.error(exception)
    exit
  end

  def run_aqua
    run_core
    EM.run{ Tk.mainloop }
  end

  def run_x11
    EM.run do
      EM.defer do
        run_core
        Tk.mainloop
      end
    end
  end

  def run_core
    first_startup unless options.home_conf_dir.directory?
    load 'rc'
    sanitize_options
    setup_widgets
    open_argv || open_welcome
    emergency_bindings
  end

  def setup_tk
    require 'ffi-tk'
    Thread.abort_on_exception = true
  end

  def setup_widgets
    Tk::Tile.set_theme options.tk_theme

    @paths = Set.new
    @root = Tk.root
    @root.wm_geometry = '160x80'
    @layout = Layout.new(@root)
    @layout.strategy = Layout::VerticalTiling
    @status = Entry.new(@root, font: options.font)
    @status.insert :end, 'For information about VER, type F1'
    @status.pack(fill: :x)
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

  def error(exception)
    @status.value = exception.message if @status
    error_tree(exception) if @root
    $stderr.puts("#{exception.class}: #{exception}", *exception.backtrace)
  rescue Errno::EIO
    # The original terminal has disappeared, the $stderr pipe was closed on the
    # other side.
    [$stderr, $stdout, $stdin].each(&:close)
  rescue IOError
    # Our pipes are closed, maybe put some output to a file logger here, or display
    # in a nicer way, maybe let it bubble up to Tk handling.
  end

  def error_tree(exception)
    @tree ||= Tk::Tile::Treeview.new(@root)
    @tree.clear

    @tree.configure(
      columns:        %w[line method],
      displaycolumns: %w[line method]
    )
    @tree.heading('#0',     text: 'File')
    @tree.heading('line',   text: 'Line')
    @tree.heading('method', text: 'Method')
    @tree.tag_configure('error', background: '#f88')
    @tree.tag_configure('backtrace', background: '#8f8')

    context_size = 7
    frames = {}
    error_tags = ['error']
    backtrace_tags = ['backtrace']

    # from Rack::ShowExceptions
    exception.backtrace.each do |line|
      next unless line =~ /(.*?):(\d+)(:in `(.*)')?/
      filename, lineno, function = $1, $2.to_i, $4

      item = @tree.insert(nil, :end,
        text: filename, values: [lineno, function], tags: error_tags)

      begin
        lines = ::File.readlines(filename)
        _lineno = lineno - 1

        first_lineno = [_lineno - context_size, 0].max
        last_lineno  = [_lineno + context_size, lines.size].min
        context = lines[first_lineno..last_lineno]

        frames[item.id] = {
          filename: filename,
          lineno: lineno,
          function: function,
          first_lineno: first_lineno,
          last_lineno: last_lineno,
          context: context,
        }
      rescue => ex
        puts ex, ex.backtrace
      end
    end

    @tree.focus
    @tree.pack expand: true, fill: :both

    @tree.bind('<<TreeviewOpen>>'){|event|
      begin
        item = @tree.focus_item
        frame = frames[item.id]

        case frame
        when Hash
          filename, lineno, first_lineno, context =
            frame.values_at(:filename, :lineno, :first_lineno, :context)

          context.each_with_index{|line, idx|
            line_lineno = first_lineno + idx + 1
            tags = line_lineno == lineno ? error_tags : backtrace_tags
            line_item = item.insert(:end,
              text: line, values: [line_lineno], tags: tags)
            frames[line_item.id] = [filename, lineno]
          }
        when Array
          filename, lineno = frame
          @layout.views.first.find_or_create(filename, lineno){|view|
            @tree.pack_forget
          }
        end
      rescue => ex
        puts ex, ex.backtrace
      end
    }
    @tree.bind('<Escape>'){
      @tree.pack_forget
      @layout.views.first.focus
    }
  end
end
