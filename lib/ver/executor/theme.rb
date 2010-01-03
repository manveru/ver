module VER
  class Executor
    class CompleteTheme < Entry
      def setup
        @themes = VER::Theme.list.map{|fullpath|
          File.basename(fullpath, File.extname(fullpath))
        }
        tree.configure(show: [:tree])
      end

      def choices(name)
        subset(name, @themes)
      end

      def action(name)
        callback.caller.load_theme(name)
      end
    end
  end
end
