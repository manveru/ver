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

    def mode_as_camel_case
    end
  end
end
