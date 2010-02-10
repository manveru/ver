module VER
  class Status
    class Label < Tk::Tile::Label
      attr_reader :status, :variable, :weight, :row, :column, :sticky, :format

      def initialize(status, options = {})
        @status = status
        @weight = options.delete(:weight) || 0
        @row = options.delete(:row)
        @column = options.delete(:column)
        @sticky = options.delete(:sticky)
        @format = options.delete(:format) || '%s'
        options[:font] ||= options.delete(:font) || text.options.font

        super

        id = Digest::MD5.hexdigest(tk_pathname)
        name = self.class.name[/::([^:]+)$/, 1]
        @variable = Tk::Variable.new("#{name}_#{id}")
        configure(textvariable: @variable)

        setup
      end

      def setup
      end

      def update(event)
        variable.set(to_s)
      end

      def register(*events)
        status.register(self, *events)
      end

      def style=(config)
        configure(config)
      end

      def text
        status.text
      end

      def to_s
        ''
      end
    end
  end
end
