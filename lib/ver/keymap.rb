require 'set'
require 'pp'

module VER
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
      @map = KeyMap.new(name)
      @dependencies = []
      add_dependencies(*dependencies)
      dsl(&block)
    end

    def dsl(&block)
      @map.merge!(ModeMapper.new(self, &block)) if block
    end

    def add_dependencies(*deps)
      @dependencies += deps.map{|d| Mode.create(d) }
      @dependencies.uniq!
    end

    def [](input)
      total =
        [@map, *@dependencies].
        map{|keymap| keymap[input] }.
        flatten.compact

      return total.first
    end
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
        self[args.first]
      end
    end

    # Assign a macro to a key or key-combination
    def macro(key, as, &block)
      keys = as.split(/ +/)
      map(key){|*m| keys.each{|k| self[k].call(*m) }}
    end

    def [](exp)
      @parent[exp]
    end
  end

  # KeyMap is a small wrapper around Hash and tries to incrementally match the
  # given key combination until one or no matches are left.
  class KeyMap
    attr_reader :name, :keys

    def initialize(name)
      @name = name
      @keys = Set.new
    end

    def merge!(modemapper)
      @keys += modemapper.keys
    end

    def [](input)
      @keys.map{|m| m === input }
    end
  end

  # Holds name, documentation, key combinations
  # Can be compared with other keys, but note that the assigned block will be
  # ignored in the comparision since equality is not possible otherwise.
  class Key
    attr_accessor :exp, :name, :doc, :args, :block

    def initialize(exp, name = nil, doc = nil, args = [], &block)
      @exp, @name, @doc, @args, @block = exp, name, doc, args, block
    end

    def ===(input)
      return unless @exp === input
      k = dup
      k.args = $~.captures if $~
      return k
    end

    def ==(key)
      return false unless key.is_a?(Key)
      [@exp, @name, @doc] == [key.exp, key.name, key.doc]
    end

    def eql?(key)
      self == key
    end

    # Currying works over regular expressions, a mapping to
    # /(\d) f/ would respond to the keys "1 f" and 1 would be put into @args
    # Further args can be given here, which will be put afterwards
    def call(*args)
      @block.call(*(@args + args))
    end
  end

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
end

__END__

module VER
  MODES = {}

  def VER.map(*modes, &block)
    modes.map!{|name|
      name = name.to_sym
      MODES[name] ||= Mode.new(name) }

    KeyMapper.new(*modes, &block)
  end

  class KeyMapper
    def initialize(*modes, &block)
      @modes = modes
      instance_eval(&block)
    end

    def key(map, methods, *args, &block)
      @modes.each do |mode|
        mode.set_key(map, methods, *args, &block)
      end
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
      mode = MODES[view.mode]

      findings = mode.get_key(*keys.dup)

      case findings
      when Hash
        pretty = findings.keys.sort_by{|k| k.to_s }.join(', ')
        VER.info("Waiting for one of: %s" % pretty)
        return false
      when Key
        if keys.size > 1
          VER.info("Execute: %p" % findings)
        end
        keys.clear
        return findings.press(view.methods)
      end
    end
  end

  Key = Struct.new(:map, :method, :block, :args)

  class Key
    def press(handler)
      if block
        handler.send(method, *args) if block.call(handler.view)
      else
        handler.send(method, *args)
      end
    rescue NoMethodError => ex
      VER.error(ex)
    end

    def profile
      require 'ruby-prof'

      result = nil
      profile = RubyProf.profile{ result = yield }
      printer = RubyProf::GraphHtmlPrinter.new(profile)
      location = File.expand_path('~/graph.html')

      ::File.open(location, 'w+') do |gr|
        printer.print(gr, :min_percent => 1)
      end

      return result
    end
  end

  class KeyMap
    def initialize(name)
      @name = name
      @map = {}
    end

    def merge!(keymap)
      @map.merge!(keymap.to_hash)
    end

    def to_hash
      @map.dup
    end

    def [](exp)
      matches = @map.select{|m| exp === m }

      case matches.size
      when 0
        nil
      when 1
        matches.first
      else
        matches
      end
    end

    def []=(exp, *args)
      @map[exp] = args
    end
  end

  # TODO:
  #   * Having keys mapped into a hash of hashes makes iterating more
  #     difficult, provide a simple #each
  class Mode
    attr_reader :name, :map

    def initialize(name)
      @name = name.to_sym
      @map = {}
    end

    def each_key
      @map.each do |key, value|
      end
    end

    def unnest_keys(mapping, all = [], pre = [])
      @map.each do |key, value|
        case value
        when Key
          all << value
        when Hash
          unnest_keys(value, all, pre + [key])
        end
      end

      return all
    end

    def set_key(maps, method, *args, &block)
      keys = [*maps].map{|m| m.to_s }
      last = keys.pop
      parent = @map

      while key = keys.shift
        case current = parent[key]
        when Key
          VER.warn("Remapping %p" % current)
          parent = parent[key] = {}
        when Hash
          parent = current
        else
          parent = parent[key] = {}
        end
      end

      parent[last] = Key.new(maps, method, block, args)
    end

    def get_key(*keys)
      last = keys.pop
      parent = @map

      while parent and key = keys.shift
        current = parent[key]
        parent = current if current
      end

      parent[last]
    end
  end
end
