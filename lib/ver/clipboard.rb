module VER
  module Clipboard
    module_function

    def get(type = 'UTF8_STRING')
      Tk::Clipboard.get(VER.root, type)
    end

    def set(string)
      Tk::Clipboard.set(string, type: 'UTF8_STRING')
    end
  end
end
