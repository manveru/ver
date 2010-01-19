module VER
  class Executor
    # Open or focus a buffer with the given path.
    class ExPath < Entry
      def setup
        callback.update_on_change = true
      end

      def choices(origin)
        origin = origin.sub(/^.*\/\//, '/')
        origin = origin.sub(/^.*\/~\//, '~/')
        origin = File.expand_path(origin) unless File.directory?(origin)

        Dir.glob("#{origin}*").map do |path|
          if File.directory?(path)
            path = "#{path}/"
          end

          path
        end
      end

      def action(path)
        throw(:invalid) if File.directory?(path)
        caller.view.find_or_create(path)
      end
    end

    # Create new buffer with given filename and copy contents of current buffer
    # into it.
    # Then save it for good measure.
    class ExWrite < ExPath
      def action(path)
        throw(:invalid) if File.directory?(path)

        caller.view.find_or_create(path) do |view|
          text = view.text
          text.value = caller.value.chomp
          Methods::Save.file_save(text)
        end
      end
    end
  end
end
