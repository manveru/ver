module VER
  class Text
    module Position
      include Comparable

      def bbox
        buffer.bbox(self)
      end

      def compare(op, other)
        buffer.compare(self, op, other)
      end

      def <=>(other)
        return  1 if compare('>',  other)
        return -1 if compare('<',  other)
        return  0 if compare('==', other)
      end

      def delete(*indices)
        buffer.delete(self, *indices)
      end

      def dlineinfo
        buffer.dlineinfo(self)
      end

      def dump(*options)
        buffer.dump(*options, self)
      end

      def get(*indices)
        buffer.get(self, *indices)
      end

      def insert(*args)
        buffer.insert(self, *args)
      end

      def see
        buffer.see(self)
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

      def linestart
        buffer.index("#{self} linestart")
      end

      def lineend
        buffer.index("#{self} lineend")
      end

      def inspect
        index.inspect
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

      def tags
        buffer.tags(self)
      end

      def tag_names
        buffer.tag_names(self)
      end

      def to_a
        index.to_a
      end
    end
  end
end
