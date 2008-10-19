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
        if modes.include?(mode_name) and signature = mode_map[key]
          return yield(mode_name, signature)
        end
      end

      VER.info "not mapped key: %p in modes: %p" % [key, modes]
    rescue Object => ex
      message = "Key: %p in modes: %p" % [key, modes]
      VER.error(message, ex)
    end

    class Mode
      def initialize(name)
        @name = name
        @map = {}
      end

      def let(&block)
        instance_eval(&block)
      end

      def keys(keys, method, *args)
        keys.each{|k| key(k, method, *args) }
      end

      def key(k, method, *args)
        self[k] = [method, *args]
      end

      def [](key)
        @map[key.to_s]
      end

      def []=(key, signature)
        @map[key.to_s] = signature
      end
    end
  end
end
