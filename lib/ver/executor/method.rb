module VER
  class Executor
    class CompleteMethod < Entry
      def setup
        @methods = callback.caller.methods.map{|m| m.to_s }
        tree.configure(
          show: [],
          columns: %w[method],
          displaycolumns: %w[method],
        )
        tree.heading('method', text: 'Method')
      end

      def choices(name)
        subset(name, @methods)
      end

      def action(method)
        callback.caller.__send__(method)
      end
    end
  end
end
