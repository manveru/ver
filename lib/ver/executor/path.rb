module VER
  class Executor
    # Open or focus a buffer with the given path.
    class ExPath < Entry
      def choices(origin)
        origin = origin.sub(/^.*\/\//, '/')
        origin = origin.sub(/^.*\/~\//, '~/')
        origin = File.expand_path(origin) unless File.directory?(origin)

        Dir.glob("#{origin}*").map do |path|
          if File.directory?(path)
            "#{path}/"
          else
            path
          end
        end
      end

      def action(selected)
        path = selected || value
        throw(:invalid) if File.directory?(path)
        VER.find_or_create_buffer(path)
        callback.destroy
      end
    end

    # Create new buffer with given filename and copy contents of current buffer
    # into it.
    # Then save it for good measure.
    class ExWrite < ExPath
      def action(selected)
        path = selected || value
        throw(:invalid) if File.directory?(path)

        VER.find_or_create_buffer(path) do |buffer|
          text = buffer.text
          text.value = caller.value.chomp
          Methods::Save.file_save(text)
        end

        callback.destroy
      end
    end
  end
end
