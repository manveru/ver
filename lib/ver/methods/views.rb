module VER
  module Methods
    module Views
      def view_create
        VER.layout.create_view
      end

      def view_remove
        VER.layout.remove_view
      end

      def view_focus_next
        VER.layout.focus_next
      end

      def view_focus_prev
        VER.layout.focus_prev
      end
    end
  end
end
