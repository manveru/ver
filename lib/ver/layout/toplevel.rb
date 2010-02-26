module VER
  # A layout that puts every {Buffer} into its own {Tk::Toplevel}.
  # This means that the buffers can be managed by the window-manager itself
  # instead of VER, which might be preferable for people using tiling wms.
  #
  # So far this only has been used inside awesome, feedback on other wms are
  # welcome.
  class ToplevelLayout < Tk::Frame
    class Toplevel < Tk::Toplevel
      attr_accessor :buffer

      def hide
        wm_withdraw
      end

      def show
        return if buffer.options.hidden
        buffer.frame.pack expand: true, fill: :both
        wm_withdraw
        bind('<FocusIn>'){
          buffer.focus
          bind('<FocusIn>'){}
          Tk.callback_break
        }
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
      yield buffer if block_given?
      buffer
    end

    def close_buffer(buffer)
      buffer.layout.destroy
    end
  end
end
