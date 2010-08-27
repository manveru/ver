module VER
  module Methods
    module Search
      HIGHLIGHT = {
        foreground: '#fff',
        background: '#660',
      }
      TAG = :search

      CHAR_OPPOSITES = {
        char_left: :char_right,
        char_right: :char_left,
        till_char_left: :till_char_right,
        till_char_right: :till_char_left,
      }

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
            buffer.look_at(buffer.at_insert)
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
        buffer.look_at(from) if from
      end

      def first(buffer)
        from, to = buffer.tag_nextrange(TAG, 1.0, :end)
        go(buffer, from)
      end

      def last(buffer)
        from, to = tag_prevrange(TAG, :end, 1.0)
        go(buffer, from)
      end

      def next(buffer, count = buffer.prefix_count)
        count.times do
          from, to = buffer.tag_nextrange(TAG, 'insert + 1 chars', 'end')
          go(buffer, from)
        end

        display_matches_count(buffer)
      end

      def display_matches_count(buffer)
        total = buffer.tag_ranges(TAG).size

        if total == 1
          buffer.message "1 match found"
        elsif total > 1
          buffer.message "#{total} matches found"
        else
          buffer.message "No matches found"
        end
      end

      def prev(buffer, count = buffer.prefix_count)
        count.times do
          from, to = buffer.tag_prevrange(TAG, 'insert - 1 chars', '1.0')
          go(buffer, from)
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

      def char_common(buffer, name, action, count)
        buffer.major_mode.read 1 do |event|
          regexp = Regexp.new(Regexp.escape(event.unicode))
          buffer.store(self, :char_search, name)
          buffer.store(self, :char_search_regexp, regexp)
          send(action, buffer, regexp, count)
        end
      end

      def char_right(buffer, count = buffer.prefix_count)
        buffer.message 'Press the character to find to the right'
        char_common(buffer, :char_right, :char_right!, count)
      end

      def char_right!(buffer, regexp, count)
        from, to = 'insert + 1 chars', 'insert lineend'
        counter = 0
        buffer.search_all regexp, from, to do |match, pos, mark|
          buffer.insert = pos
          counter += 1
          return true if counter == count
        end

        false
      end

      def till_char_right(buffer, count = buffer.prefix_count)
        buffer.message 'Press the character to find to the right'
        char_common(buffer, :till_char_right, :till_char_right!, count)
      end

      def till_char_right!(buffer, regexp, count)
        return unless char_right!(buffer, regexp, count)
        buffer.at_insert.prev_char
      end

      def char_left(buffer, count = buffer.prefix_count)
        buffer.message 'Press the character to find to the left'
        char_common(buffer, :char_left, :char_left!, count)
      end

      def char_left!(buffer, regexp, count)
        from, to = 'insert', 'insert linestart'
        counter = 0

        buffer.rsearch_all regexp, from, to do |match, pos, mark|
          buffer.insert = pos
          counter += 1
          return true if counter == count
        end

        false
      end

      def till_char_left(buffer, count = buffer.prefix_count)
        buffer.message 'Press the character to find to the left'
        char_common(buffer, :till_char_left, :till_char_left!, count)
      end

      def till_char_left!(buffer, regexp, count)
        return unless char_left!(buffer, regexp, count)
        buffer.at_insert.next_char
      end

      # Repeat the last {char_left}, {char_right}, {till_char_left}, or
      # {till_char_right} search +count+ times.
      def again_char(buffer, count = buffer.prefix_count)
        if name = buffer.store(self, :char_search)
          if regexp = buffer.store(self, :char_search_regexp)
            send("#{name}!", buffer, regexp, count)
          else
            buffer.warn "Regexp missing, how weird!"
          end
        else
          buffer.warn "No previous char search, can't repeat."
        end
      end

      # Repeat the last {char_left}, {char_right}, {till_char_left}, or
      # {till_char_right} search +count+ times in the opposite direction.
      def again_char_opposite(buffer, count = buffer.prefix_count)
        if regexp = buffer.store(self, :char_search_regexp)
          if name = buffer.store(self, :char_search)
            opposite = CHAR_OPPOSITES.fetch(name)
            send("#{opposite}!", buffer, regexp, count)
          else
            buffer.warn "No previous char search, can't repeat."
          end
        else
          buffer.warn "Regexp missing, how weird!"
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

      def go(buffer, index)
        return unless index
        center(buffer, index)
        buffer.insert = index
      end

      def center(buffer, index)
        return unless index
        Control.cursor_vertical_center(buffer, index)
      end
    end
  end
end
