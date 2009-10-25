module Tk
  # Translation from Tcl: http://wiki.tcl.tk/1954
  class Tooltip < Struct.new(:widget, :text, :tooltip)
    def initialize(on_widget, text)
      super

      widget.bind('Any-Enter'   ){ Tk.after(500){ show    }}
      widget.bind('Any-Leave'   ){ Tk.after(500){ destroy }}
      widget.bind('Any-KeyPress'){ Tk.after(500){ destroy }}
      widget.bind('Any-Button'  ){ Tk.after(500){ destroy }}
    end

    def destroy
      tooltip.destroy
    rescue NoMethodError, RuntimeError => ex
    end

    def show
      root = Tk.root
      root_pointerx, root_pointery = root.winfo_pointerx, root.winfo_pointery
      return unless TkWinfo.containing(root_pointerx, root_pointery)

      destroy

      scrh, scrw = widget.winfo_screenheight, widget.winfo_screenwidth

      self.tooltip = TkToplevel.new(widget, bd: true, bg: 'black'){
        geometry "+#{scrh}+#{scrw}"
        overrideredirect true
        attributes(topmost: true) if Tk::PLATFORM['platform'] == 'windows'
      }

      label = Tk::Label.new(tooltip, bg: :lightyellow, fg: :black,
                                     text: text, justify: :left).pack

      width, height = label.winfo_reqwidth, label.winfo_reqheight

      position_x, position_y = root_pointerx, root_pointery + 25
      root_screen_width = root.winfo_screenwidth

      if (position_x + width) > root_screen_width
        position_x -= ((position_x + width) - root_screen_width)
      end

      tooltip.geometry("#{width}x#{height}+#{position_x}+#{position_y}")
      tooltip.raise

      tooltip.bind('Any-Enter'){ destroy }
      tooltip.bind('Any-Leave'){ destroy }
    end
  end
end

require 'tk'

button = TkButton.new(text: 'hello').pack
Tk::Tooltip.new(button, 'Hello, World!')

Tk.mainloop