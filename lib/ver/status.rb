module VER
  # The status bar
  class Status < Tk::Tile::Frame
    autoload :Label,         'ver/status/label'
    autoload :ShortFilename, 'ver/status/short_filename'
    autoload :Position,      'ver/status/position'
    autoload :Percent,       'ver/status/percent'
    autoload :Battery,       'ver/status/battery'
    autoload :Encoding,      'ver/status/encoding'
    autoload :Mode,          'ver/status/mode'
    autoload :Syntax,        'ver/status/syntax'

    LINES = {
      vim: lambda{|status|
             [ ShortFilename.new(status, weight: 1),
               Position.new(status),
               Percent.new(status),
               Mode.new(status),
               Syntax.new(status),
               Encoding.new(status),
               Battery.new(status, width: 100, height: 17),
             ]
           },
    }

    attr_accessor :buffer

    def initialize(buffer, options = {})
      super
      self.buffer = buffer

      @widgets = VER.options.statusline.call(self)
      @widgets.each.with_index do |widget, index|
        widget.grid_configure(row: 0, column: index, sticky: :we)
        grid_columnconfigure(widget, weight: widget.weight)
      end
    end

    def text
      buffer.text
    end

    def style=(config)
      Tk::After.idle{ @widgets.each{|widget| widget.style = config } }
    end
  end
end
