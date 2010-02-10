module VER
  class Status
    class Encoding < Label
      def setup
        register :encoding
      end

      def to_s
        text.encoding.name
      end
    end
  end
end
