module VER
  # Clipboard is a size-limited container for copied buffer contents.
  #
  # VER allows you to copy selections (chars, lines, blocks), and can
  # communicate with external clipboard implementations in a limited way.
  #
  # Until we have a FFI binding to X11, there will be no native support for the
  # X11 clipboard.
  #
  # This means that you can only copy characters from/to external applications,
  # and VER cannot copy/paste special selections (lines, blocks) between
  # instances of VER.
  #
  # For now, the only backend is xclip, which also doesn't provide history.
  #
  # An internal history is stored, but if xclip is chosen as backend, the last
  # item in the history might not correspond to the actual content.
  class ClipBoard < Struct.new(:size, :backend, :history)
    include Enumerable

    def initialize(size = 100, backend = XClip.new)
      self.size, self.backend = size, backend
      self.history = []
    end

    # Copy given text into the backend and add it to the history.
    def copy(text)
      backend.copy text
      history.shift while history.size > size
      history << text
    end

    # Copy contents of the given path into the clipboard and backend.
    # doesn't add it to the history.
    def copy_file(path)
      backend.paste_file path
    end

    # Paste text from the backend
    def paste
      backend.paste text
    end

    def last(n = nil)
      n ? history.last(n) : history.last
    end

    def first(n = nil)
      n ? history.first(n) : history.first
    end

    def each(&block)
      history.each(&block)
    end
  end
end
