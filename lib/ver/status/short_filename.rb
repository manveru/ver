module VER
  class Status
    class ShortFilename < Label
      def setup
        register :filename
      end

      def to_s
        buffer.short_filename
      end
    end
  end
end
