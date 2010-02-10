module VER
  class Status
    class ShortFilename < Label
      def setup
        register :filename
      end

      def to_s
        text.short_filename
      end
    end
  end
end
