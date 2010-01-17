module VER::Methods
  module Preview
    class << self
      def preview(text)
        return unless syntax = text.syntax

        case syntax.name
        when 'Ruby'
          View::Console.new(text, 'ruby', text.filename)
        end
      end
    end
  end
end
