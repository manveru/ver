require 'fileutils'
require 'abbrev'
require 'tmpdir'
require 'logger'
require 'pp'

begin; require 'rubygems'; rescue LoadError; end
require 'ncurses'

module VER
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
  require 'ver/methods'
  require 'ver/mixer'
  require 'ver/window'
  require 'ver/cursor'
  require 'ver/color'
  require 'ver/config'
  require 'ver/clipboard'

  require 'ver/view'
  require 'ver/view/file'
  require 'ver/view/info'
  require 'ver/view/status'
  require 'ver/view/ask_file'
  require 'ver/view/ask_fuzzy_file'

  module_function

  def start(*args)
    @last_error = nil
    start_config

    Log.debug "Initializing VER"

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
    @info = View::Info.new(:info)
    @status = View::Status.new(:status)

    @file = View::File.new(:file)
    @file.buffer = __FILE__

    VER.info "VER 2008.10.24  F1 for help  F12 to configure  C-q to quit"

    [@info, @status, @file].each do |view|
      view.open
    end
  end

  def foobar
    ask_view    = setup_ask    # for asking questions
    status_view = setup_status # status of current buffer
    info_view   = setup_info   # info about what's going on
    help_view   = setup_help   # show help
    doc_view    = setup_doc
    main_view   = setup_main(*args)

    info_view.show "VER 2008.10.16  F1 for help  F12 to configure  C-q to quit"

    main_view.activate
  end

  def clipboard
    @clipboard ||= ClipBoard.new
  end
end
