module Tk
  # Translation from Tcl: http://wiki.tcl.tk/1954
  class Tooltip < Struct.new(:text, :tooltip)
    def bind_to(widget)
      widget.bind('<Any-Enter>'   ){ Tk::After.ms(500){ show(widget) }}
      widget.bind('<Any-Leave>'   ){ Tk::After.ms(500){ destroy }}
      widget.bind('<Any-KeyPress>'){ Tk::After.ms(500){ destroy }}
      widget.bind('<Any-Button>'  ){ Tk::After.ms(500){ destroy }}
    end

    def destroy
      tooltip.destroy
    rescue NoMethodError, RuntimeError => ex
    end

    def show_on(widget)
      root = Tk.root
      root_pointerx, root_pointery = root.winfo_pointerx, root.winfo_pointery
      return unless Tk::Winfo.containing(root_pointerx, root_pointery)

      destroy

      scrh, scrw = widget.winfo_screenheight, widget.winfo_screenwidth

      self.tooltip = tooltip = Tk::Toplevel.new(widget, bd: true, bg: 'black')
      tooltip.wm_geometry = "+#{scrh}+#{scrw}"
      tooltip.wm_overrideredirect = true
      tooltip.attributes(topmost: true) if tooltip.tk_windowingsystem == :win32

      label = Tk::Label.new(tooltip, bg: :lightyellow, fg: :black,
                                     text: text, justify: :left).pack

      width, height = label.winfo_reqwidth, label.winfo_reqheight

      position_x, position_y = root_pointerx, root_pointery + 25
      root_screen_width = root.winfo_screenwidth

      if (position_x + width) > root_screen_width
        position_x -= ((position_x + width) - root_screen_width)
      end

      tooltip.wm_geometry = "#{width}x#{height}+#{position_x}+#{position_y}"
      tooltip.raise

      tooltip.bind('Any-Enter'){ destroy }
      tooltip.bind('Any-Leave'){ destroy }
    end
  end
end

if __FILE__ == $0
  require 'ffi-tk'

  button = Tk::Button.new(text: 'hello').pack
  tooltip = Tk::Tooltip.new('Hello, World!')
  tooltip.bind_to(button)

  Tk.mainloop
end
