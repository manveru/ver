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

      def to_tcl
        name.to_tcl
      end

      def to_s
        name.to_s
      end

      def inspect
        "#<VER::Text::Mark %p on %p>" % [name, buffer]
      end

      def char
        index.char
      end

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
      #   insert.virtual{|ins| ins.end_of_line }.copy # copy until end of line
      def virtual(count = nil)
        pos = index
        yield(self, *count)
        mark = index
        set(pos)
        return Range.new(buffer, *[pos, mark].sort)
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
        self << Tk::Selection.get
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
            set 'insert - 1 line'
            Methods::Control.clean_line(buffer, "#{self} - 1 line", record)
          end
        end
      end

      def next_char(count = buffer.prefix_count)
        set(self + "#{count} displaychars")
      end

      def next_word(count = buffer.prefix_count)
        forward_jump(count, &method(:word_char_type))
      end

      def next_chunk(count = buffer.prefix_count)
        forward_jump(count, &method(:chunk_char_type))
      end

      def next_word_end(count = buffer.prefix_count)
        set(index_at_word_right_end(count))
      end

      def prev_char(count = buffer.prefix_count)
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

      def go_line(line = buffer.prefix_count)
        set("#{line}.0")
      end

      def go_char(char = buffer.prefix_count)
        set("#{self} linestart + #{char} chars")
      end

      def go_line_char(line = nil, char = nil)
        set("#{line || self.line}.#{char || self.char}")
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

      def start_of_line(alternative = buffer.prefix_arg)
        if alternative
          set("#{self} display linestart")
        else
          set("#{self} linestart")
        end
      end

      def home_of_line(alternative = buffer.prefix_arg)
        if alternative
          start_of_line(alternative)
        else
          char = get('linestart', 'lineend').index(/\S/) || 0
          self.char = char
        end
      end

      def end_of_sentence(count = buffer.prefix_count)
        buffer.search_all(/\.\s/, self) do |match, from, to|
          set("#{to} - 1 chars")
          count -= 1
          return if count <= 0
        end
      end

      def matching_brace(count = buffer.prefix_count)
        set(matching_brace_index(count))
      end

      def matching_brace_index(count = 1)
        opening = get

        if closing = MATCHING_BRACE_RIGHT[opening]
          start = self + '1 chars'
          search = buffer.method(:search_all)
        elsif closing = MATCHING_BRACE_LEFT[opening]
          start = index
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
            return range
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

      def index_at_word_right_end(count = buffer.prefix_count)
        offset = 1
        last = buffer.index('end')

        count.times do
          pos  = buffer.index("#{self} + #{offset} chars")

          return if pos == last

          type = word_char_type(pos.get)

          while type == :space
            offset += 1
            pos = buffer.index("#{self} + #{offset} chars")
            break if pos == last
            type = word_char_type(pos.get)
          end

          lock = type

          while type == lock && type != :space
            offset += 1
            pos = buffer.index("#{self} + #{offset} chars")
            break if pos == last
            type = word_char_type(pos.get)
          end
        end

        buffer.index("#{self} + #{offset - 1} chars")
      rescue => ex
        VER.error(ex)
      end
    end
  end
end
