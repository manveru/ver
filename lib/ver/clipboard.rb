module VER
  module Clipboard
    module_function

    def get(type = 'UTF8_STRING')
      case type
      when 'STRING'
        Tk::Clipboard.get(VER.root, type).encode(Encoding::ASCII)
      when 'UTF8_STRING'
        got = Tk::Clipboard.get(VER.root, type)
        got.encode!(Encoding::ASCII) if got.ascii_only?
        got
      else
        Tk::Clipboard.get(VER.root, type)
      end
    end

    def set(string)
      case string.encoding
      when Encoding::UTF_8
        Tk::Clipboard.set(string, type: 'UTF8_STRING')
      when Encoding::ASCII
        Tk::Clipboard.set(string, type: 'STRING')
      else
        raise ArgumentError, "Encoding mismatch, argument is %p" % [string.encoding]
      end
    end
  end
end
