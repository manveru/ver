module VER
  class Executor
    class ExLocate < Entry
      def setup
      end

      def choices(name)
        return [] if name.strip.empty?
        `locate -b0 '#{name}'`.split("\0")
      end

      def action(path)
        throw(:invalid) if File.directory?(path)
        VER.find_or_create_buffer(path)
      end
    end
  end
end
