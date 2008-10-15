require 'fileutils'
require 'tmpdir'
require 'logger'
require 'pp'

begin; require 'rubygems'; rescue LoadError; end
require 'ncurses'

module VER
  LOG_FILE = File.join(Dir.tmpdir, 'ver.log')
  DIR = File.expand_path(File.dirname(__FILE__))
  BLUEPRINT_DIR = File.expand_path(File.join(DIR, '../blueprint'))

  # logfile rotation, 5 files history of 2mb each
  Log = Logger.new(LOG_FILE, 5, (2 << 20))

  $LOAD_PATH.unshift(DIR)

  require 'remix/cursor'
  require 'remix/buffer'

  require 'ver/color'
  require 'ver/keyboard'
  require 'ver/keymap'
  require 'ver/window'
  require 'ver/view'

  module_function

  def start(*args)
    start_ncurses
    catch(:close){ setup(*args) }
  rescue Exception => ex
    Log.error(ex)
  ensure
    stop_ncurses # do this, or the world implodes
  end

  def stop
    stop_ncurses
  end

  def setup(*args)
    main = setup_main(*args)
    status = setup_status
    status.show(main.status_line)
    main.draw

    Keyboard.focus(main)
    Keyboard.poll
  end

  def setup_main(*files)
    height = Ncurses.stdscr.getmaxy - 1
    width  = Ncurses.stdscr.getmaxx
    top    = 0
    left   = 0

    window = Window.new(height, width, top, left)
    main = MainView.new(:main, window)

    main.buffer = File.join(BLUEPRINT_DIR, 'scratch') if files.empty?
    files.each{|f| main.buffer = f }

    return main
  end

  def setup_status
    height = 1
    width  = Ncurses.stdscr.getmaxx
    top    = Ncurses.stdscr.getmaxy - 1
    left   = 0

    window = Window.new(height, width, top, left)
    buffer = Remix::MemoryBuffer.new(:status)
    StatusView.new(:status, window, buffer)
  end

  def start_ncurses
    Log.info " START ".center(30, "=")
    stdscr = Ncurses.initscr
    Ncurses.keypad(stdscr, true) # see man keypad, makes escape sequences easy
    Ncurses.nonl                 # don't translate newlines on in/output (faster)
    Ncurses.raw
    Ncurses.use_default_colors
    Ncurses.start_color   # FIXME: care about color
    Ncurses.cbreak        # all input is directly passed to us
    Ncurses.noecho        # don't show typed characters
    Ncurses.curs_set(1)   # 0 = invisible, 1 = normal, 2 = very visible
    Ncurses::halfdelay(1) # return after every character or after timeout
  end

  def stop_ncurses
    Log.info " STOP ".center(30, "=")
    Ncurses.echo
    Ncurses.nocbreak
    Ncurses.nl
    Ncurses.endwin
  end
end
