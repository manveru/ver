module VER
  class Editor
    def self.start(client)
      new client
    end

    def initialize(client)
      @client = client

      start_curses
      start_frames
      start_keyboard
    ensure
      stop_curses
    end

    def start_curses
      Curses.init_screen
      Curses.nonl
      Curses.cbreak
      Curses.raw
      Curses.noecho
    end

    def stop_curses
      Curses.close_screen
    end

    def start_keyboard
      @keyboard = Keyboard.new(@view)
      @keyboard.poll
    end

    def start_frames
      @status = Frame::Status.new
      @view   = Frame::View.new

      @view.update
      @status.update(@view)
    end
  end
end
