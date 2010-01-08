module VER
  class View
    # This sucks, should we go method_missing?
    class Entry < VER::Entry
      attr_accessor :list_view, :mode

      def pick_first
        list_view.pick_first
      end

      def pick_selection
        list_view.pick_selection
      end

      def cancel
        list_view.cancel
      end

      def line_up
        list_view.line_up
      end

      def line_down
        list_view.line_down
      end

      def completion
        list_view.completion
      end
    end
  end
end
