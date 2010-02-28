module VER
  module Clipboard
    module_function

    def get
      Tk::Clipboard.get(VER.root, 'UTF8_STRING')
    end

    def set(string)
      Tk::Clipboard.set(string, type: 'UTF8_STRING')
    end
  end
end
