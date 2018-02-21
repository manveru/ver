module VER
  class Buffer
    class InvalidTrailingWhitespace < Tag
      NAME = 'invalid.trailing-whitespace'

      def initialize(buffer, name = NAME)
        super

        configure background: '#400'
      end

      def refresh(options = {})
        buffer.tag_all_matching(self, /[ \t]+$/, options)
      end
    end
  end
end
