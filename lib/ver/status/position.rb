module VER
  class Status
    class Position < Label
      def setup
        register :position
      end

      def to_s
        lines = buffer.count('1.0', 'insert', :lines) + 1
        chars = buffer.count('insert linestart', 'insert', :displaychars)
        '%4d,%3d' % [lines, chars]
      end
    end
  end
end
