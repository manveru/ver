module VER
  class Executor
    class ExTheme < Entry
      def setup
        callback.update_on_change = true
        @themes = VER::Theme.list.map do |fullpath|
          File.basename(fullpath, File.extname(fullpath))
        end
      end

      def choices(name)
        subset(name, @themes)
      end

      def action(name)
        caller.load_theme(name)
        callback.destroy
      end
    end
  end
end
