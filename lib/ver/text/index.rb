module VER
  class Text
    Index = Struct.new(:widget, :idx, :y, :x)
    class Index
      include Comparable

      def initialize(widget, idx)
        self.widget, self.idx = widget, idx.to_str
      end

      def to_index
        self
      end

      def <=>(other)
        self_idx, other_idx = idx, other.to_index.idx
        return  1 if widget.compare(self_idx, '>',  other_idx)
        return -1 if widget.compare(self_idx, '<',  other_idx)
        return  0 if widget.compare(self_idx, '==', other_idx)
      end

      def y
        self[:y] ||= idx.split('.', 2)[0].to_i
      end

      def x
        self[:x] ||= idx.split('.', 2)[1].to_i
      end

      def linestart
        "#{idx} linestart"
      end

      def lineend
        "#{idx} lineend"
      end

      def wordstart
        "#{idx} wordstart"
      end

      def wordend
        "#{idx} wordend"
      end

      def next
        self.class.new(widget, "#{y + 1}.#{x}")
      end

      def split
        return y, x
      end

      def inspect
        idx.inspect
      end

      def to_str
        idx
      end

      def to_s
        idx
      end

      def to_i
        y
      end

      def upto(other)
        if block_given?
          y.upto(other.y) do |line|
            yield self.class.new(widget, "#{line}.0")
          end
        else
          Enumerator.new(self, :upto, other)
        end
      end

      def is_a?(obj)
        obj == String || super
      end
    end
  end
end