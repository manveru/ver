module VER
  class Executor
    # Open or focus a buffer with the given path.
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

    # Create new buffer with given filename and copy contents of current buffer
    # into it.
    # Then save it for good measure.
    class CompleteWrite < CompletePath
      def action(path)
        callback.caller.view.find_or_create(path) do |view|
          view.text.value = callback.caller.value.chomp
          view.text.file_save
        end
      end
    end
  end
end
