module VER
  # A Hash containing the Tk keysyms.
  # The key is the ascii character, the value is the name as used in tk binds.
  KEYSYMS = {
    " "  => "<space>",
    "!"  => "<exclam>",
    "#"  => "<numbersign>",
    "$"  => "<dollar>",
    "%"  => "<percent>",
    "&"  => "<ampersand>",
    "'"  => "<quoteright>",
    "("  => "<parenleft>",
    ")"  => "<parenright>",
    "*"  => "<asterisk>",
    "+"  => "<plus>",
    ","  => "<comma>",
    "-"  => "<minus>",
    "."  => "<period>",
    "/"  => "<slash>",
    ":"  => "<colon>",
    ";"  => "<semicolon>",
    "<"  => "<less>",
    "="  => "<equal>",
    ">"  => "<greater>",
    "?"  => "<question>",
    "@"  => "<at>",
    "["  => "<bracketleft>",
    "\\" => "<backslash>",
    "]"  => "<bracketright>",
    "^"  => "<asciicircum>",
    "_"  => "<underscore>",
    "`"  => "<quoteleft>",
    "{"  => "<braceleft>",
    "|"  => "<bar>",
    "}"  => "<braceright>",
    "~"  => "<asciitilde>",
    '"'  => "<quotedbl>",
    '0' => '0',
    '1' => '1',
    '2' => '2',
    '3' => '3',
    '4' => '4',
    '5' => '5',
    '6' => '6',
    '7' => '7',
    '8' => '8',
    '9' => '9',
    'A' => 'A',
    'B' => 'B',
    'C' => 'C',
    'D' => 'D',
    'E' => 'E',
    'F' => 'F',
    'G' => 'G',
    'H' => 'H',
    'I' => 'I',
    'J' => 'J',
    'K' => 'K',
    'L' => 'L',
    'M' => 'M',
    'N' => 'N',
    'O' => 'O',
    'P' => 'P',
    'Q' => 'Q',
    'R' => 'R',
    'S' => 'S',
    'T' => 'T',
    'U' => 'U',
    'V' => 'V',
    'W' => 'W',
    'X' => 'X',
    'Y' => 'Y',
    'Z' => 'Z',
    'a' => 'a',
    'b' => 'b',
    'c' => 'c',
    'd' => 'd',
    'e' => 'e',
    'f' => 'f',
    'g' => 'g',
    'h' => 'h',
    'i' => 'i',
    'j' => 'j',
    'k' => 'k',
    'l' => 'l',
    'm' => 'm',
    'n' => 'n',
    'o' => 'o',
    'p' => 'p',
    'q' => 'q',
    'r' => 'r',
    's' => 's',
    't' => 't',
    'u' => 'u',
    'v' => 'v',
    'w' => 'w',
    'x' => 'x',
    'y' => 'y',
    'z' => 'z',
  }

  # Inversion of KEYSYMS for fast lookup in {WidgetMajorMode}
  SYMKEYS = KEYSYMS.invert

  # This can be used in specs or other code to fake events.
  # It also represents the minimum required properties for events.
  class FakeEvent < Struct.new(:sequence, :keysym, :unicode)
    # A propably incomplete listing of keysyms to fake events.
    LIST = {}

    def self.add(sequence, *args)
      LIST[sequence] = new(sequence, *args)
    end

    def self.[](sequence)
      LIST.fetch(sequence)
    rescue KeyError => ex
      raise(KeyError, "#{ex}: %p" % [sequence])
    end

    def initialize(sequence, keysym = nil, unicode = nil)
      self.sequence = sequence
      self.keysym   = keysym  || sequence_to_keysym(sequence)
      self.unicode  = unicode || sequence_to_unicode(sequence)
    end

    def sequence_to_keysym(sequence)
      raise sequence
    end

    def sequence_to_unicode(sequence)
      raise sequence
    end

    ('a'..'z').each{|c| add(c,c,c) }
    ('A'..'Z').each{|c| add(c,c,c) }
    ('0'..'9').each{|c| add(c,c,c) }
    add '<End>', 'End', ''
    add '<dollar>', 'dollar', '$'
    add '<percent>', 'percent', '%'
    add '<Control-e>', 'e', "\x05"
    add '<Control-a>', 'a', "\x01"
    add '<Control-x>', 'x', "\x18"
    add '<Control-b>', 'b', "\x02"
    add '<Control-p>', 'p', "\x10"
    add '<Control-n>', 'n', "\x0E"
    add '<Control-f>', 'f', "\x06"
    add '<Control-v>', 'v', "\x16"
    add '<Next>', 'Next', ""
    add '<Shift-Left>', '', ''
    add '<Shift-Right>', '', ''
    add '<Prior>', 'Prior', ''
    add '<Up>', 'Up', ''
    add '<Right>', 'Right', ''
    add '<Left>', 'Left', ''
    add '<Down>', 'Down', ''
    add '<Home>', 'Home', ""
  end
end
