module VER
  module Methods
    module Views
      def start_views_mode
        self.mode = :views
      end

      def view_change(method, *count)
        __send__(method, *count)
      end

      def view_focus(index = 0)
        return unless found = layout.views[index - 1]
        found.push_top
      end

      def view_find_or_create(file)
        view.find_or_create(file)
      end

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
        stacking = layout.options[:stacking]
        unless stacking >= layout.views.size
          layout.options[:stacking] += 1
          layout.apply
        end
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

      def view_master_shrink
        center = layout.options[:center]
        layout.options[:center] -= 0.1 if center > 0.1
        layout.apply
      end

      def view_master_grow
        center = layout.options[:center]
        layout.options[:center] += 0.1 if center < 0.9
        layout.apply
      end

      def view_cycle_next
        layout.cycle_next(view)
      end

      def view_cycle_prev
        layout.cycle_prev(view)
      end
    end
  end
end
