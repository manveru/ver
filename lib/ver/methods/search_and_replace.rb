module VER
  module Methods
    module SearchAndReplace
      HIGHLIGHT = Search::HIGHLIGHT
      TAG = :search_and_replace

      def self.leave(text, old_mode, new_mode)
        text.tag_remove(TAG, 1.0, :end)
      end

      def self.enter(text, old_mode, new_mode)
        pattern = text.store(self, :pattern)
        text.tag_all_matching(TAG, pattern, HIGHLIGHT)
        from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        text.mark_set(:insert, from) if from

        VER.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def self.query(text)
        if old_pattern = text.store(self, :pattern)
          old_pattern = old_pattern.inspect[1..-1]
        end

        text.status_ask 'Replace pattern: /', value: old_pattern do |pattern|
          pattern << '/i' unless pattern =~ /\/[ixm]*$/

          begin
            regexp = eval("/#{pattern}")
          rescue RegexpError, SyntaxError
            regexp = Regexp.new(Regexp.escape(term))
          end

          text.store(self, :pattern, regexp)

          VER.defer do
            old_replacement = text.store(self, :replacement)
            question = "Replace %p with: " % [regexp]
            text.status_ask question, value: old_replacement do |replacement|
              text.store(self, :replacement, replacement)
              text.minor_mode(:control, :search_and_replace)
            end
          end
        end
      end

      def self.replace_once(text)
        from, to = text.tag_nextrange(TAG, 'insert', 'end')
        text.replace(from, to, text.store(self, :replacement))
        text.tag_all_matching(TAG, text.store(self, :pattern), HIGHLIGHT)
        from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        text.mark_set(:insert, from) if from

        VER.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def self.replace_all(text)
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
      end

      def self.next(text)
        from, to = text.tag_nextrange(TAG, 'insert + 1 chars', 'end')
        text.mark_set(:insert, from) if from

        VER.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end

      def self.prev(text)
        from, to = text.tag_prevrange(TAG, 'insert', '1.0')
        text.mark_set(:insert, from) if from

        VER.message 'Replace occurence (y)es (n)o (a)ll (q)uit'
      end
    end
  end
end
