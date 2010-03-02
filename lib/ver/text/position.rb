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

      def change_line
        kill_line
        buffer.minor_mode(:control, :insert)
      end

      def copy_line
        content = buffer.get("#{self} linestart", "#{self} lineend + 1 chars")
        Methods::Clipboard.copy(buffer, content)
      end

      # Delete this and any other given +indices+ from the buffer.
      def delete(*indices)
        buffer.delete(self, *indices)
      end

      def delete_line
        buffer.delete("#{self} linestar", "#{self} lineend + 1 chars")
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

      def inspect
        index.inspect
      end

      def insert(*args)
        buffer.insert(self, *args)
      end

      def kill_line
        copy_line
        delete_line
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
