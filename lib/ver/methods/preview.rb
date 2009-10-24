module VER
  module Methods
    module Preview
      def preview
        return unless syntax

        case syntax.name
        when 'Ruby'
          View::Console.new(self, 'ruby', filename)
        end
      end
    end
  end
end