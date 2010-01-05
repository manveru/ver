module VER
  class Executor
    class CompleteMethod < Entry
      def setup
        @methods = caller.methods.map{|name|
          method = caller.method(name)
          [method.name.to_s, signature_of(method)]
        }.sort

        setup_tree
      end

      def setup_tree
        tree.configure(
          show: [:headings],
          columns: %w[method signature],
          displaycolumns: %w[method signature],
        )

        tree.heading('method', text: 'Method')
        tree.heading('signature', text: 'Signature')
      end

      def choices(name)
        subset(name, @methods)
      end

      def action(method)
        eval("caller.#{method}")
      rescue Exception => ex
        VER.status.message ex.message
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
