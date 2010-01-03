module VER
  class Executor
    class CompleteSyntax < Entry
      def setup
        @syntaxes = VER::Syntax.list.map{|fullpath|
          File.basename(fullpath, File.extname(fullpath))
        }
        tree.configure(show: [], columns: %w[syntax], displaycolumns: %w[syntax])
      end

      def choices(name)
        subset(name, @syntaxes)
      end

      def action(name)
        callback.caller.load_syntax(name)
      end
    end
  end
end
