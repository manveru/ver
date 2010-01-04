module VER
  class Executor
    class CompleteTheme < Entry
      def setup
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
