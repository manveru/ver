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

    OS = RbConfig::CONFIG['host_os']

    def bsd?
      mac? || freebsd? || openbsd?
    end

    def freebsd?
      OS =~ /freebsd/
    end

    def openbsd?
      OS =~ /openbsd/
    end

    def darwin?
      OS =~ /darwin/
    end

    def windows?
      OS =~ /mingw|mswin/
    end

    def mac?
      darwin?
    end

    def unix?
      not windows?
    end

    def operatingsystem
      OS
    end
  end
end
