module VER
  class TilingLayout
    module VerticalTiling
      extend CommonTiling

      module_function

      def apply_masters(windows, center, step = 1.0 / windows.size)
        windows.each_with_index do |window, idx|
          evolve(window, relx: 0.0, rely: (step * idx),
                         relheight: step, relwidth: center)
        end
      end

      def apply_stacked(windows, center, step = 1.0 / windows.size)
        relwidth = 1.0 - center

        windows.each_with_index do |window, idx|
          evolve(window, relx: center, rely: (step * idx),
                         relheight: step, relwidth: relwidth)
        end
      end
    end
  end
end
