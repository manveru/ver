module VER
  class Status
    class Encoding < Label
      def setup
        register :encoding
      end

      def to_s
        buffer.encoding.name
      end
    end
  end
end
