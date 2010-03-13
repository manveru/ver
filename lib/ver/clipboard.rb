module VER
  # Tries to provide a simple interface to the X clipboard.
  # In particular we worry about exceptions and encodings.
  #
  # Please note that you should not use this module if you want to set or get
  # binary contents from the clipboard, you'll have to use {Tk::Clipboard}
  # directly or put up with a base64 and marshal overhead.
  module Clipboard
    module_function

    def clear
      Tk::Clipboard.clear(VER.root)
    end

    def get(type)
      Tk::Clipboard.get(VER.root, type)
    end

    def dwim
      string || marshal
    end

    def string
      got = Tk.execute('::tk::GetSelection', VER.root, 'CLIPBOARD').to_s
    rescue => ex
      l ex
      nil
    else
      if got.ascii_only?
        got.encode!('ASCII')
      else
        got.force_encoding('UTF-8')
        got.encode!(Encoding.default_external)
      end

      got
    end

    def marshal
      got = get('RUBY_MARSHAL')
    rescue
      nil
    else
      Marshal.load(got.unpack('m0').first)
    end

    def set(string, type)
      Tk::Clipboard.set(string, type: type)
    end

    # dwim stands for "do what i mean", and for most of your clipboard needs
    # this should just do what you want.
    def dwim=(object)
      if object.respond_to?(:to_str)
        self.string = object.to_str
      elsif object.respond_to?(:to_ary)
        array = object.to_ary
        self.string = array.join("\n")
        self.marshal = object
      else
        self.marshal = object
      end
    end

    def string=(string)
      case string.encoding
      when Encoding::ASCII
        self.ascii = string
      when Encoding::UTF_8
        self.utf8 = string
      else
        self.utf8 = string.encode('UTF-8')
      end
    end

    # Note that this will encode string without making a copy, so only pass
    # UTF-8 strings or make a copy if you mind the encoding change.
    #
    # Use this method on *nix if possible, most modern applications query for
    # this type first.
    def utf8=(string)
      case Tk::TkCmd.windowingsystem
      when :x11
        set(string.encode!('UTF-8'), 'UTF8_STRING')
      else
        set(string.encode!('UTF-8'), 'STRING')
      end
    end

    # Note that this will encode string without making a copy, so only pass
    # US-ASCII strings or make a copy if you mind the encoding change.
    #
    # The benefit of using this method is that it should work with older
    # applications too, as they might not know about UTF8_STRING.
    def ascii=(string)
      set(string.encode!('US-ASCII'), 'STRING')
    end

    # This will put any object capable of being marshalled into the clipboard.
    # We use RUBY_MARSHAL as type, but it's also base64-encoded as specified in
    # RFC 4648 to keep it ASCII.
    def marshal=(object)
      marshal = [Marshal.dump(object)].pack('m0')
      set(marshal, 'RUBY_MARSHAL')
    end
  end
end
