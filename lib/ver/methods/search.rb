module VER
  module Methods
    module Search
      HIGHLIGHT = {
        foreground: '#fff',
        background: '#660',
      }
      TAG = :search

      module_function

      def jump(buffer, needle)
        tag(buffer, needle)
        self.next(buffer)
      end

      def remove(buffer)
        buffer.tag_remove(TAG, 1.0, :end)
      end
      alias clear remove
      module_function :clear

      def status_next(buffer)
        status_common(buffer, '/'){ self.next(buffer) }
      end

      def status_prev(buffer)
        status_common(buffer, '?'){ prev(buffer) }
      end

      def status_common(buffer, question)
        buffer.ask question do |answer, action|
          case action
          when :modified
            incremental(buffer, answer)
          when :attempt
            incremental(buffer, answer, force = true)
            prev(buffer)
            yield
            :abort
          end
        end
      end

      def incremental(buffer, term, force = false)
        needle =
          case term
          when nil, false
            return
          when Regexp
            needle = term
          when String
            return if !force && term.size <= buffer.options.search_incremental_min
            return if term.empty?
            begin
              Regexp.new(term)
            rescue RegexpError, SyntaxError
              Regexp.escape(term)
            end
          else
            raise ArgumentError
          end

        tag(buffer, needle)
        from, to = buffer.tag_nextrange(TAG, 1.0, :end)
        buffer.see(from) if from
      end

      def first(buffer)
        from, to = buffer.tag_nextrange(TAG, 1.0, :end)
        buffer.mark_set(:insert, from) if from
      end

      def last(buffer)
        from, to = tag_prevrange(TAG, :end, 1.0)
        buffer.mark_set(:insert, from) if from
      end

      def next(buffer, count = buffer.prefix_count)
        count.times do
          from, to = buffer.tag_nextrange(TAG, 'insert + 1 chars', 'end')
          buffer.mark_set(:insert, from) if from
        end

        display_matches_count(buffer)
      end

      def display_matches_count(buffer)
        total = buffer.tag_ranges(TAG).size

        if total == 1
          VER.message "1 match found"
        elsif total > 1
          VER.message "#{total} matches found"
        else
          VER.message "No matches found"
        end
      end

      def prev(buffer, count = buffer.prefix_count)
        count.times do
          from, to = buffer.tag_prevrange(TAG, 'insert - 1 chars', '1.0')
          buffer.mark_set(:insert, from) if from
        end

        display_matches_count(buffer)
      end

      def next_word_under_cursor(buffer)
        word = buffer.get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        tag(buffer, word)
        self.next(buffer)
      end

      def prev_word_under_cursor(buffer)
        word = buffer.get('insert wordstart', 'insert wordend')
        return if word.squeeze == ' ' # we don't want to match space
        tag(buffer, word)
        prev(buffer)
      end

      def char_right(buffer, count = buffer.prefix_count)
        VER.message 'Press the character to find to the right'

        buffer.major_mode.read 1 do |event|
          from, to = 'insert + 1 chars', 'insert lineend'
          regexp = Regexp.new(Regexp.escape(event[:unicode]))

          counter = 0
          buffer.search_all regexp, from, to do |match, pos, mark|
            buffer.mark_set :insert, pos
            counter += 1
            break if counter == count
          end
        end
      end

      def char_left(buffer, count = buffer.prefix_count)
        VER.message 'Press the character to find to the left'

        buffer.major_mode.read 1 do |event|
          from, to = 'insert', 'insert linestart'
          regexp = Regexp.new(Regexp.escape(event[:unicode]))

          counter = 0
          buffer.rsearch_all regexp, from, to do |match, pos, mark|
            buffer.mark_set(:insert, pos)
            counter += 1
            break if counter == count
          end
        end
      end

      def again(buffer)
        return unless needle = buffer.store(self, :last)
        tag(buffer, needle)
        self.next(buffer)
      end

      def tag(buffer, needle)
        buffer.store(self, :last, needle)
        buffer.tag_all_matching(TAG, needle, HIGHLIGHT)
        buffer.tag_lower(TAG)
      end
    end
  end
end
