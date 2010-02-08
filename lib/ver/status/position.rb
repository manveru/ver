module VER
  class Status
    class Position < Label
      def triggers
        ['<<Position>>']
      end

      def to_s
        "%4d,%3d" % [
          text.count('1.0', 'insert', :lines) + 1,
          text.count('insert linestart', 'insert', :displaychars)
        ]
      end
    end
  end
end
