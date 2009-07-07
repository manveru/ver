require 'curses'
require 'logger'

module VER
  autoload :Client,   'ver/client'
  autoload :Frame,    'ver/frame'
  autoload :Log,      'ver/log'
  autoload :Protocol, 'ver/protocol'
  autoload :Server,   'ver/server'
  autoload :VERSION,  'ver/version'
  autoload :Keyboard, 'ver/keyboard'
  autoload :Editor,   'ver/editor'
end

__END__

class Edit
  def edit(file)
    start

    screen = Curses.stdscr

    @status = Curses::Window.new(1, 0, screen.maxy - 1, 0)

    @window = Curses::Window.new(screen.maxy - 1, 0, 0, 0)
    @window.scrollok true
    @window.setscrreg(0, @window.maxy)
    @window.idlok true

    @window.setpos(0, 0)

    @lines = File.readlines(file)
    @line = 0

    replace_buffer(@window, @lines)
    show_status
    @window.refresh
    @line = @col = 0

    while command = Keyboard.new.receive(@window)
      case command
      when 'C-q'
        exit
      when 'C-f', 'page-down'
        page_down
      when 'C-b', 'page-up'
        page_up
      when 'up', 'k'
        cursor_up
      when 'down', 'j'
        cursor_down
      when 'left', 'h'
        cursor_left
      when 'right', 'l'
        cursor_right
      when 'resize'
        # screen.resize(Curses.lines, Curses.cols)
      else
        @window.addstr(command.inspect)
      end

      show_status

      @window.refresh
    end
  ensure
    stop
  end

  def replace_buffer(window, lines)
    width = window.maxx - window.begx

    (window.begy..(window.maxy - 2)).each do |y|
      next unless line = lines[y]

      if line.size > width
        window.addstr(line[0...width])
      else
        window.addstr(line)
      end
    end

    window.setpos(0, 0)
  end

  def page_down
    (@window.maxy - 1).times{ break unless cursor_down }
  end

  def page_up
    (@window.maxy - 1).times{ break unless cursor_up }
  end

  def cursor_left
    return if @col - 1 < 0
    return unless line = @lines[@line]

    @col -= 1
    @window.setpos(@window.cury, @window.curx - 1)
  end

  def cursor_right
    return unless line = @lines[@line]
    return unless line[@col + 1]

    @col += 1
    @window.setpos(@window.cury, @window.curx + 1)
  end

  def cursor_up
    return unless @line > 0

    @line -= 1
    y, x = @window.cury, @window.curx

    if y <= 0
      @window.scrl -1
      @window.setpos(0, 0)
      @window.addstr(@lines[@line])
      @window.setpos(0, x)
    else
      @window.setpos(y - 1, x)
    end

    true
  end

  def cursor_down
    return unless (@line + 1) < @lines.size

    @line += 1
    y, x = @window.cury, @window.curx

    if y >= (@window.maxy - 1)
      @window.scrl 1
      @window.setpos(y, 0)
      @window.addstr(@lines[@line].chomp)
      @window.setpos(y, x)
    else
      @window.setpos(y + 1, x)
    end

    true
  end

  def show_status
    line = {
      :y => @window.cury,
      :x => @window.curx,
      :begy => @window.begy,
      :maxy => @window.maxy,
      :begx => @window.begx,
      :maxx => @window.maxx,
      :line => @line,
      :lines => @lines.size,
    }
    @status.setpos(0, 0)
    @status.deleteln
    @status.addstr(line.inspect)
    @status.refresh
  end
end

Edit.new.edit(ARGV[0])
