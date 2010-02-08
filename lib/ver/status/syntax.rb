module VER
  class Status
    class Syntax < Label
      def triggers
        ['<<Syntax>>']
      end

      def to_s
        text.syntax.name
      end
    end
  end
end
