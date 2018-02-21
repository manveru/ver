require_relative '../vendor/fuzzy_file_finder'

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
            highlighted_path score
          ]
        )

        tree.heading('path', text: 'Path')
        tree.heading('abbr', text: 'Abbr')
        tree.heading('directory', text: 'Directory')
        tree.heading('name', text: 'Name')
        tree.heading('highlighted_directory', text: 'Fuzzy Directory')
        tree.heading('highlighted_name', text: 'Fuzzy Name')
        tree.heading('highlighted_path', text: 'Fuzzy Path')
        tree.heading('score', text: 'Score')

        tree.column('path', stretch: true)
        tree.column('score', width: 50, stretch: false)

        setup_fff
      end

      def after_update
        total = tree.winfo_width - 50

        tree.column('highlighted_path', width: total, stretch: true)
        tree.column('score', width: 50, stretch: false)
      end

      def setup_fff
        @pwd = Pathname(Dir.pwd)
        setup_fff_with(caller.project_root)
      rescue FFF::TooManyEntries
        setup_fff_with(@pwd)
      rescue FFF::TooManyEntries
        caller.message 'The FuzzyFileFinder is overwhelmed by the amount of files'
        callback.destroy
        Tk.callback_break
      end

      def setup_fff_with(root)
        @fffinder = FFF.new(root.to_s)
      end

      def update_items(values)
        values.map do |value|
          score = value.last
          tag =
            if score < 0.25; :icy
            elsif score < 0.5; :cold
            elsif score < 0.75; :warm
            else; :hot
            end

          tree.insert(nil, :end, values: [*value], tags: [tag])
        end
      end

      def choices(value)
        choices = @fffinder.find(value)
                           .sort_by { |match| [-match[:score], match[:path]] }
        choices.map do |match|
          [
            match[:path],
            match[:abbr],
            match[:directory],
            match[:name],
            match[:highlighted_directory],
            match[:highlighted_name],
            match[:highlighted_path],
            match[:score].round(2)
          ]
        end
      end

      def action(path)
        throw(:invalid) unless File.file?(path)
        VER.find_or_create_buffer(path)
        callback.destroy(false)
      end
    end
  end
end
