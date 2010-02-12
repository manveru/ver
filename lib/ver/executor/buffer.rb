module VER
  class Executor
    class ExBuffer < Entry
      def setup
        callback.update_on_change = true
        @buffers = VER.buffers.map{|name, buffer|
          [Marshal.dump(name), buffer.name.to_s]
        }

        tree.configure(
          show:           [],
          columns:        %w[name file],
          displaycolumns: %w[file]
        )
      end

      def choices(name)
        subset(name, @buffers)
      end

      def action(selected)
        item = tree.focus_item
        key, name, = item.options(:values)
        return unless key
        name = Marshal.load(key)
        Buffer[name].show
        callback.destroy(false)
      end
    end
  end
end
