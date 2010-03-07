module VER
  class Status
    class DiakonosPosition < Label
      def setup
        register :position
      end

      def to_s
        format % [
          buffer.count('1.0', 'insert', :lines) + 1,
          buffer.count('1.0', 'end', :lines),
          buffer.count('insert linestart', 'insert', :displaychars) + 1,
        ]
      end
    end
  end
end
