module VER
  module KeyMap
    MODES = {}

    module_function

    def let(name, &block)
      mode = MODES[name] ||= Mode.new(name)
      mode.let(&block)
    end

    def press(key, *modes)
      MODES.values_at(*modes).each do |mode|
        if method = mode[key]
          return mode, method
        end
      end
    end

    class Mode
      def initialize(name)
        @name = name
        @map = {}
      end

      def let(&block)
        instance_eval(&block)
      end

      def keys(keys, method)
        keys.each{|k| self[k] = method }
      end

      def key(k, method)
        self[k] = method
      end

      def [](key)
        @map[key.to_s]
      end

      def []=(key, method)
        @map[key.to_s] = method
      end
    end
  end

  class Action
    def initialize(view, mode, key)
      @view, @mode, @key = view, mode, key
    end

    def write_character
      @view.buffer.write @key
    end
  end
end

VER::KeyMap.let :input do
  keys ('a'..'z'), 'write_character'
  keys ('A'..'Z'), 'write_character'
  key :esc, :into_control_mode
end

VER::KeyMap.let :control do
  key :a, :append
  key :b, :back_word
  key :s, :delete_then_input
  key :R, :into_replace_mode
  key :esc, :into_control_mode
  key :i, :into_insert_mode
end

__END__

VER::KeyMap.merge do |keymap|
  keymap.input do |input|
    map(:input, ('a'..'z'), 'write_character')
    map(('A'..'Z'), 'write_character')
  end
end

  MODE_KEY_MAP = {
    :input => {},
    :control => {},
  }

  def self.map(mode, key, to)
    MODE_KEY_MAP[mode][key] = to
  end

  def self.map_input
  end

  ('a'..'z').each do |char|
    map :input, char, 'write_character'
  end

  module Action
    module_function

    def write_character
    end
  end

  map :input, 'a'

  class Mode
    MODES = {}
    attr_accessor :buffer

    def self.[](*names)
      new(*names.map{|n| MODES[n] })
    end

    def initialize(*modes)
      @modes = modes
      extend(*modes)
    end

    def handle(buffer, key)
      @buffer, @key = buffer, key

      @modes.each do |mode|
        if mapped = mode::MAP[key]
          Log.debug "Command: %p" % mapped
          send(mapped)
        end
      end

      @buffer.refresh
    end

    def status_line
      '(' << @modes.map{|m| m.name[/::([^:]+)$/, 1] }.join(', ') << ')'
    end
  end
end
