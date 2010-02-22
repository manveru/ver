module VER
  module Methods
    module Layout
      module_function

      def change(buffer, action, *count)
        action.call(buffer, *count)
      end

      def peer(buffer)
        buffer.layout.create_buffer(peer: buffer) do |buffer|
          yield(buffer) if block_given?
        end
      end

      def focus(buffer, index = 0)
        return unless found = VER.buffers.to_a[index - 1]
        buffer.layout.push_top(found)
        found.focus
      end

      # Close the given +buffer+
      def close(buffer)
        buffer.layout.close_buffer(buffer)
      end

      # Hide the given +buffer+
      def hide(buffer)
        buffer.layout.hide_buffer(buffer)
      end

      def focus_next(buffer)
        buffer.layout.focus_next(buffer)
      end

      def focus_prev(buffer)
        buffer.layout.focus_prev(buffer)
      end

      def push_up(buffer)
        buffer.layout.push_up(buffer)
      end

      def push_down(buffer)
        buffer.layout.push_down(buffer)
      end

      def push_top(buffer)
        buffer.layout.push_top(buffer)
      end

      def push_bottom(buffer)
        buffer.layout.push_bottom(buffer)
      end

      def one(buffer)
        buffer.layout.options.merge! master: 1, slaves: 0
        push_top(buffer)
      end

      def two(buffer)
        buffer.layout.options.merge! master: 1, slaves: 1
        push_top(buffer)
      end

      def slave_inc(buffer)
        slaves = buffer.layout.options[:slaves]
        unless slaves >= buffer.layout.frames.size
          buffer.layout.options[:slaves] += 1
          buffer.layout.apply
        end
      end

      def slave_dec(buffer)
        slaves = buffer.layout.options[:slaves]
        buffer.layout.options[:slaves] -= 1 if slaves > 0
        buffer.layout.apply
      end

      def master_inc(buffer)
        buffer.layout.options[:master] += 1
        buffer.layout.apply
      end

      def master_dec(buffer)
        master = buffer.layout.options[:master]
        buffer.layout.options[:master] -= 1 if master > 0
        buffer.layout.apply
      end

      # Shrink the master pane by 10%
      def master_shrink(buffer)
        center = buffer.layout.options[:center]
        buffer.layout.options[:center] -= 0.1 if center > 0.1
        buffer.layout.apply
      end

      # Grow the master pane by 10%
      def master_grow(buffer)
        center = buffer.layout.options[:center]
        buffer.layout.options[:center] += 0.1 if center < 0.9
        buffer.layout.apply
      end

      # Center the split between masters and slaves
      def master_equal(buffer)
        buffer.layout.options[:center] = 0.5
        buffer.layout.apply
      end

      def cycle_next(buffer)
        buffer.layout.cycle_next(buffer)
      end

      def cycle_prev(buffer)
        buffer.layout.cycle_prev(buffer)
      end
    end
  end
end
