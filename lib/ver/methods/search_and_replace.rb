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
        text.status_ask 'Replace pattern: ' do |pattern|
          text.store(self, :pattern, /#{pattern}/)

          VER.defer do
            text.status_ask "Replace #{pattern} with: " do |replacement|
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
