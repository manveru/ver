module VER
  class Text
    class Range < Struct.new(:buffer, :first, :last)
      def first=(index)
        self[:first] = index.is_a?(Index) ? index : buffer.index(index)
      end

      def last=(index)
        self[:last] = index.is_a?(Index) ? index : buffer.index(index)
      end

      def get
        buffer.get(*self)
      end

      def count(*options)
        buffer.count(*self, *options)
      end

      def delete(*indices)
        buffer.delete(*self, *indices)
      end

      def kill
        Methods::Clipboard.copy(buffer, get)
        delete
      end

      def replace(text)
        buffer.replace(first, last, text)
      end

      def dump(*options)
        buffer.dump(*options, *self)
      end

      def to_a
        [first, last]
      end

      def inspect
        "#<VER::Text::Range %s on %p>" % ["(#{first}..#{last})", buffer]
      end
    end
  end
end
