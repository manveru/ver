require 'abbrev'
require 'fileutils'
require 'logger'
require 'pp'
require 'strscan'
require 'tmpdir'

begin; require 'rubygems'; rescue LoadError; end
require 'ncurses'

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

  module_function

  def start(*args)
    @last_error = nil
    start_config

    Log.info "Initializing VER"

    start_ncurses

    catch(:close){ setup(*args) }
  rescue ::Exception => ex
    error(ex)
  ensure
    stop_ncurses # do this, or the world implodes
  end

  def stop
    @stop = true
    throw(:close)
  end

  def stopping?
    @stop
  end

  def setup(*args)
    @ask    = View::AskSmall.new(:ask)
    @info   = View::Info.new(:info)
    @choice = View::AskChoice.new(:ask_choice)

    @file = View::File.new(:file)
    if args.each{|a| @file.buffer = a }.empty?
      @file.buffer = File.join(Config[:blueprint_dir], 'welcome')
    end

    VER.info "VER #{VERSION} -- F1 for help -- F12 to configure -- C-q to quit"

    @info.open
    @file.open
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
