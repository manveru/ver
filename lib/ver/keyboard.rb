module VER
  module Keyboard # avoid initialize
    ESC_TIMEOUT = 0.1 # seconds
    ESC         = 27 # keycode

    module_function

    def focus(view)
      @stack = []
      @view = view
      @time = Time.now
    end

    def poll
      while char = @view.window.getch
        break if VER.stopping?

        if char == Ncurses::ERR # timeout or signal
          @view.press('esc') if @stack == [ESC]
          @stack.clear
        elsif ready = resolve(char)
          @stack.clear
          @view.press(ready)
        end
      end
    end

    def resolve(char)
      @stack << char

      if @stack.first == ESC
        MOD_KEYS[@stack] || SPECIAL_KEYS[@stack]
      else
        NCURSES_KEYS[char] || CONTROL_KEYS[char] || PRINTABLE_KEYS[char]
      end
    end

    # TODO: make this section sane

    ASCII     = (0..255).map{|c| c.chr }
    CONTROL   = ASCII.grep(/[[:cntrl:]]/)
    PRINTABLE = ASCII.grep(/[[:print:]]/)

    SPECIAL_KEYS = {
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
      10  => 'return', # C-j
      11  => 'C-k',
      12  => 'C-l',
      13  => 'return', # C-m
      14  => 'C-n',
      15  => 'C-o',
      16  => 'C-p',
      17  => 'C-q',
      18  => 'C-r',
      19  => 'C-s',
      20  => 'C-t',
      21  => 'C-u',
      22  => 'C-v',
      23  => 'C-w',
      24  => 'C-x',
      25  => 'C-y',
      26  => 'C-z', # FIXME: is usually suspend in shell job control
      # 27  => 'esc',
      32  => 'space',
      127 => 'backspace',
    }

    PRINTABLE_KEYS = {}
    MOD_KEYS = {}

    PRINTABLE.each do |key|
      code = key.unpack('c')[0] # using unpack to be compatible with 1.9
      PRINTABLE_KEYS[code] = key
      MOD_KEYS[[ESC, code]] = "M-#{key}" unless key == '[' # don't map esc
    end

    NCURSES_KEYS = {}
    Ncurses.constants.grep(/^KEY_/).each do |const|
      value = Ncurses.const_get(const)
      key = const[/^KEY_(.*)/, 1].downcase
      NCURSES_KEYS[value] = key
    end
  end
end
