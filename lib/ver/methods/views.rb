module VER::Methods
  module Views
    class << self
      def change(text, action, *count)
        action.call(text, *count)
      end

      def peer(text)
        text.create_peer
      end

      def focus(text, index = 0)
        return unless found = text.layout.views[index - 1]
        found.push_top
      end

      def find_or_create(text, file)
        text.view.find_or_create(file)
      end

      def create(text)
        text.view.create
      end

      def close(text)
        text.view.close
      end

      def focus_next(text)
        text.view.focus_next
      end

      def focus_prev(text)
        text.view.focus_prev
      end

      def push_up(text)
        text.view.push_up
      end

      def push_down(text)
        text.view.push_down
      end

      def push_top(text)
        text.view.push_top
      end

      def push_bottom(text)
        text.view.push_bottom
      end

      def one(text)
        text.layout.options.merge! master: 1, stacking: 0
        push_top(text)
      end

      def two(text)
        text.layout.options.merge! master: 1, stacking: 1
        push_top(text)
      end

      def slave_inc(text)
        stacking = text.layout.options[:stacking]
        unless stacking >= text.layout.views.size
          text.layout.options[:stacking] += 1
          text.layout.apply
        end
      end

      def slave_dec(text)
        stacking = text.layout.options[:stacking]
        text.layout.options[:stacking] -= 1 if stacking > 0
        text.layout.apply
      end

      def master_inc(text)
        text.layout.options[:master] += 1
        text.layout.apply
      end

      def master_dec(text)
        master = text.layout.options[:master]
        text.layout.options[:master] -= 1 if master > 0
        text.layout.apply
      end

      def master_shrink(text)
        center = layout.options[:center]
        layout.options[:center] -= 0.1 if center > 0.1
        layout.apply
      end

      def master_grow(text)
        center = layout.options[:center]
        layout.options[:center] += 0.1 if center < 0.9
        layout.apply
      end

      def cycle_next(text)
        text.layout.cycle_next(text.view)
      end

      def cycle_prev(text)
        text.layout.cycle_prev(text.view)
      end
    end
  end
end
