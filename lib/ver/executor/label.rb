module VER
  class Executor
    require_relative 'fuzzy_file_finder'
    require_relative 'encoding'
    require_relative 'grep'
    require_relative 'grep'
    require_relative 'locate'
    require_relative 'method'
    require_relative 'path'
    require_relative 'syntax'
    require_relative 'theme'
    require_relative 'path'
    require_relative 'buffer'

    class ExLabel < Entry
      COMPLETERS = {
        'edit'         => :ExPath,
        'encoding'     => :ExEncoding,
        'fuzzy'        => :ExFuzzyFileFinder,
        'grep'         => :ExGrep,
        'grep_buffers' => :ExGrepBuffers,
        'locate'       => :ExLocate,
        'method'       => :ExMethod,
        'open'         => :ExPath,
        'syntax'       => :ExSyntax,
        'theme'        => :ExTheme,
        'write'        => :ExWrite,
        'buffer'       => :ExBuffer
      }

      def setup
        tree.configure(
          show: [],
          columns: %w[ex],
          displaycolumns: %w[ex]
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
        entry = callback.use_entry(completer)

        self.value = completer_name
        configure(state: :disabled, takefocus: false)

        entry.focus
        entry.update_only
      rescue KeyError
      end
    end
  end
end
