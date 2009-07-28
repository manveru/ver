module VER
  class Theme < Struct.new(:colors)
    def initialize(colors = {}, &block)
      self.colors = colors
      instance_eval(&block) if block_given?
    end

    def on(match, color)
      colors[match] = Color[color]
    end
    alias []= on

    def [](name)
      colors.each do |match, color|
        case match
        when Symbol
          return color if match == name
        else
          return color if match =~ name
        end
      end

      colors[:default]
    end
  end
end
