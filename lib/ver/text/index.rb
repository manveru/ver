module VER
  class Text
    class Index < Struct.new(:buffer, :index)
      include Position

      LINE = /^\d+/
      CHAR = /\d+$/

      def line
        index.to_s[LINE].to_i
      end

      def char
        index.to_s[CHAR].to_i
      end

      def to_tcl
        index
      end

      def to_s
        index.to_s
      end

      def to_a
        line, char = index.split('.')
        return line.to_i, char.to_i
      end

      def inspect
        "#<VER::Text::Index %p on %p>" % [index, buffer]
      end
    end
  end
end
