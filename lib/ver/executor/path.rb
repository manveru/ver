module VER
  class Executor
    class CompletePath < Entry
      def choices(origin)
        Dir.glob("#{origin}*").map do |path|
          if File.directory?(path)
            path = "#{path}/"
          end

          path
        end
      end

      def action(path)
        callback.caller.view.find_or_create(path)
      end
    end
  end
end
