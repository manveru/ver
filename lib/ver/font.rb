module VER
  # FIXME:
  #   If a font doesn't support, for example, underline, we will still create a
  #   new font for it.
  #   This means that there can be an infinite number of fonts with identical
  #   options, yet we still try to create new instances because the actual
  #   properties of the font don't equal the properties it was created with.
  #   We might be able to fix this by storing the options used for creation with
  #   the Font and comparing against them instead.
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
      @cache.find{|font| font.actual_hash == options }
    end

    def create(options)
      font = Tk::Font.new(options)
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
      result = {}

      options.each{|key, value|
        case key = key.to_s
        when 'family'
          result[key.to_sym] = value.to_s
        when 'weight', 'slant'
          result[key.to_sym] = value.to_sym
        when 'size'
          result[key.to_sym] = value.to_i
        when 'underline', 'overstrike'
          result[key.to_sym] = !!value
        end
      }

      result
    end
  end
end
