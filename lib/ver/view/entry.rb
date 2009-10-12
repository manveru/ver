module VER
  class View
    # This sucks, should we go method_missing?
    class Entry < VER::Entry
      attr_accessor :list_view

      def pick_first
        list_view.pick_first
      end

      def pick_selection
        list_view.pick_selection
      end

      def cancel
        list_view.cancel
      end

      def go_line_up
        list_view.go_line_up
      end

      def go_line_down
        list_view.go_line_down
      end
    end
  end
end