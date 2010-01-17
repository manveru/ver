module VER::Methods
  module Entry
    space, word = /[^[:alnum:]]+/, /[[:alnum:]]/
    FORWARD_WORD = /#{space}+#{word}|#{word}+#{space}+#{word}/
    BACKWARD_WORD = /#{word}+/

    class << self
      # Accept the line regardless of where the cursor is.
      # If this line is non-empty, it will be added to the history list.
      # If the line is a modified history line, the history line is restored to
      # its original state.
      def accept_line(entry)
        line = entry.get
        Event.generate(entry, '<<AcceptLine>>')
        entry.delete(0, :end)
      end

      # Move to end of the entry line
      def end_of_line(entry)
        entry.cursor = :end
      end

      # Insert X selection at cursor position
      def insert_selection(entry)
        entry.insert(entry.cursor, Tk::Selection.get)
      end

      # Insert a literal tab character at cursor position
      def insert_tab(entry)
        entry.insert(entry.cursor, "\t")
      end

      # Move forward a character.
      def next_char(entry, count = 1)
        entry.cursor += count
      end

      # Move forward to the end of the next word.
      # Words are composed of alphanumeric characters (letters and digits).
      def next_word(entry, count = 1)
        count.times do
          return unless md = entry.get.match(FORWARD_WORD, cursor)
          entry.cursor = md.offset(0).last
        end
      end

      # Move backward to the previous character.
      def prev_char(entry, count = 1)
        entry.cursor -= count
      end

      # Move back to the start of the current or previous word.
      # Words are composed of alphanumeric characters (letters and digits).
      def prev_word(entry, count = 1)
        line = entry.get.reverse
        count.times do
          pos = entry.get.size - entry.cursor

          return unless md = line.match(BACKWARD_WORD, pos)
          entry.cursor = (line.size - md.offset(0).last)
        end
      end

      # Move to the start of the current line.
      def start_of_line(entry)
        entry.cursor = 0
      end

      def transpose_chars(entry)
        char = entry.get[entry.cursor]
        entry.delete(entry.cursor)
        entry.insert(entry.cursor - 1, char)
      end

      def kill_motion(motion, count = 1)
        p kill_motion: [motion, count]
        kill(*virtual_movement(motion, count))
      end

      def insert_string(entry, string)
        entry.insert(entry.cursor, string)
      end

      def ask_abort(entry)
        entry.question = ''
        entry.value = entry.backup_value
        entry.text.focus
      end

      def ask_submit(entry)
        answer = entry.value
        # history = HISTORY[@question]
        # history.uniq!
        # history << answer
        entry.question = ''

        case result = entry.callback.call(answer)
        when String
          entry.message(result)
        when Symbol
          result
        else
          entry.message(result.inspect)
        end
      end
    end
  end
end
