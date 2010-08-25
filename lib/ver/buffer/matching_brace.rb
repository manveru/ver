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

        idx = index
        from, to = idx.matching_brace_indices
        if from == idx || to == idx
          add(from, from + '1 chars', to, to + '1 chars')
        end
      end
    end
  end
end
