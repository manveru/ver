module VER
  class Executor
    class ExSyntax < Entry
      def setup
        callback.update_on_change = true
        @syntaxes = VER::Syntax.list.map do |fullpath|
          File.basename(fullpath, File.extname(fullpath))
        end
      end

      def choices(name)
        subset(name, @syntaxes)
      end

      def action(name)
        caller.load_syntax(name)
        caller.touch!('1.0', 'end')
        callback.destroy
      end
    end
  end
end
