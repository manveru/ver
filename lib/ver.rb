require 'abbrev'
require 'fileutils'
require 'logger'
require 'pp'
require 'open3'
require 'strscan'
require 'tmpdir'

begin; require 'rubygems'; rescue LoadError; end
require 'ffi-ncurses'
require 'eventmachine'

module VER
  VERSION = "2008.10.30"

  DIR = File.expand_path(File.dirname(__FILE__))
  FatalLog = Logger.new(File.join(Dir.tmpdir, 'ver-fatal.log'), 5, (2 << 20))

  $LOAD_PATH.unshift(DIR)

  require 'vendor/silence'
  require 'vendor/fuzzy_file_finder'

  require 'ver/log'
  require 'ver/messaging'
  require 'ver/ncurses'
  require 'ver/ncurses/window'
  require 'ver/ncurses/panel'

  require 'ver/buffer'
  require 'ver/buffer/line'
  require 'ver/buffer/memory'
  require 'ver/buffer/file'

  require 'ver/error'
  require 'ver/keyboard'
  require 'ver/keymap'
  require 'ver/mixer'
  require 'ver/window'
  require 'ver/cursor'
  require 'ver/color'
  require 'ver/config'
  require 'ver/clipboard'
  require 'ver/clipboard/xclip'
  require 'ver/syntax'

  require 'ver/view'
  require 'ver/view/file'
  require 'ver/view/info'
  require 'ver/view/ask/small'
  require 'ver/view/ask/large'
  require 'ver/view/ask/file'
  require 'ver/view/ask/fuzzy_file'
  require 'ver/view/ask/grep'
  require 'ver/view/ask/choice'
  require 'ver/view/ask/complete'

  module_function

  def start(context = {})
    @last_error = nil
    start_config

    Log.info "Initializing VER"

    EM.run do
      start_ncurses
      start_editor(context)
    end
  ensure
    stop_ncurses # do this, or the world implodes
  end

  def start_editor(context)
    EM.error_handler{|ex| error(ex) }
    setup(context)
  rescue ::Exception => ex
    error(ex)
  end

  def stop
    @stop = true
    stop_ncurses
    exit!
  end

  def stopping?
    @stop
  end

  def setup(context)
    @ask      = View::AskSmall.new(:ask)
    @info     = View::Info.new(:info)
    @choice   = View::AskChoice.new(:ask_choice)
    @complete = View::Complete.new(:complete)

    @file = View::File.new(:file)
    setup_context(context)

    VER.info "VER #{VERSION} -- C-q to quit"

    @info.open
    @file.open
  end

  def setup_context(context = {})
    files, temp = context.values_at(:files, :temp)

    if files
      if files.empty?
        @file.buffer = File.join(Config[:blueprint_dir], 'welcome')
      else
        files.each do |hash|
          @file.buffer = hash[:file]

          if line = hash[:line]
            @file.methods.goto_line(line)
          elsif regex = hash[:regex]
            @file.search = regex
            @file.buffer.dirty = true
            @file.methods.search_next
          end
        end
      end
    elsif temp
      @file.buffer = MemoryBuffer.new(:file, temp)
    end
  end

  def clipboard
    @clipboard ||= ClipBoard.new
  end

  def bench(name, &block)
    Log.debug "let bench: #{name}"

    require 'ruby-prof'

    # Profile the code
    result = RubyProf.profile(&block)

    # Print a graph profile to text
    printer = RubyProf::GraphHtmlPrinter.new(result)

    File.open('bench.html', 'w+'){|io| printer.print(io, :min_percent => 0) }

    Log.debug "end bench: #{name}"
  end
end
