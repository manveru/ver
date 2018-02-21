module VER
  class Status
    class Mode < Label
      def setup
        register :mode
      end

      def to_s
        major = buffer.major_mode
        string = [major.name, *major.minors.map(&:name)].join(', ')
        "[#{string}]"
      end
    end
  end
end
