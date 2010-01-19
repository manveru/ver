module VER
  Keymap = Struct.new(
    :modes, :tag, :previous_mode, :last_send, :ignore_sends, :accumulate_sends,
    :key_history, :execute_history, :arguments, :name, :mode
  )

  class Keymap
    autoload :ArbiterTag, 'ver/keymap/arbiter_tag'

    LOADED = {}

    def self.define(options)
      self[options[:name]] || new(options)
    end

    def self.[](name)
      LOADED[name]
    end

    def self.find(keymap_name)
      VER.find_in_loadpath("keymap/#{keymap_name}.rb")
    end

    def self.load(keymap_name)
      if path = find(keymap_name)
        require((path.dirname/path.basename(path.extname)).to_s)
        LOADED[keymap_name.to_sym]
      else
        raise LoadError, "cannot find keymap: %p" % [keymap_name]
      end
    end

    def initialize(options)
      self.name = options.fetch(:name).to_sym

      if LOADED.key?(name)
        raise ArgumentError, "Keymap named #{name} already exists"
      else
        LOADED[name] = self
      end

      self.previous_mode = nil
      self.mode = options.fetch(:mode).to_sym
      self.modes = {}
      self.key_history = SizedArray.new(100)
      self.execute_history = SizedArray.new(50)
      self.last_send = nil
      self.ignore_sends ||= []
      self.accumulate_sends ||= []
      self.arguments = true

      self.tag = ArbiterTag.new(self, "ver_keymap_#{name}")
    end

    def inspect
      "#<Keymap #{name}>"
    end

    def use(options)
      keymap = dup
      keymap.tag = self.tag.reuse(options)
      keymap.mode = options.fetch(:mode, self.mode)
      keymap
    end

    def message(*args)
      tag.message(*args)
    end

    def send(*args)
      tag.execute(*args)
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
    end

    def gets(count, &block)
      @gets_count, @gets_block = count, block
      @gets_got = []
    end

    def gets_wrapper(key)
      return unless @gets_count && @gets_block

      symbolic = key.sub(/^<(.*)>$/, '\1')
      key = SYMKEYS.fetch(symbolic, key)

      @gets_got << key

      return true unless @gets_got.size >= @gets_count

      begin
        @gets_block.call(*@gets_got)
      ensure
        @gets_count = @gets_got = @gets_block = nil
      end

      true
    end

    def enter_key(widget, key)
      key_history << key
      gets_wrapper(key) || modes[widget.mode].enter_key(widget, key)
    end

    def enter_missing(widget, key)
      key_history << key
      gets_wrapper(key) || modes[widget.mode].enter_missing(widget, key)
    end

    def register(raw_sequence)
      tag.register(raw_sequence)
    end

    def all_bound_sequences
      sequences = Tk.execute(:bind, tag.name).to_a
      sequences.map{|seq| KEYSYMS.fetch(seq, seq) }
    end

    # TODO: callbacks
    def mode=(cm)
      self.previous_mode = self.mode
      self[:mode] = cm.to_sym
    end

    def add_mode(name)
      mode = modes[name.to_sym] ||= VER::Mode.new(name, self, tag)
      yield mode if block_given?
      mode
    end

    def in_mode(name, &block)
      add_mode(name){|mode| mode.instance_eval(&block) }
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

  SYMKEYS = KEYSYMS.invert
end
