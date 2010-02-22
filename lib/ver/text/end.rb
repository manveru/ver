module VER
  class Text
    class End < Mark
      def initialize(buffer)
        super(buffer, :end)
      end

      # ignore
      def set(index)
      end
      alias index= set
    end
  end
end
