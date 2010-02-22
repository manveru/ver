module VER
  class Buffer
    class MatchingBrace < Tag
      NAME = 'ver.highlight.brace'.freeze

      def initialize(buffer, name = NAME)
        super

        configure background: '#ff0', foreground: '#00f'
      end

      def refresh(index = buffer.at_insert)
        remove('1.0', 'end')

        if pos = index.matching_brace_index
          add(index, index + '1 chars', pos, pos + '1 chars')
        end
      end
    end
  end
end
