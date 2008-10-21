module VER
  module_function

  def setup_main(*files)
    window = Window.new{ {
      :height => Ncurses.stdscr.getmaxy - 2,
      :width  => Ncurses.stdscr.getmaxx,
      :top    => 0,
      :left   => 0 }
    }

    main = MainView.new(:main, window)

    main.buffer = File.join(Config[:blueprint_dir], 'welcome') if files.empty?
    files.each{|f| main.buffer = f }
    View.active = main

    return main
  end

  def setup_status
    window = Window.new{ {
      :height => 1,
      :width  => Ncurses.stdscr.getmaxx,
      :top    => Ncurses.stdscr.getmaxy - 2,
      :left   => 0 }
    }

    buffer = MemoryBuffer.new(:status)
    StatusView.new(:status, window, buffer)
  end

  def setup_info
    window = Window.new{ {
      :height => 10,
      :width  => Ncurses.stdscr.getmaxx,
      :top    => Ncurses.stdscr.getmaxy - 1,
      :left   => 0 }
    }

    buffer = MemoryBuffer.new(:info)
    StatusView.new(:info, window, buffer)
  end

  def setup_ask
    window = Window.new{ {
      :height => 2,
      :width  => Ncurses.stdscr.getmaxx,
      :top    => Ncurses.stdscr.getmaxy - 2,
      :left   => 0 }
    }

    buffer = MemoryBuffer.new(:ask)
    window.hide
    AskView.new(:ask, window, buffer)
  end

  def setup_help
    window = Window.new{ {
      :height => Ncurses.stdscr.getmaxy - 2,
      :width  => Ncurses.stdscr.getmaxx,
      :top    => 0,
      :left   => 0 }
    }

    buffer = MemoryBuffer.new(:help)
    HelpView.new(:help, window, buffer)
  end
end
