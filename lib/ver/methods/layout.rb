module VER::Methods
  module Layout
    class << self
      def change(text, action, *count)
        action.call(text, *count)
      end

      def peer(text)
        text.layout.create_buffer(peer: text) do |buffer|
          yield(buffer) if block_given?
        end
      end

      def focus(text, index = 0)
        return unless found = text.layout.buffers[index - 1]
        text.layout.push_top(found)
      end

      def find_or_create(text, file, &block)
        VER::Buffer.find_or_create(file, &block)
      end

      def create(text)
        VER::Buffer.create
      end

      def close(text)
        text.buffer.close
      end

      def focus_next(text)
        text.layout.focus_next(text.buffer)
      end

      def focus_prev(text)
        text.layout.focus_prev(text.buffer)
      end

      def push_up(text)
        text.layout.push_up(text.buffer)
      end

      def push_down(text)
        text.layout.push_down(text.buffer)
      end

      def push_top(text)
        text.layout.push_top(text.buffer)
      end

      def push_bottom(text)
        text.layout.push_bottom(text.buffer)
      end

      def one(text)
        text.layout.options.merge! master: 1, slaves: 0
        push_top(text)
      end

      def two(text)
        text.layout.options.merge! master: 1, slaves: 1
        push_top(text)
      end

      def slave_inc(text)
        slaves = text.layout.options[:slaves]
        unless slaves >= text.layout.buffers.size
          text.layout.options[:slaves] += 1
          text.layout.apply
        end
      end

      def slave_dec(text)
        slaves = text.layout.options[:slaves]
        text.layout.options[:slaves] -= 1 if slaves > 0
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

      # Shrink the master pane by 10%
      def master_shrink(text)
        center = text.layout.options[:center]
        text.layout.options[:center] -= 0.1 if center > 0.1
        text.layout.apply
      end

      # Grow the master pane by 10%
      def master_grow(text)
        center = text.layout.options[:center]
        text.layout.options[:center] += 0.1 if center < 0.9
        text.layout.apply
      end

      # Center the split between masters and slaves
      def master_equal(text)
        text.layout.options[:center] = 0.5
        text.layout.apply
      end

      def cycle_next(text)
        text.layout.cycle_next(text.buffer)
      end

      def cycle_prev(text)
        text.layout.cycle_prev(text.buffer)
      end
    end
  end
end
