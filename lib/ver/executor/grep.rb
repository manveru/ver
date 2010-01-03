module VER
  class Executor
    # Grepping made easy
    class CompleteGrep < Entry
      def setup
        tree.configure(
          show: [:headings],
          columns:        %w[file line source],
          displaycolumns: %w[file line source],
        )
        tree.heading('file', text: 'File')
        tree.heading('line', text: 'Line')
        tree.heading('source', text: 'Source')
        tree.column('file', width: 100, stretch: false, anchor: :w)
        tree.column('line', width: 50, stretch: false, anchor: :e)
        callback.frame.place(relwidth: 0.9)
      end

      def choices(glob_needle)
        choices = []

        return [] if glob_needle =~ /^\s*$/

        glob, needle = glob_needle.split(/\s+/, 2)
        unless needle
          glob, needle = '*', glob
          self.value = "#{glob} #{needle}"
        end

        return [] if needle =~ /^\s*$/

        regexp = Regexp.new(needle)
        grep_with(glob, regexp)
      end

      def grep_with(glob, regexp)
        results = []

        Dir.glob(glob) do |path|
          next unless File.file?(path)

          File.open(path) do |io|
            begin
              io.each_line.with_index do |line, index|
                next unless line =~ regexp
                results << [path, index + 1, line]
              end
            rescue ArgumentError # why isn't that RegexpError or EncodingError
            end
          end
        end

        results
      end

      # completion has little meaning with grep, so ignore it.
      def pick_selection
        item = tree.focus_item
        file, line, _ = item.options(:values)
        return unless file && line
        callback.caller.view.find_or_create(file.to_s, line.to_i)
        callback.destroy
      end
    end
  end
end
