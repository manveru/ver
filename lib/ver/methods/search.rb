module VER::Methods
  module Search
    HIGHLIGHT = {
      foreground: '#fff',
      background: '#660',
    }
    TAG = :search

    class << self
      def remove(text)
        text.tag_remove(TAG, 1.0, :end)
      end

      def status_next(text)
        status_common(text, '/'){ self.next(text) }
      end

      def status_prev(text)
        status_common(text, '?'){ prev(text) }
      end

      def status_common(text, question)
        text.status.bind('<<Modified>>') do
          incremental(text, text.status.value)
        end

        text.status_ask question do |term|
          text.status.bind('<<Modified>>'){ }
          incremental(text, term, force = true)
          prev(text)
          yield
        end
      end

      def incremental(text, term, force = false)
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

      def first(text)
        from, to = text.tag_nextrange(TAG, 1.0, :end)
        text.mark_set(:insert, from) if from
      end

      def last(text)
        from, to = tag_prevrange(TAG, :end, 1.0)
        text.mark_set(:insert, from) if from
      end

      def next(text, count = text.prefix_count)
        count.times do
          from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
          text.mark_set(:insert, from) if from
        end

        display_matches_count(text)
      end

      def display_matches_count(text)
        total = text.tag_ranges(TAG).size

        if total == 1
          VER.message "1 match found"
        elsif total > 1
          VER.message "#{total} matches found"
        else
          VER.message "No matches found"
        end
      end

      def prev(text, count = text.prefix_count)
        count.times do
          from, to = text.tag_prevrange(TAG, 'insert - 1 chars', '1.0')
          text.mark_set(:insert, from) if from
        end

        display_matches_count(text)
      end

      def next_word_under_cursor(text)
        word = text.get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        text.tag_all_matching(TAG, word, HIGHLIGHT)
        text.tag_lower(TAG)
        self.next(text)
      end

      def prev_word_under_cursor(text)
        word = text.get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        text.tag_all_matching(TAG, word, HIGHLIGHT)
        text.tag_lower(TAG)
        prev(text)
      end

      def char_right(text, count = text.prefix_count)
        VER.message 'Press the character to find to the right'

        text.major_mode.read 1 do |event|
          from, to = 'insert + 1 chars', 'insert lineend'
          regexp = Regexp.new(Regexp.escape(event[:unicode]))

          counter = 0
          text.search_all regexp, from, to do |match, pos, mark|
            text.mark_set :insert, pos
            counter += 1
            break if counter == count
          end
        end
      end

      def char_left(text, count = text.prefix_count)
        VER.message 'Press the character to find to the left'

        text.major_mode.read 1 do |event|
          from, to = 'insert', 'insert linestart'
          regexp = Regexp.new(Regexp.escape(event[:unicode]))

          counter = 0
          text.rsearch_all regexp, from, to do |match, pos, mark|
            text.mark_set(:insert, pos)
            counter += 1
            break if counter == count
          end
        end
      end

      def clear(text)
        text.tag_remove(TAG, 1.0, :end)
      end
    end
  end
end
