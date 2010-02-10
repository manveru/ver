module VER
  class Status
    class Filename < Label
      def setup
        register :filename
      end

      def to_s
        text.filename.to_s
      end
    end
  end
end
