module VER
  class Executor
    # Grepping made easy
    class ExGrep < Entry
      def setup
        @root = caller.project_root || Pathname(Dir.pwd)

        tree.configure(
          show: [:headings],
          columns:        %w[file line source],
          displaycolumns: %w[file line source],
        )
        tree.heading('file', text: 'File')
        tree.heading('line', text: 'Line')
        tree.heading('source', text: 'Source')
      end

      def after_update
        total = tree.winfo_width - 50

        tree.column('file',   width: (total * 0.3).to_i, stretch: false, anchor: :w)
        tree.column('line',   width: 50,  stretch: false, anchor: :e)
        tree.column('source', width: (total * 0.7).to_i, stretch: false, anchor: :w)
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

        begin
          regexp = Regexp.new(needle)
        rescue RegexpError, SyntaxError
          regexp = Regexp.new(Regexp.escape(needle))
        end

        grep_with(glob, regexp)
      end

      def grep_with(glob, regexp, with_root = true)
        results = []
        root = with_root ? @root/glob : glob

        root.glob do |path|
          next unless path.file?

          path.open do |io|
            begin
              io.each_line.with_index do |line, index|
                next unless line =~ regexp
                results << [path.to_s, index + 1, line]
              end
            rescue ArgumentError # why isn't that RegexpError or EncodingError
            end
          end
        end

        results
      end

      def action(selected)
        item = tree.focus_item
        file, line, _ = item.options(:values)
        return unless file && line
        VER.find_or_create_buffer(file.to_s, line.to_i)
        callback.destroy(false)
      end

      # Ignore sync
      def sync_value_with_tree_selection
      end
    end

    # Grep the open buffers interactively
    class ExGrepBuffers < ExGrep
      def choices(needle)
        choices = []
        return choices if needle =~ /^\s*$/

        files = VER.buffers.map{|name, buffer| buffer.filename }
        glob = Pathname("{#{files.join(',')}}")

        begin
          regexp = Regexp.new(needle)
        rescue RegexpError, SyntaxError
          regexp = Regexp.new(Regexp.escape(needle))
        end

        grep_with(glob, regexp, false)
      end
    end
  end
end
