module VER
  class Executor
    class CompleteLabel < Entry
      COMPLETERS = {
        'edit'   => :CompletePath,
        'grep'   => :CompleteGrep,
        'method' => :CompleteMethod,
        'open'   => :CompletePath,
        'syntax' => :CompleteSyntax,
        'theme'  => :CompleteTheme,
        'write'  => :CompleteWrite,
        'fuzzy'  => :CompleteFuzzyFileFinder,
      }

      def setup
        tree.configure(
          show: [],
          columns: %w[ex],
          displaycolumns: %w[ex],
        )
        tree.heading('ex', text: 'Execution Method')
      end

      def choices(name)
        subset(name, COMPLETERS.keys)
      end

      def pick_selection
        super do |name|
          completer_name = COMPLETERS.fetch(name)
          completer = Executor.const_get(completer_name)
          entry = callback.use_entry(completer)
          entry.focus
          configure(state: :disabled)
          false
        end
      rescue KeyError
      end
    end
  end
end
