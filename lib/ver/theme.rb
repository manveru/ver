module VER
  class Theme < Struct.new(:colors, :configuration)
    autoload :Murphy, 'ver/theme/murphy'

    def initialize(colors = {}, &block)
      self.colors = colors
      instance_eval(&block) if block_given?
    end

    def set(match, options)
      colors[match] = options
    end

    def get(name)
      colors.each do |syntax_name, options|
        return syntax_name if name.start_with?(syntax_name)
      end

      nil
    end

    def apply_config(widget)
      widget.configure(configuration)
    end
  end
end
