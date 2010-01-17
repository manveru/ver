module VER::Methods
  module Views
    class << self
      def self.call(widget, command, args)
        p call: args
      end

      def change(method, *count)
        __send__(method, *count)
      end

      def peer(text)
        text.create_peer
      end

      def focus(index = 0)
        return unless found = layout.views[index - 1]
        found.push_top
      end

      def find_or_create(text, file)
        text.view.find_or_create(file)
      end

      def create
        view.create
      end

      def close
        view.close
      end

      def focus_next
        view.focus_next
      end

      def focus_prev
        view.focus_prev
      end

      def push_up
        view.push_up
      end

      def push_down
        view.push_down
      end

      def push_top
        view.push_top
      end

      def push_bottom
        view.push_bottom
      end

      def one
        layout.options.merge! master: 1, stacking: 0
        layout.apply
      end

      def two
        layout.options.merge! master: 1, stacking: 1
        layout.apply
      end

      def slave_inc
        stacking = layout.options[:stacking]
        unless stacking >= layout.views.size
          layout.options[:stacking] += 1
          layout.apply
        end
      end

      def slave_dec
        stacking = layout.options[:stacking]
        layout.options[:stacking] -= 1 if stacking > 0
        layout.apply
      end

      def master_inc
        layout.options[:master] += 1
        layout.apply
      end

      def master_dec
        master = layout.options[:master]
        layout.options[:master] -= 1 if master > 0
        layout.apply
      end

      def master_shrink
        center = layout.options[:center]
        layout.options[:center] -= 0.1 if center > 0.1
        layout.apply
      end

      def master_grow
        center = layout.options[:center]
        layout.options[:center] += 0.1 if center < 0.9
        layout.apply
      end

      def cycle_next
        layout.cycle_next(view)
      end

      def cycle_prev
        layout.cycle_prev(view)
      end
    end
  end
end
