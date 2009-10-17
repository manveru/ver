module VER
  module Methods
    module Views
      def view_create
        view.create
      end

      def view_close
        view.close
      end

      def view_focus_next
        view.focus_next
      end

      def view_focus_prev
        view.focus_prev
      end

      def view_push_up
        view.push_up
      end

      def view_push_down
        view.push_down
      end

      def view_push_top
        view.push_top
      end

      def view_push_bottom
        view.push_bottom
      end
    end
  end
end