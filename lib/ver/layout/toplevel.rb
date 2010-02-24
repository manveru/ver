module VER
  class ToplevelLayout < Tk::Frame
    class Toplevel < Tk::Toplevel
      attr_accessor :buffer

      def hide
        wm_withdraw
      end

      def show
        buffer.frame.pack expand: true, fill: :both
        bind('FocusIn'){ buffer.focus }
        wm_withdraw
        Tk.eval('update')
        wm_deiconify
      end
    end

    def initialize(*args)
      super
      VER.root.wm_withdraw
    end

    def add_buffer(buffer)
      buffer.layout.show
    end

    def forget_buffer(buffer)
      buffer.layout.hide
    end

    def create_buffer(options = {})
      toplevel = Toplevel.new(self)
      buffer = Buffer.new(toplevel, options)
      toplevel.buffer = buffer
      add_buffer(buffer)
      yield buffer
      buffer
    end

    def close_buffer(buffer)
      buffer.layout.destroy
    end
  end
end
