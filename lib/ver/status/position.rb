module VER
  class Status
    class Position < Label
      def setup
        register :position
      end

      def to_s
        "%4d,%3d" % [
          buffer.count('1.0', 'insert', :lines) + 1,
          buffer.count('insert linestart', 'insert', :displaychars)
        ]
      end
    end
  end
end
