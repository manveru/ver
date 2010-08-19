module VER
  class Text
    class Mark < Struct.new(:buffer, :name)
      include Position

      MATCHING_BRACE_RIGHT = {
        '(' => ')',
        '{' => '}',
        '[' => ']',
        '<' => '>',
      }
      MATCHING_BRACE_LEFT = MATCHING_BRACE_RIGHT.invert

      def initialize(buffer, name, index = nil)
        self.buffer, self.name = buffer, name
        self.index = index unless index.nil?
      end

      # @return [Tk::TclString] tcl representation of {name}
      def to_tcl
        name.to_tcl
      end

      # @return [String] representation of {name}
      def to_s
        name.to_s
      end

      # @return [String] representation of {name} and {buffer}
      def inspect
        "#<VER::Text::Mark %p on %p>" % [name, buffer]
      end

      # Number of characters from the start of the line.
      # Counting characters starts at zero.
      #
      # @return [Integer] Number of characters from the line-start.
      def char
        index.char
      end

      # The number of lines from the top of {buffer}.
      # Counting lines starts at one.
      #
      # @return [Integer] Number of lines from top of buffer.
      def line
        index.line
      end

      def line=(line)
        set("#{line}.#{char}")
      end

      def char=(char)
        set("#{line}.#{char}")
      end

      def gravity=(direction)
        buffer.mark_gravity(self, direction)
      end

      def gravity
        buffer.mark_gravity(self)
      end

      def set(index)
        buffer.mark_set(self, index)
      end
      alias index= set

      def unset
        buffer.mark_unset(self)
      end

      def next
        buffer.mark_next(self)
      end

      def previous
        buffer.mark_previous(self)
      end

      def index
        buffer.index(self)
      end

      # Create a Range from a "virtual" movement.
      # This means that you pass a block that changes the position of the insert
      # mark, and this method will return a Range consists of the old and new
      # position.
      # The method yields self, so you can use the Symbol#to_proc shortcut as
      # well as predefined blocks or other methods that take the Insert as
      # argument.
      #
      # @example usage
      #   insert = buffer.at_insert
      #   insert.virtual(&:next_char).delete # delete to next character
      #   insert.virtual{|ins| ins.last_char }.copy # copy until end of line
      def virtual(*args)
        pos = index
        yield(self, *args)
        mark = index
        set(pos)
        return Range.new(buffer, *[pos, mark].sort)
      end

      def virtual_motion(motion, *args)
        virtual do |mark|
          if motion.respond_to?(:call)
            motion.call(buffer, *args)
          else
            mark.send(motion, *args)
          end
        end
      end

      def copying(motion, *args)
        virtual_motion(motion, *args).copy
      end

      def changing(motion, *args)
        virtual_motion(motion, *args).change
      end

      # if the motion is up-down, we might want to kill whole lines?
      # that's what vim does, but i don't find it very intuitive or easy to
      # implement.
      def killing(motion, *args)
        virtual_motion(motion, *args).kill
      end

      def deleting(motion, *args)
        virtual_motion(motion, *args).delete
      end

      def toggle_casing(motion, *args)
        virtual_motion(motion, *args).toggle_case!
      end

      def lower_casing(motion, *args)
        virtual_motion(motion, *args).lower_case!
      end

      def upper_casing(motion, *args)
        virtual_motion(motion, *args).upper_case!
      end

      def encoding_rot13(motion, *args)
        virtual_motion(motion, *args).encode_rot13!
      end

      # {word_right_end} goes to the last character, that is, the insert mark is
      # between the second to last and last character.
      # This means that the range to delete is off by one, account for it here.
      def change_next_word_end
        range = buffer.at_insert.virtual(&:next_word_end)
        range.last += '1 chars'
        range.kill
        buffer.minor_mode(:control, :insert)
      end

      def change_at(motion, *args)
        if motion.respond_to?(:call)
          motion.call(buffer, *args)
        else
          send(motion, *args)
        end

        buffer.minor_mode(:control, :insert)
      end

      def insert(string, *rest)
        buffer.insert(self, string, *rest)
      end

      def <<(string)
        buffer.insert(self, string)
        self
      end

      def delete(amount)
        case amount
        when Integer
          buffer.delete(self, self + "#{amount} chars")
        when Float, String, Symbol
          buffer.delete(self, amount)
        else
          raise ArgumentError
        end
      end

      def insert_selection
        self << Tk::Selection.get(type: 'UTF8_STRING')
      end

      def insert_tab
        self << "\t"
      end

      def insert_newline
        if buffer.options.autoindent
          insert_indented_newline
        else
          self << "\n"
        end
      end

      def insert_indented_newline
        buffer.undo_record do |record|
          indent1 = get('linestart', 'lineend')[/^\s*/]
          record.insert(self, "\n")

          indent2 = get('linestart', 'lineend')[/^\s*/]
          record.replace(
            "#{self} linestart",
            "#{self} linestart + #{indent2.size} chars",
            indent1
          )

          Methods::Control.clean_line(buffer, "#{self} - 1 line", record)
        end
      end

      def insert_newline_below
        return insert_indented_newline_below if buffer.options.autoindent
        set "#{self} lineend"
        self << "\n"
      end

      def insert_indented_newline_below
        line = get('linestart', 'lineend')
        indent = line[/^\s*/]
        set "#{self} lineend"
        self << "\n#{indent}"
      end

      def insert_newline_above
        if char > 1
          set(self - '1 line')
          insert_newline_below
        else
          buffer.undo_record do |record|
            record.insert("#{self} linestart", "\n")
            set "#{self} - 1 line"
            Methods::Control.clean_line(buffer, "#{self} - 1 line", record)
          end
        end
      end

      # Set mark to be +count+ display-chars to the right.
      # Stays on the same line.
      def next_char(count = buffer.prefix_count)
        return if self == lineend
        set(self + "#{count} displaychars")
      end

      def next_word(count = buffer.prefix_count)
        forward_jump(count, &method(:word_char_type))
      end

      def next_chunk(count = buffer.prefix_count)
        forward_jump(count, &method(:chunk_char_type))
      end

      # Jump to the last character of the word the insert cursor is over
      # currently.
      def next_word_end(count = buffer.prefix_count)
        forward_jump_end(count, &method(:word_char_type))
      end

      # Jump to the last character of the chunk the insert cursor is over
      # currently.
      def next_chunk_end(count = buffer.prefix_count)
        forward_jump_end(count, &method(:chunk_char_type))
      end

      # Set mark to be +count+ display-chars to the left.
      # Jumps to previous line when on first character of a line.
      def prev_char(count = buffer.prefix_count)
        return if self == linestart
        set(self - "#{count} displaychars")
      end

      def prev_word(count = buffer.prefix_count)
        backward_jump(count, &method(:word_char_type))
      end

      def prev_chunk(count = buffer.prefix_count)
        backward_jump(count, &method(:chunk_char_type))
      end

      def prev_word_end(count = buffer.prefix_count)
        set(index_at_word_left_end(count))
      end

      def first_line(line = buffer.prefix_count)
        go_first_nonblank(buffer.index("#{line}.0"))
      end

      def last_line(line = buffer.prefix_count(:end))
        if line == :end
          go_first_nonblank(buffer.index("end - 1 chars"))
        else
          go_first_nonblank(buffer.index("#{line}.0"))
        end
      end

      def go_first_nonblank(index)
        line = index.get('linestart', 'lineend')

        if first_nonblank = (line =~ /\S/)
          set("#{index.line}.#{first_nonblank}")
        else
          set("#{index.line}.0")
        end
      end

      def go_char(char = buffer.prefix_count(0))
        set("#{self} linestart + #{char} display chars")
      end

      def go_line_char(line = nil, char = nil)
        set("#{line || self.line}.#{char || self.char}")
      end


      # Go to {count} percentage in the file, on the first non-blank in the line
      # linewise. To compute the new line number this formula is used:
      # ({count} * number-of-lines + 99) / 100
      def go_percent(count = buffer.prefix_count(nil))
        raise ArgumentError unless count
        number_of_lines = buffer.count('1.0', 'end', :lines)
        line = (count * number_of_lines + 99) / 100
        go_first_nonblank(buffer.index("#{line}.0"))
      end

      def down_nonblank(count = buffer.prefix_count)
        offset = (count - 1).abs
        go_first_nonblank(buffer.index("insert + #{offset} lines"))
      end

      def prev_line_nonblank(count = buffer.prefix_count)
        go_first_nonblank(buffer.index("insert - #{count} lines"))
      end

      def next_line_nonblank(count = buffer.prefix_count)
        go_first_nonblank(buffer.index("insert + #{count} lines"))
      end

      def start_of_buffer
        set('1.0')
      end

      def end_of_buffer(count = nil)
        if count
          set("#{count}.0")
        else
          set(:end)
        end
      end

      # Move to the end of the line where mark is located.
      #
      # With +count+ it moves to the end of line +count+ lines below.
      def last_char(count = buffer.prefix_count)
        set("#{self} + #{count - 1} lines lineend")
      end

      # Move to the middle of the display line.
      # Vim moves to the middle of the screen width...
      # not so useful, but in order to be compatible, do that instead.
      def middle_of_line
        x, y, width, height, baseline = *buffer.dlineinfo(self)
        middle = width / 2
        set("@#{middle},#{y}")
      end

      # Move to the beginning of the line in which insert mark is located.
      #
      # With +count+ it will move to the beginning of the display line, which
      # takes line wraps into account.
      def start_of_line(alternative = buffer.prefix_arg)
        if alternative
          set("#{self} display linestart")
        else
          set("#{self} linestart")
        end
      end

      # Move to the non-blank character of the line in which insert mark is located.
      def home_of_line
        char = get('linestart', 'lineend').index(/\S/) || 0
        self.char = char
      end

      def end_of_sentence(count = buffer.prefix_count)
        buffer.search_all(/\.\s/, self) do |match, from, to|
          set("#{to} - 1 chars")
          count -= 1
          return if count <= 0
        end
      end

      def matching_brace(count = buffer.prefix_count)
        from, to = matching_brace_indices(count)
        index = self.index

        if index < from
          set(from)
        elsif index == from
          set(to)
        elsif index > to
          set(to)
        elsif index == to
          set(from)
        else
          if from.delta(index) < to.delta(index)
            set(from)
          else
            set(to)
          end
        end
      end

      def matching_brace_indices(count = 1)
        needle = Regexp.union(MATCHING_BRACE_RIGHT.to_a.flatten.sort.uniq)
        from = buffer.search_all(needle, self){|match, range| break range }
        return unless from

        opening = from.get

        if closing = MATCHING_BRACE_RIGHT[opening]
          start = from + '1 chars'
          search = buffer.method(:search_all)
        elsif closing = MATCHING_BRACE_LEFT[opening]
          start = from.index
          search = buffer.method(:rsearch_all)
        else
          return
        end

        balance = count
        needle = Regexp.union(opening, closing)
        search.call(needle, start){|match, range|
          case match
          when opening
            balance += 1
          when closing
            balance -= 1
          end

          if balance == 0
            return [from, range].sort
          end
        }
      end

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

      def forward_jump(count)
        count.times do
          original_type = type = yield(get)
          changed = 0

          begin
            original_pos = index
            buffer.execute_only(:mark, :set, self, "#{self} + 1 chars")
            break if original_pos == index

            type = yield(get)
            changed += 1 if type != original_type
            original_type = type
          end until changed > 0 && type != :space
        end
      rescue => ex
        VER.error(ex)
      end

      def forward_jump_end(count)
        offset = 1
        last = buffer.index('end')

        count.times do
          pos  = buffer.index("#{self} + #{offset} chars")

          return if pos == last

          type = yield(pos.get)

          while type == :space
            offset += 1
            pos = buffer.index("#{self} + #{offset} chars")
            break if pos == last
            type = yield(pos.get)
          end

          lock = type

          while type == lock && type != :space
            offset += 1
            pos = buffer.index("#{self} + #{offset} chars")
            break if pos == last
            type = yield(pos.get)
          end
        end

        set("#{self} + #{offset - 1} chars")
      rescue => ex
        VER.error(ex)
      end

      def backward_jump(count)
        count.times do
          original_type = type = yield(get)
          changed = 0

          begin
            original_pos = index
            buffer.execute_only(:mark, :set, self, "#{self} - 1 chars")
            break if original_pos == index

            type = yield(get)
            changed += 1 if type != original_type
            original_type = type
          end until changed > 0 && type != :space

          type = yield(get('- 1 chars'))

          while type == original_type
            original_pos = index
            buffer.execute_only(:mark, :set, self, "#{self} - 1 chars")
            break if original_pos == index

            type = yield(get('- 1 chars'))
          end
        end
      rescue => ex
        VER.error(ex)
      end
    end
  end
end
