module VER
  class Keymap
    def self.get(options)
      name = options.fetch(:name)

      find_and_load(name)
      send(name, options)
    end

    def self.find(keymap_name)
      VER.find_in_loadpath("keymap/#{keymap_name}.rb")
    end

    def self.find_and_load(keymap_name)
      if path = find(keymap_name)
        sane = path.dirname/path.basename(path.extname)
        require sane.to_s
      else
        raise LoadError, "cannot find keymap: %p" % [keymap_name]
      end
    end

    attr_accessor :modes, :callback, :widget, :tag, :previous_mode
    attr_reader :mode

    def initialize(options)
      @callback = options.fetch(:receiver)
      @widget = options.fetch(:widget, @callback)
      @previous_mode = nil
      @modes = {}

      prepare_tag
      prepare_default_binds
    end

    def message(*args)
      @callback.message(*args)
    end

    def send(*args)
      @callback.__send__(*args)
    end

    def enter_key(key)
      modes[mode].enter_key key
    end

    def enter_missing(key)
      modes[mode].enter_missing key
    end

    def prepare_tag
      self.tag = TkBindTag.new
      tags = widget.bindtags

      index = tags.index{|element| element.is_a?(Class) }
      tags[index - 1, 0] = @tag

      widget.bindtags = tags
    end

    def prepare_default_binds
      tag.bind 'Key' do |event|
        case event.char
        when ''
          # enter_missing event.keysym
          # p event
        else
          enter_missing event.char
        end

        Tk.callback_break
      end

      0.upto 9 do |n|
        tag.bind("KeyPress-#{n}") do |key|
          enter_key n.to_s
          Tk.callback_break
        end
      end
    end

    def register(key)
      tag.bind(key){|event|
        enter_key key
        Tk.callback_break
      }
    end

    # TODO: callbacks
    def mode=(cm)
      self.previous_mode = self.mode
      @mode = cm.to_sym
    end

    def add_mode(name)
      @modes[name.to_sym] = mode = VER::Mode.new(name, self)
      yield mode if block_given?
      mode
    end

    def use_previous_mode
      return unless mode = previous_mode
      self.mode = previous_mode
    end
  end

  # Tk keysyms
  KEYSYMS = {
    " "  => "space",
    "!"  => "exclam",
    '"'  => "quotedbl",
    "#"  => "numbersign",
    "$"  => "dollar",
    "%"  => "percent",
    "&"  => "ampersand",
    "'"  => "quoteright",
    "("  => "parenleft",
    ")"  => "parenright",
    "*"  => "asterisk",
    "+"  => "plus",
    ","  => "comma",
    "-"  => "minus",
    "."  => "period",
    "/"  => "slash",
    "0"  => "KeyPress-0",
    "1"  => "KeyPress-1",
    "2"  => "KeyPress-2",
    "3"  => "KeyPress-3",
    "4"  => "KeyPress-4",
    "5"  => "KeyPress-5",
    "6"  => "KeyPress-6",
    "7"  => "KeyPress-7",
    "8"  => "KeyPress-8",
    "9"  => "KeyPress-9",
    ":"  => "colon",
    ";"  => "semicolon",
    "<"  => "less",
    "="  => "equal",
    ">"  => "greater",
    "?"  => "question",
    "@"  => "at",
    "["  => "bracketleft",
    "\\" => "backslash",
    "]"  => "bracketright",
    "^"  => "asciicircum",
    "_"  => "underscore",
    "`"  => "quoteleft",
    "{"  => "braceleft",
    "|"  => "bar",
    "}"  => "braceright",
    "~"  => "asciitilde",
  }
end