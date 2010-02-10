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
    autoload :NanoPosition,  'ver/status/nano_position'
    autoload :NanoHelp,      'ver/status/nano_help'

    class NanoPosition < Label
      def triggers
        ['<<Position>>']
      end

      def style=(config)
        configure(config)
      end

      def to_s
        line_now     = text.count(1.0, :insert, :lines) + 1
        line_total   = text.count(1.0, :end, :lines)
        line_percent = ((100.0 / line_total) * line_now)
        line_percent = 0 if line_percent.nan?

        col_now     = text.count('insert linestart', :insert, :chars) + 1
        col_total   = text.count('insert linestart', 'insert lineend', :chars) + 1
        col_percent = ((100.0 / col_total) * col_now)
        col_percent = 0 if col_percent.nan?

        char_now   = text.count(1.0, :insert, :chars)
        char_total = text.count(1.0, :end, :chars) - 1
        char_percent = ((100.0 / char_total) * char_now)
        char_percent = 0 if char_percent.nan?

        inner = "%d/%d (%d%%), %d/%d (%d%%), %d/%d (%d%%)" % [
          line_now, line_total, line_percent.round,
          col_now,  col_total,  col_percent.round,
          char_now, char_total, char_percent.round,
        ]

        "[ #{inner} ]"
      end
    end

    class NanoHelp < Tk::Tile::Frame
      attr_reader :status, :weight, :row, :column, :sticky

      def initialize(status, options = {})
        @status = status
        @weight = options.delete(:weight) || 0
        @row = options.delete(:row)
        @column = options.delete(:column)
        @sticky = options.delete(:sticky)
        @font = status.text.options.font

        super

        @long_labels = []
        @short_labels = []

        add 0, 0, '^G', ' Get Help'
        add 0, 1, '^O', ' WriteOut'
        add 0, 2, '^R', ' Read File'
        add 0, 3, '^Y', ' Prev Page'
        add 0, 4, '^K', ' Cut Text'
        add 0, 5, '^C', ' Cur Pos'
        add 1, 0, '^X', ' Exit'
        add 1, 1, '^J', ' Justify'
        add 1, 2, '^W', ' Where Is'
        add 1, 3, '^V', ' Next Page'
        add 1, 4, '^U', ' UnCut Text'
        add 1, 5, '^T', ' To Spell'

        0.upto 11 do |col|
          weight = col % 2 == 0 ? 0 : 1
          grid_columnconfigure(col, weight: weight)
        end
      end

      def add(row, col, short, long)
        short_label = Tk::Tile::Label.new(
          self, font: @font, background: 'white', foreground: 'black', text: short)
        long_label  = Tk::Tile::Label.new(
          self, font: @font, background: 'black', foreground: 'white', text: long)
        short_col = col * 2
        long_col = short_col + 1

        short_label.grid_configure(row: row, column: short_col, sticky: :w)
        long_label.grid_configure(row: row, column: long_col, sticky: :we)

        @long_labels << long_label
        @short_labels << short_label
      end

      def style=(config)
        # @long_labels.each{|label| label.configure(config) }
      end
    end

    LINES = {
      vim: lambda{|status|
        [
          ShortFilename.new(status, weight: 1),
          Position.new(status),
          Percent.new(status),
          Mode.new(status),
          Syntax.new(status),
          Encoding.new(status),
          Battery.new(status, width: 100, height: 17),
        ]
      },
      nano: lambda{|status|
        [
          NanoPosition.new(status, row: 0, column: 0, weight: 1, anchor: :center),
          NanoHelp.new(status, row: 1, column: 0, sticky: :nwse, weight: 1),
        ]
      },
    }

    attr_accessor :buffer, :widgets

    def initialize(buffer, options = {})
      super
      self.buffer = buffer

      constructor = VER.options.statusline || LINES.fetch(VER.options.keymap.to_sym)
      @widgets = constructor.call(self)
      @widgets.each.with_index do |widget, index|
        row, column = widget.row || 0, widget.column || index
        sticky = widget.sticky || :we
        widget.grid_configure(row: row, column: column, sticky: sticky)
        grid_columnconfigure(widget, weight: widget.weight)
      end
    end

    def event(name)
      Tk::Event.generate(self, "<<#{name}>>")
    end

    def text
      buffer.text
    end

    def style=(config)
      Tk::After.idle{ @widgets.each{|widget| widget.style = config } }
    end
  end
end
