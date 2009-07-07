module VER
  class Keyboard < Struct.new(:focus, :stack)
    def initialize(focus)
      self.focus = focus
      self.stack = []
    end

    def poll
      while char = focus.getch
        if key = resolve(char)
          CHANNEL << {:key => key}
          stack.clear
        elsif stack.size > 5
          stack.clear
        end
      end
    end

    def resolve(char)
      stack << char

      if stack.size == 1 && char.is_a?(String)
        char
      else
        found = stack.inject(KEYS){|keys, key|
          keys.fetch(key, {})
        }
        found if found && found.is_a?(String)
      end
    end

    KEYS = {
      0  => 'C-space',
      1  => 'C-a',
      2  => 'C-b',
      3  => 'C-c',
      4  => 'C-d',
      5  => 'C-e',
      6  => 'C-f',
      7  => 'C-g',
      8  => 'C-h',
      9  => 'C-i', # tab
      10 => 'C-j',
      11 => 'C-k',
      12 => 'C-l',
      13 => 'C-m', # return
      14 => 'C-n',
      15 => 'C-o',
      16 => 'C-p',
      17 => 'C-q',
      18 => 'C-r',
      19 => 'C-s',
      20 => 'C-t',
      21 => 'C-u',
      22 => 'C-v',
      23 => 'C-w',
      24 => 'C-x',
      25 => 'C-y',
      26 => 'C-z',
      # 27 => 'C-[', # esc
      28 => 'C-\\',
      29 => 'C-]',
      30 => 'C-6',
      31 => 'C-/',
      127 => 'backspace',
      410 => 'resize',
      27 => {
        0 => 'M-C-space',
        8 => 'M-C-backspace',
        9 => 'M-tab',
        13 => 'M-return',
        29 => 'M-C-]',
        27 => {
          '[' => {
            'A' => 'M-up',
            'B' => 'M-down',
            'C' => 'M-right',
            'D' => 'M-left',
            '2' => { '~' => 'M-insert' },
            '3' => { '~' => 'M-delete' },
          },
        },
        " " => "M-space",
        "'" => "M-'",
        '!' => 'M-!',
        '"' => 'M-"',
        '#' => 'M-"',
        '$' => 'M-$',
        '%' => 'M-%',
        '&' => 'M-&',
        '(' => 'M-(',
        ')' => 'M-)',
        '+' => 'M-+',
        ',' => 'M-,',
        '-' => 'M--',
        '.' => 'M-.',
        '/' => 'M-/',
        '0' => 'M-0',
        '1' => 'M-1',
        '2' => 'M-2',
        '3' => 'M-3',
        '4' => 'M-4',
        '5' => 'M-5',
        '6' => 'M-6',
        '7' => 'M-7',
        '8' => 'M-8',
        '9' => 'M-9',
        ':' => 'M-:',
        ';' => 'M-;',
        '<' => 'M-<',
        '=' => 'M-=',
        '>' => 'M->',
        '?' => 'M-?',
        '@' => 'M-@',
        # '[' => 'M-[', # used as prefix for other keys
        '\\' => 'M-\\',
        ']' => 'M-]',
        '_' => 'M-_',
        'A' => 'M-A',
        'B' => 'M-B',
        'C' => 'M-C',
        'D' => 'M-D',
        'E' => 'M-E',
        'F' => 'M-F',
        'G' => 'M-G',
        'H' => 'M-H',
        'I' => 'M-I',
        'J' => 'M-J',
        'K' => 'M-K',
        'L' => 'M-L',
        'M' => 'M-M',
        'N' => 'M-N',
        'O' => 'M-O',
        'P' => 'M-P',
        'Q' => 'M-Q',
        'R' => 'M-R',
        'S' => 'M-S',
        'T' => 'M-T',
        'U' => 'M-U',
        'V' => 'M-V',
        'W' => 'M-W',
        'X' => 'M-X',
        'Y' => 'M-Y',
        'Z' => 'M-Z',
        'a' => 'M-a',
        'b' => 'M-b',
        'c' => 'M-c',
        'd' => 'M-d',
        'e' => 'M-e',
        'f' => 'M-f',
        'g' => 'M-g',
        'h' => 'M-h',
        'i' => 'M-i',
        'j' => 'M-j',
        'k' => 'M-k',
        'l' => 'M-l',
        'm' => 'M-m',
        'n' => 'M-n',
        'o' => 'M-o',
        'p' => 'M-p',
        'q' => 'M-q',
        'r' => 'M-r',
        's' => 'M-s',
        't' => 'M-t',
        'u' => 'M-u',
        'v' => 'M-v',
        'w' => 'M-w',
        'x' => 'M-x',
        'y' => 'M-y',
        'z' => 'M-z',
        '{' => 'M-{',
        '|' => 'M-|',
        '}' => 'M-}',
        '~' => 'M-~',
        '[' => {
          '1' => {
             '1' => {'~' => 'F1'},
             '2' => {'~' => 'F2'},
             '3' => {'~' => 'F3'},
             '4' => {'~' => 'F4'},
             '5' => {'~' => 'F5'},
             '7' => {'~' => 'F6'},
             '8' => {'~' => 'F7'},
             '9' => {'~' => 'F8'},
          },
          "2" => {
            "0" => {"~" => 'F9'},
            "1" => {"~" => 'F10'},
            "3" => {"~" => 'F11'},
            "4" => {"~" => 'F12'},
            '9' => {'~' => 'menu'},
            "~" => 'insert',
          },

          "3" => {"~" => 'delete'},
          "5" => {'~' => 'page-up'},
          "6" => {'~' => 'page-down'},
          "7" => {'~' => 'home'},
          "8" => {'~' => 'end'},

          "A" => 'up',
          "B" => 'down',
          "C" => 'right',
          "D" => 'left',
        }
      }
    }
  end
end
