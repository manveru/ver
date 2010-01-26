module VER
  module Keymapped
    attr_reader :major_mode

    def major_mode=(new_mode)
      old_mode = self.major_mode
      new_mode = WidgetMajorMode.new(self, new_mode)

      return if old_mode == new_mode

      new_mode.replaces old_mode do
        @major_mode = new_mode
      end
    end

    def minor_mode(*args, old, new)
      major_mode.replace_minor(old, new)
    end

    def minor_mode?(name)
      name = name.to_sym
      major_mode.minors.find{|minor| minor.to_sym == name }
    end
  end
end
