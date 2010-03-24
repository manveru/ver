module VER
  class Text
    class Range < Struct.new(:buffer, :first, :last)
      def change
        kill
        buffer.minor_mode(:control, :insert)
      end

      def copy
        buffer.with_register{|reg| reg.value = get }
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

      def encode_rot13!(record = buffer)
        record.replace(*self, get.tr('A-Ma-mN-Zn-z', 'N-Zn-zA-Ma-m'))
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

      def lower_case!(record = buffer)
        record.replace(*self, get.downcase)
      end
      alias downcase! lower_case!

      def replace(*args)
        buffer.replace(first, last, *args)
      end

      def to_a
        [first, last]
      end

      def toggle_case!(record = buffer)
        record.replace(*self, get.tr('a-zA-Z', 'A-Za-z'))
      end
      # alias needed?

      def upper_case!(record = buffer)
        record.replace(*self, get.upcase)
      end
      alias upcase! upper_case!
    end
  end
end
