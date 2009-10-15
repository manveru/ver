module VER
  module Font
    module_function

    class << self
      attr_reader :cache
    end

    @cache = []

    def [](options)
      options = normalize_options(options)
      find(options) || create(options)
    end

    def find(options)
      @cache.find do |font|
        actual = font.actual_hash

        options.all? do |key, value|
          actual[key] == value
        end
      end
    end

    def create(options)
      font = TkFont.new(options)
      @cache << font
      font
    end

    def default
      VER.options[:font]
    end

    def default_options
      default ? default.actual_hash : {}
    end

    def normalize_options(options)
      result = default_options.dup

      options.each{|key, value|
        case key = key.to_s
        when 'family', 'weight', 'slant'
          result[key] = value.to_s
        when 'size', 'underline', 'overstrike'
          result[key] = value
        end
      }

      result
    end
  end
end