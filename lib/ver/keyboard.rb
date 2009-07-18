module VER
  module Keyboard # avoid initialize
    ESC = 27 # keycode
    @polling = false

    module_function

    def focus=(receiver)
      @stack = []
      @focus = receiver
      EM.defer{ poll } unless @polling
    end

    def poll
      @polling = true

      Ncurses.doupdate

      while char = @focus.window.getch
        break if VER.stopping?

        if char == Ncurses::ERR # timeout or signal
          @focus.press('esc') if @stack == [ESC]
          @stack.clear
          Ncurses.doupdate
        elsif ready = resolve(char) # found a key to press
          @stack.clear
          @focus.press(ready)
          Ncurses.doupdate
        end
      end

    ensure
      @polling = false
    end

    def resolve(char)
      @stack << char
      found = @stack.inject(KEYS){|keys, key| keys.fetch(key) }
      found unless Hash === found
    rescue KeyError
      VER.warn @stack
      VER.warn found
      @stack.clear
      nil
    end

    MERGER = proc{|key,v1,v2|
      Hash === v1 && Hash === v2 ? v1.merge(v2, &MERGER) : v2
    }

    def self.key(*args)
      total = hash = {}
      name = args.pop

      while arg = args.shift
        if args.empty?
          hash[arg] = name
        else
          hash = hash[arg] = {}
        end
      end

      KEYS.replace KEYS.merge(total, &MERGER)
    end

    KEYS = {}

    key 27, 258, 'M-down'
    key 27, 259, 'M-up'
    key 27, 260, 'M-left'
    key 27, 261, 'M-right'
    key 27, 79, 100, 'C-left'
    key 27, 79, 50, 81, 'F14'
    key 27, 79, 50, 82, 'F15'
    key 27, 79, 70, 'end'
    key 27, 79, 72, 'home'
    key 27, 79, 80, 'F1'
    key 27, 79, 81, 'F2'
    key 27, 79, 82, 'F3'
    key 27, 79, 83, 'F4'
    key 27, 79, 97, 'C-up'
    key 27, 79, 98, 'C-down'
    key 27, 79, 99, 'C-right'
    key 27, 91, 49, 126, 'end'
    key 27, 91, 49, 126, 'home'
    key 27, 91, 49, 49, 126, 'F1'
    key 27, 91, 49, 50, 126, 'F2'
    key 27, 91, 49, 51, 126, 'F3'
    key 27, 91, 49, 52, 126, 'F4'
    key 27, 91, 49, 52, 126, 'F4'
    key 27, 91, 49, 53, 126, 'F5'
    key 27, 91, 49, 55, 126, 'F6'
    key 27, 91, 49, 56, 59, 50, 126, 'F19'
    key 27, 91, 49, 56, 59, 51, 126, 'F7'
    key 27, 91, 49, 59, 51, 65, 'M-up'
    key 27, 91, 49, 59, 51, 66, 'M-down'
    key 27, 91, 49, 59, 51, 67, 'M-right'
    key 27, 91, 49, 59, 51, 68, 'M-left'
    key 27, 91, 49, 59, 53, 65, 'ppage'
    key 27, 91, 49, 59, 53, 66, 'npage'
    key 27, 91, 49, 59, 53, 70, 'M-<'
    key 27, 91, 49, 59, 53, 72, 'M->'
    key 27, 91, 50, 51, 'F21'
    key 27, 91, 50, 52, 'F22'
    key 27, 91, 50, 53, 'F13'
    key 27, 91, 50, 54, 126, 'F14'
    key 27, 91, 50, 56, 126, 'F15'
    key 27, 91, 50, 57, 'F16'
    key 27, 91, 51, 49, 'F17'
    key 27, 91, 51, 50, 'F18'
    key 27, 91, 51, 51, 'F19'
    key 27, 91, 51, 52, 'F20'
    key 27, 91, 51, 59, 51, 126, 'del'
    key 27, 91, 52, 126, 'end'
    key 27, 91, 55, 126, 'home'
    key 27, 91, 55, 126, 'home'
    key 27, 91, 56, 126, 'end'
    key 27, 91, 56, 126, 'end'
    key 27, 91, 65, 'up'
    key 27, 91, 66, 'down'
    key 27, 91, 67, 'right'
    key 27, 91, 68, 'left'
    key 27, 91, 70, 'end'
    key 27, 91, 72, 'end'
    key 27, 91, 72, 'home'
    key 27, 91, 91, 65, 'F1'
    key 27, 91, 91, 66, 'F2'
    key 27, 91, 91, 67, 'F3'
    key 27, 91, 91, 68, 'F4'
    key 27, 91, 91, 69, 'F5'

    key 0,   'C-space'
    key 1,   'C-a'
    key 2,   'C-b'
    key 3,   'C-c'
    key 4,   'C-d'
    key 5,   'C-e'
    key 6,   'C-f'
    key 7,   'C-g'
    key 8,   'C-h'
    key 9,   'tab'
    key 10,  'return' # C-j
    key 11,  'C-k'
    key 12,  'C-l'
    key 13,  'return' # C-m
    key 14,  'C-n'
    key 15,  'C-o'
    key 16,  'C-p'
    key 17,  'C-q'
    key 18,  'C-r'
    key 19,  'C-s'
    key 20,  'C-t'
    key 21,  'C-u'
    key 22,  'C-v'
    key 23,  'C-w'
    key 24,  'C-x'
    key 25,  'C-y'
    key 26,  'C-z'
    # key 27, 'esc'
    key 30,  'C-^'

    # ASCII
    key 32,  'space'
    key 33,  "!"
    key 34,  "\""
    key 35,  "#"
    key 36,  "$"
    key 37,  "%"
    key 38,  "&"
    key 39,  "'"
    key 40,  "("
    key 41,  ")"
    key 42,  "*"
    key 43,  "+"
    key 44,  ","
    key 45,  "-"
    key 46,  "."
    key 47,  "/"
    key 48,  "0"
    key 49,  "1"
    key 50,  "2"
    key 51,  "3"
    key 52,  "4"
    key 53,  "5"
    key 54,  "6"
    key 55,  "7"
    key 56,  "8"
    key 57,  "9"
    key 58,  ":"
    key 59,  ";"
    key 60,  "<"
    key 61,  "="
    key 62,  ">"
    key 63,  "?"
    key 64,  "@"
    key 65,  "A"
    key 66,  "B"
    key 67,  "C"
    key 68,  "D"
    key 69,  "E"
    key 70,  "F"
    key 71,  "G"
    key 72,  "H"
    key 73,  "I"
    key 74,  "J"
    key 75,  "K"
    key 76,  "L"
    key 77,  "M"
    key 78,  "N"
    key 79,  "O"
    key 80,  "P"
    key 81,  "Q"
    key 82,  "R"
    key 83,  "S"
    key 84,  "T"
    key 85,  "U"
    key 86,  "V"
    key 87,  "W"
    key 88,  "X"
    key 89,  "Y"
    key 90,  "Z"
    key 91,  "["
    key 92,  "\\"
    key 93,  "]"
    key 94,  "^"
    key 95,  "_"
    key 96,  "`"
    key 97,  "a"
    key 98,  "b"
    key 99,  "c"
    key 100, "d"
    key 101, "e"
    key 102, "f"
    key 103, "g"
    key 104, "h"
    key 105, "i"
    key 106, "j"
    key 107, "k"
    key 108, "l"
    key 109, "m"
    key 110, "n"
    key 111, "o"
    key 112, "p"
    key 113, "q"
    key 114, "r"
    key 115, "s"
    key 116, "t"
    key 117, "u"
    key 118, "v"
    key 119, "w"
    key 120, "x"
    key 121, "y"
    key 122, "z"
    key 123, "{"
    key 124, "|"
    key 125, "}"
    key 126, "~"

    # special
    key 127, 'backspace'
    key 269, 'F5'
    key 270, 'F6'
    key 271, 'F7'
    key 272, 'F8'
    key 273, 'F9'
    key 274, 'F10'
    key 275, 'F11'
    key 276, 'F12'
    key 338, 'npage'
    key 339, 'ppage'
    key 514, 'C-down'
    key 516, 'C-left'
    key 518, 'C-right'
    key 521, 'C-up'


    ASCII     = (0..255).map{|c| c.chr }
    CONTROL   = ASCII.grep(/[[:cntrl:]]/)
    PRINTABLE = ASCII.grep(/[[:print:]]/)
    PRINTABLE_REGEX = Regexp.union(*PRINTABLE)
  end
end
