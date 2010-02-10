module VER
  class Status
    class Syntax < Label
      def setup
        register :syntax
      end

      def to_s
        format % text.syntax.name
      end
    end
  end
end
