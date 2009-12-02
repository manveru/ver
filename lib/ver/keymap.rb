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

    attr_accessor :modes, :callback, :widget, :tag, :previous_mode, :last_send,
                  :ignore_sends, :accumulate_sends, :history, :arguments
    attr_reader :mode

    def initialize(options)
      self.callback = options.fetch(:receiver)
      self.widget = options.fetch(:widget, callback)
      self.previous_mode = nil
      self.modes = {}
      self.history = SizedArray.new(50)
      self.last_send = nil
      self.ignore_sends ||= []
      self.accumulate_sends ||= []
      self.arguments = true

      prepare_tag
      prepare_default_binds
    end

    def message(*args)
      callback.message(*args)
    end

    def send(*args)
      callback.send(*args)
    ensure
      name = args.first

      if accumulate_sends.include?(name)
        if last_send && last_send.first == name
          arg = (last_send[1..-1] + args[1..-1]).join
          self.last_send = [name, arg]
        else
          self.last_send = args
        end
      else
        if ignore_sends.include?(name)
          # self.last_send = nil
        else
          self.last_send = args
        end
      end

      # p history
      # p last_send
    end

    def enter_key(key)
      @history << key
      modes[mode].enter_key key
    end

    def enter_missing(key)
      @history << key
      modes[mode].enter_missing key
    end

    def prepare_tag
      name="bindtag__ver::layout0_ver::view0_ver::status0"
      uuid = widget.tk_pathname.scan(/\w+/).join('_')
      self.tag = Tk::BindTag.new("bindtag_#{uuid}")
      tags = widget.bindtags

      pivot = %w[Text TEntry Listbox]
      index = tags.index{|element| pivot.include?(element) }
      tags[index - 1, 0] = self.tag

      widget.bindtags(*tags)
    end

    def prepare_default_binds
      tag.bind '<Key>' do |event|
        chunk = event.unicode
        enter_missing(chunk) unless chunk == ''

        Tk.callback_break
      end

      0.upto 9 do |n|
        tag.bind("<KeyPress-#{n}>") do |key|
          enter_missing key.unicode
          Tk.callback_break
        end
      end
    end

    def register(raw_sequence)
      case raw_sequence
      when /^[a-zA-Z]$/
        canonical = raw_sequence
      else
        canonical = raw_sequence.sub(/(Shift-|Control-|Alt-)+(?!Key)/, '\1Key-')
        canonical = "<#{canonical}>"
      end

      tag.bind(canonical){|event|
        enter_key canonical
        Tk.callback_break
      }

      return canonical
    end

    def all_bound_sequences
      sequences = Tk.execute(:bind, tag.name).to_a
      sequences.map{|seq| KEYSYMS.fetch(seq, seq) }
    end

    # TODO: callbacks
    def mode=(cm)
      self.previous_mode = self.mode
      @mode = cm.to_sym
    end

    def add_mode(name)
      modes[name.to_sym] = mode = VER::Mode.new(name, self)
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
