module VER
  class Text
    # A Position is any kind of index in a Tk::Text widget, it may be a {Mark},
    # {Insert}, {End}, etc.
    # The Position relies on a buffer property being present, which should be
    # responding to the methods of {Tk::Text} that take at least one index.
    module Position
      include Comparable

      def bbox
        buffer.bbox(self)
      end

      # Compare relationship with +other+ index using +op+.
      #
      # @param [#to_tcl] op
      #   one of <, <=, ==, >=, >, or !=
      # @param [#to_tcl] other
      #   another index to compare against
      # @return [Boolean] whether relationship is satisfied.
      def compare(op, other)
        buffer.compare(self, op, other)
      end

      # Used for {Comparable}.
      # Returns 1 if +other+ is after this position.
      # Returns -1 if +other is before this position.
      # Returns 0 if they are equal.
      #
      # @param [#to_tcl] other
      #   another index to compare against
      # @return [Fixnum]
      def <=>(other)
        return  1 if compare('>',  other)
        return -1 if compare('<',  other)
        return  0 if compare('==', other)
      end

      # Kill contents of the line at position, switch from control to
      # insert mode.
      # Always leaves an empty line
      def change_line(count = buffer.prefix_count)
        kill_line
        buffer.minor_mode(:control, :insert)
      end

      def copy_line(count = buffer.prefix_count)
        from = "#{self} linestart"

        to =
          case count
          when 0, 1; "#{self} lineend + 1 chars"
          else     ; "#{self} + #{count - 1} lines lineend + 1 chars"
          end

        buffer.range(buffer.index(from), buffer.index(to)).copy
      end

      # Delete this and any other given +indices+ from the buffer.
      def delete(*indices)
        buffer.delete(self, *indices)
      end

      def delete_line(count = buffer.prefix_count)
        buffer.delete("#{self} linestart", "#{self} + #{count - 1} lines lineend + 1 chars")
      end

      def dlineinfo
        buffer.dlineinfo(self)
      end

      def delta(other)
        line_diff = other.line - line

        if line_diff == 0
          (other.char - char).abs
        else
          line_diff.abs
        end
      end

      def dump(*options)
        buffer.dump(*options, self)
      end

      def get(from = nil, to = nil)
        if from && to
          buffer.get("#{self} #{from}", "#{self} #{to}")
        elsif from
          buffer.get("#{self} #{from}")
        else
          buffer.get(self)
        end
      end

      def increase_number(count = buffer.prefix_count)
        return unless result = formatted_number(count)
        head, tail, number = *result
        buffer.replace(
          "#{self} - #{head.size} chars",
          "#{self} + #{tail.size} chars",
          number
        )
      end

      def decrease_number(count = buffer.prefix_count)
        return unless result = formatted_number(-count)
        head, tail, number = *result
        buffer.replace(
          "#{self} - #{head.size} chars",
          "#{self} + #{tail.size} chars",
          number
        )
      end

      def formatted_hex(number)
        if number > 0
          '%#x' % number
        elsif number == 0
          '0x0'
        else
          '-0x%x' % number.abs
        end
      end

      def formatted_binary(number)
        if number > 0
          '%#b' % number
        elsif number == 0
          '0b0'
        else
          '-0b%b' % number.abs
        end
      end

      def formatted_exponential(number, precicion)
        "%-.#{precicion}e" % number
      end

      def formatted_float(number, precicion)
        "%-.#{precicion}f" % number
      end

      def formatted_octal(number)
        if number > 0
          '%#o' % number
        elsif number == 0
          '00'
        else
          '-0%o' % number.abs
        end
      end

      def formatted_number(count)
        head = buffer.get("#{self} linestart", self)[/\S*$/]
        tail = buffer.get(self, "#{self} lineend")[/^\S*/]

        number =
          case chunk = head + tail
          when /^[+-]?0x\h+$/
            formatted_hex(Integer(chunk) + count)
          when /^[+-]?0b[01]+$/
            formatted_binary(Integer(chunk) + count)
          when /^[+-]?(\d+\.\d+|\d+)e[+-]?\d+$/
            precicion = $1[/\.(\d+)/, 1].to_s.size
            formatted_exponential(Float(chunk) + count, precicion)
          when /^[+-]?\d+\.(\d+)/
            formatted_float(Float(chunk) + count, $1.size)
          when /^[+-]?([1-9]\d*|0)$/
            "%-d" % [Integer(chunk) + count]
          when /^[+-]?0\d+$/
            formatted_octal(Integer(chunk) + count)
          else
            return
          end

        return head, tail, number
      end

      def inspect
        index.inspect
      end

      def insert(*args)
        buffer.insert(self, *args)
      end

      def kill_line(count = buffer.prefix_count)
        copy_line(count)
        delete_line(count)
      end

      def see
        buffer.see(self)
      end

      def linestart
        buffer.index("#{self} linestart")
      end

      def lineend
        buffer.index("#{self} lineend")
      end

      def tags
        buffer.tags(self)
      end

      def tag_names
        buffer.tag_names(self)
      end

      def to_a
        index.to_a
      end

      def toggle_case!(count = buffer.prefix_count)
        buffer.range(self, self + "#{count} displaychars").toggle_case!
      end

      def +(arg)
        case arg
        when Integer
          buffer.index("#{self} + #{arg} chars")
        else
          buffer.index("#{self} + #{arg}")
        end
      end

      def -(arg)
        case arg
        when Integer
          buffer.index("#{self} - #{arg} chars")
        else
          buffer.index("#{self} - #{arg}")
        end
      end
    end
  end
end
