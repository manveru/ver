module VER::Methods
  module Search
    HIGHLIGHT = {
      foreground: '#fff',
      background: '#660',
    }
    TAG = :search

    class << self
      def search_remove(text)
        text.tag_remove(TAG, 1.0, :end)
      end

      def status_search_next(text)
        status_search_common(text, '/'){ search_next(text) }
      end

      def status_search_prev(text)
        status_search_common(text, '?'){ search_prev(text) }
      end

      def status_search_common(text, question)
        text.status.bind('<<Modified>>') do
          search_incremental(text, text.status.value)
        end

        text.status_ask question do |term|
          text.status.bind('<<Modified>>'){ }
          search_incremental(text, term, force = true)
          search_prev(text)
          yield
        end
      end

      def search_incremental(text, term, force = false)
        return if !term || term.empty?
        return if !force && term.size <= text.options.search_incremental_min

        begin
          needle = Regexp.new(term)
        rescue RegexpError, SyntaxError
          needle = Regexp.escape(term)
        end

        text.tag_all_matching(TAG, needle, HIGHLIGHT)
        text.tag_lower(TAG)
        from, to = text.tag_nextrange(TAG, 1.0, :end)
        text.see(from) if from
      end

      def search_first(text)
        from, to = text.tag_nextrange(TAG, 1.0, :end)
        text.mark_set(:insert, from) if from
      end

      def search_last(text)
        from, to = tag_prevrange(TAG, :end, 1.0)
        text.mark_set(:insert, from) if from
      end

      def search_next(text, count = 1)
        count.times do
          from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
          text.mark_set(:insert, from) if from
        end

        search_display_matches_count(text)
      end

      def search_display_matches_count(text)
        total = text.tag_ranges(TAG).size

        if total == 1
          VER.message "1 match found"
        elsif total > 1
          VER.message "#{total} matches found"
        else
          VER.message "No matches found"
        end
      end

      def search_prev(text, count = 1)
        count.times do
          from, to = text.tag_prevrange(TAG, 'insert - 1 chars', '1.0')
          text.mark_set(:insert, from) if from
        end

        search_display_matches_count(text)
      end

      def search_next_word_under_cursor(text)
        word = text.get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        text.tag_all_matching(TAG, word, HIGHLIGHT)
        text.tag_lower(TAG)
        search_next(text)
      end

      def search_prev_word_under_cursor(text)
        word = text.get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        text.tag_all_matching(TAG, word, HIGHLIGHT)
        text.tag_lower(TAG)
        search_prev(text)
      end

      def search_char_right(text, count = 1)
        return
        VER.message 'Press the character to find to the right'

        text.keymap.gets 1 do |char|
          if char.size == 1
            from, to = 'insert + 1 chars', 'insert lineend'
            regexp = Regexp.new(Regexp.escape(char))

            counter = 0
            text.search_all regexp, from, to do |match, pos, mark|
              text.mark_set :insert, pos
              counter += 1
              break if counter == count
            end

            VER.message ""
          else
            VER.message "abort: #{char} is not a single character"
          end
        end
      end

      def search_char_left(text, count = 1)
        return
        VER.message 'Press the character to find to the left'

        text.keymap.gets 1 do |char|
          if char.size == 1
            from, to = 'insert', 'insert linestart'
            regexp = Regexp.new(Regexp.escape(char))

            counter = 0
            text.rsearch_all regexp, from, to do |match, pos, mark|
              text.mark_set(:insert, pos)
              counter += 1
              break if counter == count
            end

            VER.message ""
          else
            VER.message "abort: #{char} is not a single character"
          end
        end
      end

      def search_clear(text)
        text.tag_remove(TAG, 1.0, :end)
      end
    end
  end
end
