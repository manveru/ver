require 'ver/vendor/fuzzy_file_finder'

module VER
  class Executor
    class ExFuzzyFileFinder < Entry
      FFF = ::FuzzyFileFinder

      def completed=(values)
        path = Pathname(values.first)
        self.value = path.relative_path_from(@pwd).to_s
      end

      def setup
        callback.update_on_change = true

        tree.configure(
          show: [:headings],
          columns: %w[path dir file score],
          displaycolumns: %w[dir file score],
        )
        tree.heading('dir', text: 'Directory')
        tree.heading('file', text: 'File')
        tree.heading('score', text: 'Score')
        tree.column('dir', width: 100, anchor: :w)
        tree.column('file', width: 100, anchor: :w)
        tree.column('score', width: 50, stretch: false, anchor: :e)

        setup_fff
      end

      def setup_fff
        @pwd = Pathname(Dir.pwd)
        setup_fff_with(caller.project_root)
      rescue FFF::TooManyEntries
        setup_fff_with(@pwd)
      rescue FFF::TooManyEntries
        VER.message "The FuzzyFileFinder is overwhelmed by the amount of files"
        callback.destroy
        Tk.callback_break
      end

      def setup_fff_with(root)
        @fffinder = FFF.new(root.to_s)
      end

      def choices(value)
        choices = @fffinder.find(value.chomp('/')).
          sort_by{|match| [-match[:score], match[:path]] }
        choices.map{|match|
          [
            match[:path],
            match[:highlighted_directory],
            match[:highlighted_name],
            match[:score].round(2),
          ]
        }
      end

      def action(path)
        throw(:invalid) unless File.file?(path)
        caller.view.find_or_create(path)
      end
    end
  end
end
