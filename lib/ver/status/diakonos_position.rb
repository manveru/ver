module VER
  class Status
    class DiakonosPosition < Label
      def setup
        register :position
      end

      def to_s
        format % [
          text.count('1.0', 'insert', :lines) + 1,
          text.count('1.0', 'end', :lines),
          text.count('insert linestart', 'insert', :displaychars) + 1,
        ]
      end
    end
  end
end
