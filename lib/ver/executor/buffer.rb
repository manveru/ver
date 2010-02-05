module VER
  class Executor
    class ExBuffer < Entry
      def setup
        callback.update_on_change = true
        @buffers = VER.paths.map(&:to_s).select {|b| ! b.empty? }
      end

      def choices(name)
        subset(name, @buffers)
      end

      def action(path)
        VER.find_or_create_buffer(path)
        callback.destroy(false)
      end
    end
  end
end
