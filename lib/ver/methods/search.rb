module VER
  module Methods
    module Search
      SEARCH_HIGHLIGHT = {
        foreground: '#fff',
        background: '#660',
      }

      def search_remove
        tag_remove('search', '1.0', 'end')
      end

      def status_search_next
        status_search_common('/'){ search_next }
      end

      def status_search_prev
        status_search_common('?'){ search_prev }
      end

      def status_search_common(question)
        status.bind('<<Modified>>') do
          search_incremental(status.value)
        end

        status_ask question do |term|
          status.bind('<<Modified>>'){ }
          search_incremental(term, force = true)
          search_prev
          yield
        end
      end

      def search_incremental(term, force = false)
        return if !term || term.empty?
        return if !force && term.size <= options.search_incremental_min

        begin
          needle = Regexp.new(term)
        rescue RegexpError, SyntaxError
          needle = Regexp.escape(term)
        end

        tag_all_matching(:search, needle, SEARCH_HIGHLIGHT)
        tag_lower(:search)
        from, to = tag_nextrange('search', '1.0', 'end')
        see(from) if from
      end

      def search_first
        from, to = tag_nextrange(:search, '1.0', 'end')
        mark_set(:insert, from) if from
      end

      def search_last
        from, to = tag_prevrange(:search, 'end', '1.0')
        mark_set(:insert, from) if from
      end

      def search_next(count = 1)
        count.times do
          from, to = tag_nextrange(:search, 'insert + 1 chars', 'end')
          mark_set(:insert, from) if from
        end

        search_display_matches_count
      end

      def search_display_matches_count
        total = tag_ranges(:search).size

        if total == 1
          status.message "1 match found"
        elsif total > 1
          status.message "#{total} matches found"
        else
          status.message "No matches found"
        end
      end

      def search_prev(count = 1)
        count.times do
          from, to = tag_prevrange(:search, 'insert - 1 chars', '1.0')
          mark_set(:insert, from) if from
        end

        search_display_matches_count
      end

      def search_next_word_under_cursor
        word = get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        tag_all_matching(:search, word, SEARCH_HIGHLIGHT)
        tag_lower(:search)
        search_next
      end

      def search_prev_word_under_cursor
        word = get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        tag_all_matching(:search, word, SEARCH_HIGHLIGHT)
        tag_lower(:search)
        search_prev
      end

      def search_char_right(count = 1)
        VER.message 'Press the character to find to the right'

        keymap.gets 1 do |char|
          if char.size == 1
            from, to = 'insert + 1 chars', 'insert lineend'
            regexp = Regexp.new(Regexp.escape(char))

            counter = 0
            search_all regexp, from, to do |match, pos, mark|
              mark_set :insert, pos
              counter += 1
              break if counter == count
            end

            VER.message ""
          else
            VER.message "abort: #{char} is not a single character"
          end
        end
      end

      def search_char_left(count = 1)
        VER.message 'Press the character to find to the left'

        keymap.gets 1 do |char|
          if char.size == 1
            from, to = 'insert', 'insert linestart'
            regexp = Regexp.new(Regexp.escape(char))

            counter = 0
            rsearch_all regexp, from, to do |match, pos, mark|
              mark_set :insert, pos
              counter += 1
              break if counter == count
            end

            VER.message ""
          else
            VER.message "abort: #{char} is not a single character"
          end
        end
      end

      def search_clear
        tag_remove(:search, '1.0', 'end')
      end
    end
  end
end
