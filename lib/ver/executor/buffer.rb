module VER
  class Executor
    class ExBuffer < Entry
      def setup
        callback.update_on_change = true
        @buffers = VER.paths.map(&:to_s).select {|b| ! b.empty? }
        tree.configure(show: [], columns: %w[buffer], displaycolumns: %w[buffer])
      end

      def choices(name)
        subset(name, @buffers)
      end

      def action(path)
        VER.find_or_create_buffer(path)
      end
    end
  end
end
