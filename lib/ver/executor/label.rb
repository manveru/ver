module VER
  class Executor
    autoload :ExFuzzyFileFinder, 'ver/executor/fuzzy_file_finder'
    autoload :ExGrep,            'ver/executor/grep'
    autoload :ExLocate,          'ver/executor/locate'
    autoload :ExMethod,          'ver/executor/method'
    autoload :ExPath,            'ver/executor/path'
    autoload :ExSyntax,          'ver/executor/syntax'
    autoload :ExTheme,           'ver/executor/theme'
    autoload :ExWrite,           'ver/executor/path'
    autoload :ExBuffer,          'ver/executor/buffer'

    class ExLabel < Entry
      COMPLETERS = {
        'edit'   => :ExPath,
        'fuzzy'  => :ExFuzzyFileFinder,
        'grep'   => :ExGrep,
        'locate' => :ExLocate,
        'method' => :ExMethod,
        'open'   => :ExPath,
        'syntax' => :ExSyntax,
        'theme'  => :ExTheme,
        'write'  => :ExWrite,
        'buffer' => :ExBuffer,
      }

      def setup
        tree.configure(
          show: [],
          columns: %w[ex],
          displaycolumns: %w[ex],
        )
        tree.heading('ex', text: 'Execution Method')
        update_only
      end

      def choices(name)
        subset(name, COMPLETERS.keys)
      end

      def action(name)
        completer_name = COMPLETERS.fetch(name)
        completer = Executor.const_get(completer_name)
        self.value = completer_name
        entry = callback.use_entry(completer)
        entry.focus
        entry.update_only
        configure(state: :disabled)
        false
      rescue KeyError
      end
    end
  end
end
