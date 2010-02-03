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
        tree.configure(
          show: [:headings],
          columns: %w[
            path abbr directory name highlighted_directory highlighted_name
            highlighted_path score
          ],
          displaycolumns: %w[
            path abbr highlighted_path score
          ],
        )

        tree.heading('path', text: 'Path')
        tree.heading('abbr', text: 'Abbr')
        tree.heading('directory', text: 'Directory')
        tree.heading('name', text: 'Name')
        tree.heading('highlighted_directory', text: 'Directory (hl)')
        tree.heading('highlighted_name', text: 'Name (hl)')
        tree.heading('highlighted_path', text: 'Path (hl)')
        tree.heading('score', text: 'Score')

        setup_fff
      end

      def after_update
        total = tree.winfo_width
        third = (total - 50) / 3

        tree.column('path', width: third, stretch: true)
        tree.column('abbr', width: third, stretch: true)
        tree.column('highlighted_path', width: third, stretch: true)
        tree.column('score', width: 50, stretch: true)
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
            match[:abbr],
            match[:directory],
            match[:name],
            match[:highlighted_directory],
            match[:highlighted_name],
            match[:highlighted_path],
            match[:score].round(2),
          ]
        }
      end

      def action(path)
        throw(:invalid) unless File.file?(path)
        VER.find_or_create_buffer(path)
        callback.destroy
      end
    end
  end
end
