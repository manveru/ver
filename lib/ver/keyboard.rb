module VER
  module Keyboard # avoid initialize
    module_function

    def focus(view)
      @stack = []
      @view = view
    end

    def poll
      # trap('SIGINT'){ @view.press('C-c') }

      while char = @view.window.getch
        if ready = resolve(char)
          @stack.clear
          # Log.debug("ready = %p" % [ready])
          @view.press(ready)
        end
      end
    end

    def resolve(char)
      @stack << char unless char == -1

      if char == -1 and @stack == [27]
        'esc'
      elsif @stack.first == 27
        MOD_KEYS[@stack] || SPECIAL_KEYS[@stack]
      else
        NCURSES_KEYS[char] || CONTROL_KEYS[char] || PRINTABLE_KEYS[char]
      end
    end

    # TODO: make this section sane

    ASCII     = (0..255).map{|c| c.chr }
    CONTROL   = ASCII.grep(/[[:cntrl:]]/)
    PRINTABLE = ASCII.grep(/[[:print:]]/)

    PRINTABLE_KEYS = {}
    PRINTABLE.each{|c| PRINTABLE_KEYS[c[0]] = c }

    SPECIAL_KEYS = {
      [27, 27]              => 'esc', # TODO: cheap hack, maybe add timeout for esc?
      [27, 91, 49, 49, 126] => 'F1',
      [27, 91, 49, 50, 126] => 'F2',
      [27, 91, 49, 51, 126] => 'F3',
      [27, 91, 49, 52, 126] => 'F4',
      [27, 91, 55, 126]     => 'home',
      [27, 91, 56, 126]     => 'end',
    }

    CONTROL_KEYS = {
      0   => 'C-space',
      1   => 'C-a',
      2   => 'C-b',
      3   => 'C-c',
      4   => 'C-d',
      5   => 'C-e',
      6   => 'C-f',
      7   => 'C-g',
      8   => 'C-h',
      9   => 'tab',
      10  => 'return',
      11  => 'C-k',
      12  => 'C-l',
      13  => 'C-m', # this may be return
      14  => 'C-n',
      15  => 'C-o',
      16  => 'C-p', # FIXME: need to turn off flow control
      17  => 'C-q', # FIXME: need to turn off flow control
      18  => 'C-r',
      19  => 'C-s', # FIXME: need to turn off flow control
      20  => 'C-t',
      21  => 'C-u',
      22  => 'C-v',
      23  => 'C-w',
      24  => 'C-x',
      25  => 'C-y',
      26  => 'C-z', # FIXME: is usually suspend in shell job control
      # 27 => 'esc',
      32  => 'space',
      127 => 'backspace',
    }

    MOD_KEYS = { }
    (PRINTABLE - ['[']).each{|c| MOD_KEYS[[27, c[0]]] = "M-#{c}" }
    # M-[ is esc

    NCURSES_KEYS = {}
    Ncurses.constants.grep(/^KEY_/).each do |const|
      value = Ncurses.const_get(const)
      key = const[/^KEY_(.*)/, 1].downcase
      NCURSES_KEYS[value] = key
    end
  end
end
