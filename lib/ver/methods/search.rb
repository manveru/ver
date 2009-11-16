module VER
  module Methods
    module Search
      SEARCH_HIGHLIGHT = {
        foreground: '#000',
        background: '#ff0',
      }

      def status_search_next
        status_search_common('/') do
          search_next
        end
      end

      def status_search_prev
        status_search_common('?') do
          search_prev
        end
      end

      def status_search_common(question)
        status_ask question do |term|
          begin
            needle = Regexp.new(term)
          rescue RegexpError
            needle = Regexp.escape(term)
          end

          tag_all_matching(:search, needle, SEARCH_HIGHLIGHT)
          yield
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

      def search_char_right
        status_ask 'Search char right: ', take: 1 do |char|
          from, to = 'insert', 'insert lineend'
          regexp = Regexp.new(Regexp.escape(char))

          search_all regexp, from, to do |match, pos, mark|
            mark_set :insert, pos
            break
          end
        end
      end

      def search_char_left
        status_ask 'Search char left: ', take: 1 do |char|
          from, to = 'insert', 'insert linestart'
          regexp = Regexp.new(Regexp.escape(char))

          rsearch_all regexp, from, to do |match, pos, mark|
            mark_set :insert, pos
            break
          end
        end
      end
    end
  end
end
