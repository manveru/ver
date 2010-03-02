module VER
  module Methods
    module Search
      HIGHLIGHT = {
        foreground: '#fff',
        background: '#660',
      }
      TAG = :search

      module_function

      def jump(text, needle)
        tag(text, needle)
        self.next(text)
      end

      def remove(text)
        text.tag_remove(TAG, 1.0, :end)
      end
      alias clear remove
      module_function :clear

      def status_next(text)
        status_common(text, '/'){ self.next(text) }
      end

      def status_prev(text)
        status_common(text, '?'){ prev(text) }
      end

      def status_common(text, question)
        text.ask question do |answer, action|
          case action
          when :modified
            incremental(text, answer)
          when :attempt
            incremental(text, answer, force = true)
            prev(text)
            yield
            :abort
          end
        end
      end

      def incremental(text, term, force = false)
        needle =
          case term
          when nil, false
            return
          when Regexp
            needle = term
          when String
            return if !force && term.size <= text.options.search_incremental_min
            return if term.empty?
            begin
              Regexp.new(term)
            rescue RegexpError, SyntaxError
              Regexp.escape(term)
            end
          else
            raise ArgumentError
          end

        tag(text, needle)
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
        tag(text, word)
        self.next(text)
      end

      def prev_word_under_cursor(text)
        word = text.get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        tag(text, word)
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

      def again(text)
        return unless needle = text.store(self, :last)
        tag(text, needle)
        self.next(text)
      end

      def tag(text, needle)
        text.store(self, :last, needle)
        text.tag_all_matching(TAG, needle, HIGHLIGHT)
        text.tag_lower(TAG)
      end
    end
  end
end
