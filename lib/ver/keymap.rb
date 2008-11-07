require 'set'
require 'pp'

module VER
  def self.let(*names, &block)
    first, *rest = *names

    if rest.empty? and first.respond_to?(:to_hash)
      first.to_hash.each do |name, dependencies|
        Mode.create(name, *dependencies, &block)
      end
    else
      names.each{|name| Mode.create(name, &block) }
    end
  end

  # Mode contains one or more KeyMaps and maintains relationships between them,
  # so one Mode may inherit from another Mode which affects the lookup.
  # Don't make circular references!
  class Mode
    LIST = {}

    def self.create(name, *dependencies, &block)
      if mode = LIST[name]
        mode.add_dependencies(*dependencies)
        mode.dsl(&block)
      else
        mode = LIST[name] = new(name, *dependencies, &block)
      end

      return mode
    end

    attr_accessor :name
    attr_reader :dependencies, :map

    def initialize(name, *dependencies, &block)
      @name = name
      @map = KeyMap.new(self, name)
      @dependencies = []
      add_dependencies(*dependencies)
      dsl(&block)
    end

    def keys
      @map.keys
    end

    def dsl(&block)
      @map.merge!(ModeMapper.new(self, &block)) if block
    end

    def add_dependencies(*deps)
      @dependencies += deps.map{|d| Mode.create(d) }
      @dependencies.uniq!
    end

    def [](*expression)
      [@map, *@dependencies].map{|keymap| keymap[*expression] }.flatten.uniq.compact
    end

    def each(&block)
      keys = [@map, *@dependencies].each do |keymap|
        keymap.each(&block)
      end
    end

    alias deep_each each
  end

  # ModeMapper is the instance in which keymapping configuration is executed
  # Every #mode either creates a new mode or retrieves an existing one based on
  # the names given

  class ModeMapper
    attr_reader :name, :keys

    def initialize(parent, &block)
      @parent = parent
      @keys = Set.new
      instance_eval(&block)
    end

    def map(*args, &block)
      if block_given?
        @keys << Key.new(*args, &block)
      else
        self[*args]
      end
    end

    # Assign a macro to a key or key-combination
    def macro(key, as, &block)
      expression = as.split(/ +/)
      map(key.split(/ +/)){|*m| virtual{|kh| expression.each{|k| kh.press(k) }}}
    end

    def after(*keys, &block)
      add_aspect(:after, *keys, &block)
    end

    def before(*keys, &block)
      add_aspect(:before, *keys, &block)
    end

    def add_aspect(name, *keys, &block)
      keys.each do |k|
        @parent.deep_each do |key|
          if key.expression == k
            new = key.clone
            new.send("#{name}=", block)
            @keys << new
            next
          end
        end
      end
    end

    def [](*expression)
      @parent[*expression]
    end
  end

  class KeyMap
    attr_reader :name, :keys

    def initialize(parent, name)
      @parent, @name = parent, name
      @keys = Set.new
    end

    def merge!(modemapper)
      @keys += modemapper.keys
    end

    def each(&block)
      @keys.each(&block)
    end

    def deep_each(&block)
      @parent.deep_each(&block)
    end

    include Enumerable

    def [](*expression)
      @keys.map{|key| key.match(*expression) }
    end
  end

  class KeyHandler
    attr_accessor :view, :keys

    def initialize(view)
      @view = view
      @keys = []
    end

    def press(key)
      keys << key
      @mode = Mode::LIST[view.mode]

      first, *rest = all = @mode[*keys]

      unless first
        VER.info("No mapping for: %p in %p" % [keys, view.mode])
        keys.clear
        return
      end

      if first.ready
        keys.clear
        execute_key(first)
      else
        VER.info("Waiting for completion of %p" % first.expression)
      end
    end

    def execute_key(key)
      # VER.info("Execute: %p in %p: %p" % [keys, view.mode, first])
      @args = key.args
      @arg = @args.first

      instance_eval(&key.before) if key.before
      result = instance_eval(&key.block)
      instance_eval(&key.after) if key.after

      return result
    end

    def [](*args)
      @mode[*args]
    end

    def selection; view.selection end
    def cursor;    view.cursor    end
    def buffer;    view.buffer    end
    def window;    view.window    end
    def methods;   view.methods   end

    def method_missing(meth, *args, &block)
      view.methods.send(meth, *args, &block)
    end

    def virtual
      yield(clone)
    end
  end

  # Holds name, documentation, key combinations
  # Can be compared with other keys, but note that the assigned block will be
  # ignored in the comparision since equality is not possible otherwise.
  class Key
    attr_accessor :expression, :name, :doc, :args, :block, :ready,
      :after, :before

    def initialize(expression, name = nil, doc = nil, args = [], &block)
      @expression, @name, @doc, @args, @block = expression, name, doc, args, block
    end

    # TODO: simplify that, i doubt i'll understand it in a few weeks...
    def match(*input)
      args = @args.dup
      temp = input.dup

      case @expression
      when Array
        @expression.each do |exp|
          return dup_with(args, ready = false) if temp.empty?

          case exp
          when String
            return unless exp == temp.shift
          when Regexp
            if exp =~ temp.shift
              captures = $~.captures

              add = captures.empty? ? [$&] : captures
              args += add
            else
              return
            end
          end
        end
      when String
        return unless temp.join == @expression
      when Regexp
        if temp.join =~ @expression
          args += $~.captures
        else
          return
        end
      else
        return
      end

      return dup_with(args)
    end

    def dup_with(args, ready = true)
      d = dup
      d.ready = ready
      d.args = args
      d
    end

    def hash
      [expression, name, doc].hash
    end

    def ==(key)
      return false unless key.is_a?(Key)
      hash == key.hash
    end
    alias eql? ==

    # Currying works over regular expressions, a mapping to
    # /(\d) f/ would respond to the keys "1 f" and 1 would be put into @args
    # Further args can be given here, which will be put afterwards
    def call_signature(*args)
      @args + args
    end

    def call(*args)
      @block.call(*call_signature(*args))
    end

    def inspect
      "Key %p" % [@expression]
    end
  end
end
