module VER
  class Executor
    class ExSyntax < Entry
      def setup
        callback.update_on_change = true
        @syntaxes = VER::Syntax.list.map{|fullpath|
          File.basename(fullpath, File.extname(fullpath))
        }
      end

      def choices(name)
        subset(name, @syntaxes)
      end

      def action(name)
        caller.load_syntax(name)
        callback.destroy
      end
    end
  end
end
