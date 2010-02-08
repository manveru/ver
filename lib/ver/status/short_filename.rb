module VER
  class Status
    class ShortFilename < Label
      def triggers
        ['<<Filename>>']
      end

      def to_s
        text.short_filename
      end
    end
  end
end
