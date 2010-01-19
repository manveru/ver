module VER
  module Keymapped
    attr_accessor :keymap

    def mode
      keymap.mode if keymap
    end

    def mode=(new_mode)
      return unless keymap
      old_mode = keymap.mode

      return if old_mode == new_mode

      Tk::Event.generate(self, "<<LeaveMode>>", data: new_mode)
      Tk::Event.generate(self, "<<LeaveMode#{mode_as_camel_case}>>", data: new_mode)
      keymap.mode = new_mode
      Tk::Event.generate(self, "<<EnterMode#{mode_as_camel_case}>>", data: old_mode)
      Tk::Event.generate(self, "<<EnterMode>>", data: old_mode)
    end

    def mode_as_camel_case
      Mode.camel_case(mode)
    end
  end
end
