module VER::Methods
  module Move
    GO_MATCHING_RIGHT = {
      '(' => ')',
      '{' => '}',
      '[' => ']',
      '<' => '>',
    }
    GO_MATCHING_LEFT = GO_MATCHING_RIGHT.invert

    class << self
      def prefix_arg_sol(text)
        return if text.update_prefix_arg(text)
        start_of_line(text)
      end

      def matching_brace(text, count = text.prefix_count)
        opening = text.get(:insert)

        if closing = GO_MATCHING_RIGHT[opening]
          search = text.method(:search_all)
          level = 1
          start = 'insert + 1 chars'
        elsif closing = GO_MATCHING_LEFT[opening]
          search = text.method(:rsearch_all)
          level = 1
          start = 'insert'
        else
          return
        end

        needle = Regexp.union(opening, closing)

        search.call(needle, start) do |match, pos, from|
          if match == opening
            level += 1
          elsif match == closing
            level -= 1
          end

          if level < 1
            text.mark_set(:insert, pos)
            return
          end
        end
      end

      # Move cursor +count+ characters left.
      def prev_char(text, count = text.prefix_count)
        text.mark_set(:insert, "insert - #{count} displaychars")
      end

      # Move cursor +count+ characters right.
      def next_char(text, count = text.prefix_count)
        text.mark_set(:insert, "insert + #{count} displaychars")
      end

      # Move to the beginning of the line in which insert mark is located.
      #
      # With +count+ it will move to the beginning of the display line, which
      # takes line wraps into account.
      def start_of_line(text, count = text.prefix_count)
        if count
          text.mark_set(:insert, 'insert display linestart')
        else
          text.mark_set(:insert, 'insert linestart')
        end
      end

      # Move to the first character of the line in which insert mark is located.
      #
      # With +count+ it will move to the linestart of the displayed, taking
      # linewraps into account.
      def home_of_line(text, count = text.prefix_arg)
        if count
          start_of_line(text, true)
        else
          x = text.get('insert linestart', 'insert lineend').index(/\S/) || 0
          y = text.index('insert').y
          text.mark_set(:insert, "#{y}.#{x}")
        end
      end

      # Move to the end of the line where insert mark is located.
      #
      # With +count+ it moves to the end of the display line, so when there is
      # a line wrap it will move to the place where the line wraps instead of the
      # real end of the line.
      def end_of_line(text, count_or_mode = nil)
        case count_or_mode
        when Symbol
          text.mark_set(:insert, 'insert display lineend')
          text.minor_mode(:control, count_or_mode)
        when nil
          text.mark_set(:insert, 'insert lineend')
        else
          text.mark_set(:insert, 'insert display lineend')
        end
      end

      def go_line(text, number = 0)
        text.mark_set(:insert, "#{number}.0")
      end

      # Basically like [go_line] without arguments, but much nicer name.
      def start_of_file(text)
        text.mark_set(:insert, "1.0")
      end

      def end_of_file(text, count = text.prefix_arg)
        if count
          text.mark_set(:insert, "#{count}.0")
        else
          text.mark_set(:insert, :end)
        end
      end

      def end_of_sentence(text, count = text.prefix_count)
        text.search_all /\.\s/, 'insert' do |match, from, to|
          p match: match, from: from, to: to
          text.mark_set(:insert, "#{to} - 1 chars")
          count -= 1
          return if count <= 0
        end
      end

      def virtual(text, action, count = text.prefix_count)
        pos = text.index(:insert)

        if action.respond_to?(:call)
          action.call(text, count)
        else
          send(action, text, count)
        end

        mark = text.index(:insert)
        text.mark_set(:insert, pos)
        return [pos, mark].sort
      rescue => ex
        VER.error(ex)
      end

      def prev_line(text, count = text.prefix_count)
        up_down_line(text, -count.abs)
      end

      def next_line(text, count = text.prefix_count)
        up_down_line(text, count.abs)
      end

      def forward_scroll(text, count = text.prefix_count)
        count_abs = count.abs
        text.yview_scroll(count_abs, :units)
        next_line(text, count_abs)
      end

      def backward_scroll(text, count = text.prefix_count)
        count_abs = count.abs
        text.yview_scroll(-count_abs, :units)
        prev_line(text, count_abs)
      end

      def next_word(text, count = text.prefix_count)
        forward_jump(text, count, &method(:word_char_type))
      end

      def next_chunk(text, count = text.prefix_count)
        forward_jump(text, count, &method(:chunk_char_type))
      end

      # Jump to the last character of the word the insert cursor is over currently.
      def next_word_end(text, count = text.prefix_count)
        text.mark_set(:insert, index_at_word_right_end(text, count))
      end

      def prev_word(text, count = text.prefix_count)
        backward_jump(text, count, &method(:word_char_type))
      end

      def prev_chunk(text, count = text.prefix_count)
        backward_jump(text, count, &method(:chunk_char_type))
      end

      # HACK: but it's just too good to do it manually

      def prev_page(text, count = text.prefix_count)
        text.mark_set(:insert, text.tk_prev_page_pos(count))
      end

      def next_page(text, count = text.prefix_count)
        text.mark_set(:insert, text.tk_next_page_pos(count))
      end

      def index_at_word_right_end(text, count = text.prefix_count)
        offset = 1
        last = text.index('end')

        count.times do
          pos  = text.index("insert + #{offset} chars")

          return if pos == last

          type = word_char_type(text.get(pos))

          while type == :space
            offset += 1
            pos = text.index("insert + #{offset} chars")
            break if pos == last
            type = word_char_type(text.get(pos))
          end

          lock = type

          while type == lock && type != :space
            offset += 1
            pos = text.index("insert + #{offset} chars")
            break if pos == last
            type = word_char_type(text.get(pos))
          end
        end

        text.index("insert + #{offset - 1} chars")
      rescue => ex
        VER.error(ex)
      end

      private

      def word_char_type(char)
        case char
        when /\w/; :word
        when /\S/; :special
        when /\s/; :space
        else
          Kernel.raise "No matching char type for: %p" % [char]
        end
      end

      def chunk_char_type(char)
        case char
        when /\S/; :nonspace
        when /\s/; :space
        else
          Kernel.raise "No matching chunk type for: %p " % [char]
        end
      end

      def forward_jump(text, count)
        count.times do
          original_type = type = yield(text.get(:insert))
          changed = 0

          begin
            original_pos = text.index(:insert)
            text.execute_only(:mark, :set, :insert, 'insert + 1 chars')
            break if original_pos == text.index(:insert)

            type = yield(text.get(:insert))
            changed += 1 if type != original_type
            original_type = type
          end until changed > 0 && type != :space
        end

        Tk::Event.generate(text, '<<Movement>>')
      rescue => ex
        VER.error(ex)
      end

      def backward_jump(text, count)
        count.times do
          original_type = type = yield(text.get(:insert))
          changed = 0

          begin
            original_pos = text.index(:insert)
            text.execute_only(:mark, :set, :insert, 'insert - 1 chars')
            break if text.index(:insert) == original_pos

            type = yield(text.get(:insert))
            changed += 1 if type != original_type
            original_type = type
          end until changed > 0 && type != :space

          type = yield(text.get('insert - 1 chars'))

          while type == original_type
            original_pos = text.index(:insert)
            text.execute_only(:mark, :set, :insert, 'insert - 1 chars')
            break if text.index(:insert) == original_pos

            type = yield(text.get('insert - 1 chars'))
          end
        end

        Tk::Event.generate(text, '<<Movement>>')
      rescue => ex
        VER.error(ex)
      end

      # OK, finally found the issue.
      #
      # the implementation of tk::TextUpDownLine is smart, but not smart enough.
      # It doesn't assume large deltas between the start of up/down movement and
      # the last other modification of the insert mark.
      #
      # This means that, after scrolling with up/down for a few hundred lines,
      # it has to calculate the amount of display lines in between, which is a
      # very expensive calculation and time increases O(delta_lines).
      #
      # We'll try to solve this another way, by assuming that there are at least
      # a few other lines of same or greater length in between, we simply
      # compare against a closer position and make delta_lines as small as
      # possible.
      #
      # Now, if you go to, like column 100 of a line, and there is never a line
      # as long for the rest of the file, the scrolling will still slow down a
      # lot. This is an issue we can fix if we "forget" the @udl_pos_orig after
      # a user-defined maximum delta (something around 200 should do), will
      # implement that on demand.
      def up_down_line(text, count)
        target = text.up_down_line(count)
        text.mark_set(:insert, target)
      end
    end
  end
end
