module VER
  class Status
    class Label < Tk::Tile::Label
      attr_reader :status, :variable, :weight

      def initialize(status, options = {})
        @status = status
        @weight = options.delete(:weight) || 0
        options[:font] ||= text.options.font

        super

        id = Digest::MD5.hexdigest(tk_pathname)
        name = self.class.name[/::([^:]+)$/, 1]
        @variable = Tk::Variable.new("#{name}_#{id}")
        configure(textvariable: @variable)

        triggers.each do |trigger|
          add_trigger(trigger)
        end
      end

      def style=(config)
        configure(config)
      end

      def triggers
        []
      end

      def add_trigger(event)
        status.bind(event){|ev| update(ev) }
      end

      def text
        status.text
      end

      def update(event)
        variable.set(to_s)
      end

      def to_s
        ''
      end
    end
  end
end
