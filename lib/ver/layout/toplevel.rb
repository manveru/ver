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
        @really_destroy = false
        return if buffer.options.hidden

        buffer.focus
        return if buffer.winfo_ismapped

        buffer.frame.pack expand: true, fill: :both
        wm_withdraw

        # catch destroy requests from the WM before it's too late.
        wm_protocol('WM_DELETE_WINDOW'){
          buffer.close unless @really_destroy
          Tk::OK # don't forget about those...
        }
        bind('<FocusIn>'){|event|
          if event.window_path == self.tk_pathname
            buffer.focus
            Tk.callback_break
          end
        }
        Tk.update
        wm_deiconify
      end
    end

    def initialize(*args)
      super
      configure takefocus: false
      VER.root.wm_withdraw
    end

    def add_buffer(buffer)
      buffer.layout.show
    end

    def forget_buffer(buffer)
      buffer.layout.hide
    end

    def create_buffer(options = {})
      toplevel = Toplevel.new(self, takefocus: false, class: 'ver')
      buffer = Buffer.new(toplevel, options)
      toplevel.buffer = buffer
      yield buffer if block_given?
      buffer
    end

    def close_buffer(buffer)
      buffer.layout.close
    end
  end
end
