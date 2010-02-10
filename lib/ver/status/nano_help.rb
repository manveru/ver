module VER
  class Status
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
  end
end
