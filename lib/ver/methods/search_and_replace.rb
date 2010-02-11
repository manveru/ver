module VER
  module Methods
    module SearchAndReplace
      HIGHLIGHT = Search::HIGHLIGHT
      TAG = :search_and_replace

      module_function

      def leave(text, old_mode, new_mode)
        text.tag_remove(TAG, 1.0, :end)
      end

      def enter(text, old_mode, new_mode)
        pattern = text.store(self, :pattern)
        text.tag_all_matching(TAG, pattern, HIGHLIGHT)
        from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        text.mark_set(:insert, from) if from

        VER.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def last_pattern(text)
        pattern = text.store(self, :pattern)
        pattern.inspect[1..-1] if pattern
      end

      def query(text)
        question = 'Replace pattern: /'
        value = last_pattern(text)

        text.ask question, value: value do |answer, action|
          case action
          when :modified
            begin
              regexp = answer_to_regex(answer)
              VER.warn ''
              VER.message(" => #{regexp.inspect}")
            rescue RegexpError, SyntaxError => ex
              VER.warn(ex.message)
            end
          when :attempt
            begin
              regexp = answer_to_regex(answer)
              VER.message(" => #{regexp.inspect}")
              VER.defer{ query_attempt(text, regexp) }
              :abort
            rescue RegexpError, SyntaxError => ex
              VER.warn(ex.message)
            end
          end
        end
      end

      def answer_to_regex(answer)
        answer << '/' unless answer =~ /\/[eimnosux]*$/
        eval("/#{answer}")
      end

      def query_attempt(text, pattern)
        question = "Replace %p with: " % [pattern]
        value = text.store(self, :replacement)
        text.ask question, value: value do |replacement, action|
          case action
          when :attempt
            query_done(text, pattern, replacement)
            :abort
          end
        end
      end

      def query_done(text, pattern, replacement)
        text.store(self, :pattern, pattern)
        text.store(self, :replacement, replacement)
        text.minor_mode(:control, :search_and_replace)
      end

      def replace_once(text)
        from, to = text.tag_nextrange(TAG, 'insert', 'end')
        text.replace(from, to, text.store(self, :replacement))
        text.tag_all_matching(TAG, text.store(self, :pattern), HIGHLIGHT)
        from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        text.mark_set(:insert, from) if from

        VER.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def replace_all(text)
        replacement = text.store(self, :replacement)
        from, to = text.tag_nextrange(TAG, 'insert', 'end')
        return unless from

        Undo.record text do |record|
          begin
            record.replace(from, to, replacement)
            text.mark_set(:insert, from)
            from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
          end while from
        end

        text.minor_mode(:search_and_replace, :control)
      end

      def next(text)
        from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        text.mark_set(:insert, from) if from

        VER.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def prev(text)
        from, to = text.tag_prevrange(TAG, 'insert', '1.0')
        text.mark_set(:insert, from) if from

        VER.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end
    end
  end
end
