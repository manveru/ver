module VER
  class Status
    class Filename < Label
      def setup
        register :filename
      end

      def to_s
        buffer.filename.to_s
      end
    end
  end
end
