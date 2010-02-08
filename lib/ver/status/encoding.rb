module VER
  class Status
    class Encoding < Label
      def triggers
        ['<<Encoding>>']
      end

      def to_s
        text.encoding.name
      end
    end
  end
end
