module VER
  module Platform
    module_function

    def x11?
      windowingsystem == :x11
    end

    def win32?
      windowingsystem == :win32
    end

    def aqua?
      windowingsystem == :aqua
    end

    def windowingsystem
      @windowingsystem ||= Tk::TkCmd.windowingsystem
    end

    def bsd?
      FFI::Platform.bsd?
    end

    def windows?
      FFI::Platform.windows?
    end

    def mac?
      FFI::Platform.mac?
    end

    def unix?
      FFI::Platform.unix?
    end

    def operatingsystem
      FFI::Platform::OS
    end
  end
end
