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
    end
  end
end