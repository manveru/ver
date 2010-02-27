module VER
  # The status bar
  class Status < Tk::Tile::Frame
    autoload :Battery,          'ver/status/battery'
    autoload :BufferPosition,   'ver/status/buffer_position'
    autoload :DiakonosPosition, 'ver/status/diakonos_position'
    autoload :Encoding,         'ver/status/encoding'
    autoload :Filename,         'ver/status/filename'
    autoload :Label,            'ver/status/label'
    autoload :Mode,             'ver/status/mode'
    autoload :NanoHelp,         'ver/status/nano_help'
    autoload :NanoPosition,     'ver/status/nano_position'
    autoload :Percent,          'ver/status/percent'
    autoload :Position,         'ver/status/position'
    autoload :Separator,        'ver/status/separator'
    autoload :ShortFilename,    'ver/status/short_filename'
    autoload :Syntax,           'ver/status/syntax'

    LINES = {
      vim: lambda{|status|
        [
          ShortFilename.new(status, weight: 1),
          Position.new(status),
          Percent.new(status),
          Mode.new(status),
          Syntax.new(status),
          Encoding.new(status),
        ]
      },
      nano: lambda{|status|
        [
          NanoPosition.new(status, row: 0, column: 0, weight: 1, anchor: :center),
          NanoHelp.new(status, row: 1, column: 0, sticky: :nwse, weight: 1),
        ]
      },
      diakonos: lambda{|status|
        [
          Separator.new(status, orient: :horizontal),
          Filename.new(status),
          Separator.new(status, orient: :horizontal),
          Syntax.new(status, format: "(%s)"),
          Separator.new(status, orient: :horizontal, weight: 1),
          BufferPosition.new(status, format: 'Buf %d of %d'),
          Separator.new(status, orient: :horizontal),
          DiakonosPosition.new(status, format: 'L %3d/%3d C%2d'),
          Separator.new(status, orient: :horizontal),
        ]
      }
    }

    module LabelToggle
      def toggle
        info = grid_info

        if info.empty?
          grid_configure(@last_grid_info)
          status.show
          true
        else
          @last_grid_info = info
          grid_forget
          unless status.winfo_children.any?{|child| Tk::Winfo.ismapped(child) }
            status.hide
          end
          false
        end
      end
    end

    attr_accessor :buffer, :widgets, :notify

    def initialize(parent, buffer, options = {})
      super(parent, options)
      self.buffer = buffer
      self.notify = Hash.new{|hash, key| hash[key] = Set.new }

      constructor = VER.options.statusline || LINES.fetch(VER.options.keymap.to_sym)
      @widgets = constructor.call(self)
      @widgets.each.with_index do |widget, index|
        row    = widget.row    || 0
        column = widget.column || index
        sticky = widget.sticky || :we
        weight = widget.weight || 0

        widget.grid_configure(row: row, column: column, sticky: sticky)
        grid_columnconfigure(widget, weight: weight)
      end

      grid_rowconfigure(0, weight: 1)
    end

    def event(*names)
      names.each do |name|
        notify[name].each do |widget|
          widget.update(name)
        end
      end
    end

    def register(widget, *events)
      events.each{|event| notify[event] << widget }
    end

    def style=(config)
      Tk::After.idle{ @widgets.each{|widget| widget.style = config } }
    end

    def show
      return if winfo_ismapped
      grid_configure(@last_grid_info)
      true
    end

    def hide
      return unless winfo_ismapped
      @last_grid_info = grid_info
      grid_forget
      true
    end
  end
end
