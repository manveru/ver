module VER
  class Executor
    class ExTheme < Entry
      def setup
        callback.update_on_change = true
        @themes = VER::Theme.list.map{|fullpath|
          File.basename(fullpath, File.extname(fullpath))
        }
        tree.configure(show: [], columns: %w[theme], displaycolumns: %w[theme])
      end

      def choices(name)
        subset(name, @themes)
      end

      def action(name)
        caller.load_theme(name)
      end
    end
  end
end
