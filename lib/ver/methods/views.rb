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

      def view_one
        layout.options.merge! master: 1, stacking: 0
        layout.apply
      end

      def view_two
        layout.options.merge! master: 1, stacking: 1
        layout.apply
      end

      def view_slave_inc
        layout.options[:stacking] += 1
        layout.apply
      end

      def view_slave_dec
        stacking = layout.options[:stacking]
        layout.options[:stacking] -= 1 if stacking > 0
        layout.apply
      end

      def view_master_inc
        layout.options[:master] += 1
        layout.apply
      end

      def view_master_dec
        master = layout.options[:master]
        layout.options[:master] -= 1 if master > 0
        layout.apply
      end
    end
  end
end