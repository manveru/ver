module VER
  class Status
    class Separator < Tk::Tile::Separator
      attr_reader :status, :weight, :row, :column, :sticky

      def initialize(status, options = {})
        @status = status
        @weight = options.delete(:weight) || 0
        @row = options.delete(:row)
        @column = options.delete(:column)
        @sticky = options.delete(:sticky)

        super
      end

      def style=(conf); end
    end
  end
end
