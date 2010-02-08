module VER
  class Status
    class Mode < Label
      def triggers
        ['<<Mode>>']
      end

      def to_s
        major = text.major_mode
        string = [ major.name, *major.minors.map(&:name) ].join(', ')
        "[#{string}]"
      end
    end
  end
end
