module VER
  class Executor
    class ExMethod < Entry
      def setup
        @actions = caller.major_mode.actions

        setup_tree
      end

      def setup_tree
        tree.configure(
          show: [:headings],
          columns: %w[id method signature],
          displaycolumns: %w[method signature]
        )

        tree.heading('method', text: 'Method')
        tree.heading('signature', text: 'Signature')
      end

      def tree_selection_value
        return unless item = tree.selection.first
        item.options[:values][1]
      end

      def after_update
        total = tree.winfo_width
        third = total / 3

        tree.column('method',    width: third, stretch: true)
        tree.column('signature', width: third * 2, stretch: true)
      end

      def choices(name)
        rows = @actions.map.with_index do |action, id|
          method = action.to_method(caller)
          [id, method.name.to_s, signature_of(method)]
        end
        subset(name, rows, 1)
      end

      def accept_line
        self.tabcount = 0
        item = tree.selection.first
        return unless item

        action = @actions.fetch(Integer(item.options[:values].first))
        callback.destroy
        action.call(caller)
      end

      # TODO:
      # Use YARD for this, my local clone is a bit dusty and broken.
      # What I really want to do is extract @usage or similar, for now we use
      # the signature because parsing all the docs is expensive.
      def signature_of(method)
        source_file, source_line = method.source_location
        return '' unless source_file && source_line

        File.open(source_file) do |io|
          needle = source_line - 1

          io.each_line.with_index do |line, index|
            return line.strip if needle == index
          end
        end

        return ''
      rescue Errno::ENOENT # <gem_prelude>, eval, etc.
        return ''
      end
    end
  end
end
