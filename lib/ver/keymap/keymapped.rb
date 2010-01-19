module VER
  module Keymapped
    attr_accessor :keymap

    def mode
      keymap.mode if keymap
    end

    def mode=(name)
      return unless keymap
      return if keymap.mode == name
      Tk::Event.generate(self, "<<LeaveMode>>")
      Tk::Event.generate(self, "<<LeaveMode#{mode_as_camel_case}>>")
      keymap.mode = name if keymap
      Tk::Event.generate(self, "<<EnterMode#{mode_as_camel_case}>>")
      Tk::Event.generate(self, "<<EnterMode>>")
    end

    def mode_as_camel_case
      Mode.camel_case(mode)
    end
  end
end
