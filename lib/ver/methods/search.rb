module VER
  module Methods
    module Search
      SEARCH_HIGHLIGHT = {
        foreground: '#000',
        background: '#ff0',
      }

      def status_search
        status_ask 'Search term: ' do |term|
          begin
            needle = Regexp.new(term)
          rescue RegexpError
            needle = Regexp.escape(term)
          end

          tag_all_matching(:search, needle, SEARCH_HIGHLIGHT)
        end
      end

      def search_next
        from, to = tag_nextrange('search', 'insert + 1 chars', 'end')
        mark_set(:insert, from) if from
      end

      def search_prev
        from, to = tag_prevrange('search', 'insert - 1 chars', '1.0')
        mark_set(:insert, from) if from
      end

      def search_next_word_under_cursor
        word = get('insert wordstart', 'insert wordend')
        tag_all_matching(:search, word, SEARCH_HIGHLIGHT)
        search_next
      end

      def search_prev_word_under_cursor
        word = get('insert wordstart', 'insert wordend')
        tag_all_matching(:search, word, SEARCH_HIGHLIGHT)
        search_prev
      end
    end
  end
end