module VER
  module Methods
    module SearchAndReplace
      HIGHLIGHT = Search::HIGHLIGHT
      TAG = :search_and_replace

      module_function

      def leave(buffer, old_mode, new_mode)
        buffer.tag_remove(TAG, 1.0, :end)
      end

      def enter(buffer, old_mode, new_mode)
        pattern = buffer.store(self, :pattern)
        buffer.tag_all_matching(TAG, pattern, HIGHLIGHT)
        from, to = buffer.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        Search.go(buffer, from)

        buffer.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def last_pattern(buffer)
        pattern = buffer.store(self, :pattern)
        pattern.inspect[1..-1] if pattern
      end

      def query(buffer)
        question = 'Replace pattern: /'
        value = last_pattern(buffer).to_s

        buffer.ask question, value: value do |answer, action|
          case action
          when :modified
            begin
              regexp = answer_to_regex(answer)
              Search.incremental(buffer, regexp)
              buffer.warn ''
              buffer.message("=> #{regexp.inspect}")
            rescue RegexpError, SyntaxError => ex
              buffer.warn(ex.message)
            end
          when :attempt
            begin
              regexp = answer_to_regex(answer)
              buffer.message("=> #{regexp.inspect}")
              query_attempt(buffer, regexp)
              :abort
            rescue RegexpError, SyntaxError => ex
              buffer.warn(ex.message)
            end
          end
        end
      end

      def answer_to_regex(answer)
        answer << '/' unless answer =~ /\/[eimnosux]*$/
        eval("/#{answer}")
      end

      def query_attempt(buffer, pattern)
        question = "Replace %p with: " % [pattern]
        value = buffer.store(self, :replacement)
        buffer.ask question, value: value do |replacement, action|
          case action
          when :attempt
            query_done(buffer, pattern, replacement)
            :abort
          end
        end
      end

      def query_done(buffer, pattern, replacement)
        buffer.store(self, :pattern, pattern)
        buffer.store(self, :replacement, replacement)
        buffer.minor_mode(:control, :search_and_replace)
      end

      def replace_once(buffer)
        begin
          from, to = buffer.tag_nextrange(TAG, 'insert', 'end')
          return unless from && to
        rescue => ex
          if ex.message.start_with?('bad text index ""')
            buffer.minor_mode(:search_and_replace, :control)
            buffer.message 'No more matches'
            return
          else
            raise(ex)
          end
        end

        buffer.replace(from, to, buffer.store(self, :replacement))
        buffer.tag_all_matching(TAG, buffer.store(self, :pattern), HIGHLIGHT)
        from, to = buffer.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        Search.go(buffer, from)

        buffer.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def replace_all(buffer)
        replacement = buffer.store(self, :replacement)
        from, to = buffer.tag_nextrange(TAG, 'insert', 'end')
        return unless from

        Undo.record buffer do |record|
          begin
            record.replace(from, to, replacement)
            buffer.mark_set(:insert, from)
            from, to = buffer.tag_nextrange(TAG, 'insert + 1 chars', 'end')
          end while from
        end

        buffer.minor_mode(:search_and_replace, :control)
      end

      def next(buffer)
        from, to = buffer.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        Search.go(buffer, from)

        buffer.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def prev(buffer)
        from, to = buffer.tag_prevrange(TAG, 'insert', '1.0')
        Search.go(buffer, from)

        buffer.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end
    end
  end
end
