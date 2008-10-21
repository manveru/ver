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

  require 'ver/log'
  require 'ver/messaging'
  require 'ver/ncurses'
  require 'ver/layout'

  require 'ver/buffer'
  require 'ver/buffer/line'
  require 'ver/buffer/memory'
  require 'ver/buffer/file'

  require 'ver/error'
  require 'ver/keyboard'
  require 'ver/keymap'
  require 'ver/action'
  require 'ver/window'
  require 'ver/cursor'
  require 'ver/color'
  require 'ver/config'
  require 'ver/clipboard'
  require 'ver/mixer'

  require 'ver/view'
  require 'ver/view/main'
  require 'ver/view/status'
  require 'ver/view/ask'
  require 'ver/view/help'

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
    ask_view    = setup_ask    # for asking questions
    status_view = setup_status # status of current buffer
    info_view   = setup_info   # info about what's going on
    help_view   = setup_help   # show help
    main_view   = setup_main(*args)

    info_view.show "VER 2008.10.16  F1 for help  F12 to configure  C-q to quit"

    main_view.activate
  end

  def clipboard
    @clipboard ||= ClipBoard.new
  end
end
