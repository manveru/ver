module VER
  class Layout
    module Tiling
      DEFAULT = { master: 1, stacking: 3, center: 0.5 }

      def prepare(layout, given_options)
        options = DEFAULT.merge(given_options)
        slaves = layout.stack
        master, stacking = options.values_at(:master, :stacking)
        given_options.merge!(options)
        head, tail, hidden = slaves[0...master], slaves[master..stacking], slaves[(stacking + 1)..-1]
        return head, tail, hidden, options
      end

      def apply(layout, given_options = {})
        masters, stacked, hidden, options = prepare(layout, given_options)

        center = stacked.size == 0 ? 1.0 : options[:center]

        apply_hidden(hidden) if hidden
        apply_masters(masters, center) if masters
        apply_stacked(stacked, center) if stacked
      end

      def apply_hidden(windows)
        windows.each(&:place_forget)
      end

      def evolve(window, target)
        window.place(target)
      end
    end
  end
end
