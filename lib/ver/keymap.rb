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
      name="bindtag__ver::layout0_ver::view0_ver::status0"
      uuid = callback.tk_pathname.tr('.-:', '_').squeeze('_')
      self.tag = Tk::BindTag.new("bindtag_#{uuid}")
      tags = widget.bindtags

      pivot = %w[Text TEntry]
      index = tags.index{|element| pivot.include?(element) }
      tags[index - 1, 0] = @tag

      widget.bindtags(*tags)
    end

    def prepare_default_binds
      tag.bind '<Key>' do |event|
        case chunk = event.unicode
        when ''
          # enter_missing event.keysym
          # p event
        else
          enter_missing(chunk)
        end

        Tk.callback_break
      end

      0.upto 9 do |n|
        tag.bind("<KeyPress-#{n}>") do |key|
          enter_key n.to_s
          Tk.callback_break
        end
      end
    end

    def register(sequence)
      tag.bind("<#{sequence}>"){|event|
        enter_key sequence
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