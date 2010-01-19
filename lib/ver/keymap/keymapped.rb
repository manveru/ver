module VER
  module Keymapped
    attr_accessor :keymap

    def mode
      keymap.mode if keymap
    end

    def mode=(name)
      return unless keymap
      return if keymap.mode == name
      p "<<LeaveMode>>"
      Tk::Event.generate(self, "<<LeaveMode>>")
      p "<<LeaveMode#{mode_as_camel_case}>>"
      Tk::Event.generate(self, "<<LeaveMode#{mode_as_camel_case}>>")
      keymap.mode = name if keymap
      p "<<EnterMode#{mode_as_camel_case}>>"
      Tk::Event.generate(self, "<<EnterMode#{mode_as_camel_case}>>")
      p "<<EnterMode>>"
      Tk::Event.generate(self, "<<EnterMode>>")
    end

    def mode_as_camel_case
      mode.to_s.split('_').map{|e| e.capitalize}.join
    end
  end
end
