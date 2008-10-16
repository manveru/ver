module VER
  module KeyMap
    MODES = {}

    module_function

    def let(name, &block)
      mode = MODES[name] ||= Mode.new(name)
      mode.let(&block)
    end

    def press(key, *modes)
      MODES.each do |mode_name, mode_map|
        if modes.include?(mode_name) and method = mode_map[key]
          return yield(mode_name, method)
        end
      end

      VER.info "not mapped key: %p in modes: %p" % [key, modes]
    rescue Exception => ex
      Log.error "Key: %p in modes: %p" % [key, modes]
      Log.error ex
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
end
