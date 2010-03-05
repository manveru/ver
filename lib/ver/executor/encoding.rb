module VER
  class Executor
    class ExEncoding < Entry
      def setup
        callback.update_on_change = true
        @encodings = Encoding.list.map(&:name)
      end

      def choices(name)
        subset(name, @encodings)
      end

      def action(name)
        caller.encoding = Encoding.find(name)
        callback.destroy
      end
    end
  end
end
