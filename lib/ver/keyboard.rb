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

    key 0, 'C-space'
    key 1, 'C-a'
    key 2, 'C-b'
    key 3, 'C-c'
    key 4, 'C-d'
    key 5, 'C-e'
    key 6, 'C-f'
    key 7, 'C-g'
    key 8, 'C-h'
    key 9, 'tab'
    key 10, 'return' # C-j
    key 11, 'C-k'
    key 12, 'C-l'
    key 13, 'return' # C-m
    key 14, 'C-n'
    key 15, 'C-o'
    key 16, 'C-p'
    key 17, 'C-q'
    key 18, 'C-r'
    key 19, 'C-s'
    key 20, 'C-t'
    key 21, 'C-u'
    key 22, 'C-v'
    key 23, 'C-w'
    key 24, 'C-x'
    key 25, 'C-y'
    key 26, 'C-z'
    # key 27, 'esc' # prefix for following keys
    key 27, 32, "M-space"
    key 27, 33, "M-!"
    key 27, 34, "M-\""
    key 27, 35, "M-#"
    key 27, 36, "M-$"
    key 27, 37, "M-%"
    key 27, 38, "M-&"
    key 27, 39, "M-'"
    key 27, 40, "M-("
    key 27, 41, "M-)"
    key 27, 42, "M-*"
    key 27, 43, "M-+"
    key 27, 44, "M-,"
    key 27, 45, "M--"
    key 27, 46, "M-."
    key 27, 47, "M-/"
    key 27, 48, "M-0"
    key 27, 49, "M-1"
    key 27, 50, "M-2"
    key 27, 51, "M-3"
    key 27, 52, "M-4"
    key 27, 53, "M-5"
    key 27, 54, "M-6"
    key 27, 55, "M-7"
    key 27, 56, "M-8"
    key 27, 57, "M-9"
    key 27, 58, "M-:"
    key 27, 59, "M-;"
    key 27, 60, "M-<"
    key 27, 61, "M-="
    key 27, 62, "M->"
    key 27, 63, "M-?"
    key 27, 64, "M-@"
    key 27, 65, "M-A"
    key 27, 66, "M-B"
    key 27, 67, "M-C"
    key 27, 68, "M-D"
    key 27, 69, "M-E"
    key 27, 70, "M-F"
    key 27, 71, "M-G"
    key 27, 72, "M-H"
    key 27, 73, "M-I"
    key 27, 74, "M-J"
    key 27, 75, "M-K"
    key 27, 76, "M-L"
    key 27, 77, "M-M"
    key 27, 78, "M-N"
    # key 27, 79, "M-O" # prefix for following keys
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
    key 27, 80, "M-P"
    key 27, 81, "M-Q"
    key 27, 82, "M-R"
    key 27, 83, "M-S"
    key 27, 84, "M-T"
    key 27, 85, "M-U"
    key 27, 86, "M-V"
    key 27, 87, "M-W"
    key 27, 88, "M-X"
    key 27, 89, "M-Y"
    key 27, 90, "M-Z"
    # key 27, 91, "M-[" # prefix for following keys
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
    key 27, 92, "M-\\"
    key 27, 93, "M-]"
    key 27, 94, "M-^"
    key 27, 95, "M-_"
    key 27, 96, "M-`"
    key 27, 97, "M-a"
    key 27, 98, "M-b"
    key 27, 99, "M-c"
    key 27, 100, "M-d"
    key 27, 101, "M-e"
    key 27, 102, "M-f"
    key 27, 103, "M-g"
    key 27, 104, "M-h"
    key 27, 105, "M-i"
    key 27, 106, "M-j"
    key 27, 107, "M-k"
    key 27, 108, "M-l"
    key 27, 109, "M-m"
    key 27, 110, "M-n"
    key 27, 111, "M-o"
    key 27, 112, "M-p"
    key 27, 113, "M-q"
    key 27, 114, "M-r"
    key 27, 115, "M-s"
    key 27, 116, "M-t"
    key 27, 117, "M-u"
    key 27, 118, "M-v"
    key 27, 119, "M-w"
    key 27, 120, "M-x"
    key 27, 121, "M-y"
    key 27, 122, "M-z"
    key 27, 123, "M-{"
    key 27, 124, "M-|"
    key 27, 125, "M-}"
    key 27, 126, "M-~"
    key 27, 258, 'M-down'
    key 27, 259, 'M-up'
    key 27, 260, 'M-left'
    key 27, 261, 'M-right'
    key 30,  'C-^'
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

    key 258, 'down'
    key 259, 'up'
    key 260, 'left'
    key 261, 'right'

    # screen function keys
    key 265, 'F1'
    key 266, 'F2'
    key 267, 'F3'
    key 268, 'F4'
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
    key 410, 'resize'
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
