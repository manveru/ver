require 'ver/layout/tiling'

module VER
  class Layout
    module HorizontalTiling
      extend Tiling

      module_function

      def apply_masters(windows, center, step = 1.0 / windows.size)
        windows.each_with_index do |window, idx|
          evolve(window, relx: (step * idx), rely: 0.0,
                 relheight: center, relwidth: step)
        end
      end

      def apply_stacked(windows, center, step = 1.0 / windows.size)
        relheight = 1.0 - center

        windows.each_with_index do |window, idx|
          evolve(window, relx: (step * idx), rely: center,
                 relheight: relheight, relwidth: step)
        end
      end
    end
  end
end
