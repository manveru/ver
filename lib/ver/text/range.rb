module VER
  class Text
    class Range < Struct.new(:buffer, :first, :last)
      def copy
        Methods::Clipboard.copy(buffer, get)
      end

      def count(*options)
        buffer.count(*self, *options)
      end

      def delete(*indices)
        buffer.delete(*self, *indices)
      end

      def dump(*options)
        buffer.dump(*options, *self)
      end

      def first=(index)
        self[:first] = index.is_a?(Index) ? index : buffer.index(index)
      end

      def get
        buffer.get(*self)
      end

      def inspect
        "#<VER::Text::Range %s on %p>" % ["(#{first}..#{last})", buffer]
      end

      def kill
        copy
        delete
      end

      def last=(index)
        self[:last] = index.is_a?(Index) ? index : buffer.index(index)
      end

      def replace(*args)
        buffer.replace(first, last, *args)
      end

      def to_a
        [first, last]
      end
    end
  end
end
