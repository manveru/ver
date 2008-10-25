require 'ver/view/info'

module VER
  class View
    class Status < Info
      LAYOUT = {
        :height => 1,
        :top => lambda{|height| height - 2 },
        :left => 0,
        :width => lambda{|width| width }
      }

      def initialize(*args)
        super
        @color = Color[:white, :blue]
      end
    end
  end
end
