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
