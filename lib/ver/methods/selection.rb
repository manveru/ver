module VER
  module Methods
    module Selection
      module_function

      def pipe(buffer)
        paths = ENV['PATH'].split(':').map { |path| Pathname(path).expand_path }

        buffer.ask 'Pipe command: ' do |answer, action|
          case action
          when :complete
            current = answer.split.last
            paths.map do |path|
              (path / "*#{current}*").glob.select do |file|
                begin
                  file = File.readlink(file) if File.symlink?(file)
                  stat = File.stat(file)
                  stat.file? && stat.executable?
                rescue Errno::ENOENT
                end
              end
            end.flatten.compact
          when :attempt
            buffer.at_sel.pipe!(answer)
            buffer.at_sel.finish
            :abort
          end
        end
      end
    end
  end
end

__END__

      def refresh(text)
        return unless text.store(self, :refresh)
        return unless start = text.store(self, :start)

        text.tag_remove(:sel, 1.0, :end)

        case select_mode(text)
        when :select_char  ; refresh_char(text, start)
        when :select_line  ; refresh_line(text, start)
        when :select_block ; refresh_block(text, start)
        end
      end

      # Convert all characters within the selection to upper-case using
      # String#upcase.
      # Usually only works for alphabetic ASCII characters.
      def upper_case(text)
        Undo.record text do |record|
          each_selected_line text do |y, fx, tx|
            from, to = "#{y}.#{fx}", "#{y}.#{tx}"
            record.replace(from, to, text.get(from, to).upcase)
          end
        end

        refresh(text)
      end

      # Convert all characters within the selection to lower-case using
      # String#downcase.
      # Usually only works for alphabetic ASCII characters.
      def lower_case(text)
        Undo.record text do |record|
          each_line text do |y, fx, tx|
            from, to = "#{y}.#{fx}", "#{y}.#{tx}"
            record.replace(from, to, text.get(from, to).downcase)
          end
        end

        refresh(text)
      end

      # Toggle case within the selection.
      # This only works for alphabetic ASCII characters, no other encodings.
      def toggle_case(text)
        Undo.record text do |record|
          each_line text do |y, fx, tx|
            from, to = "#{y}.#{fx}", "#{y}.#{tx}"
            record.replace(from, to, text.get(from, to).tr('a-zA-Z', 'A-Za-z'))
          end
        end

        refresh(text)
      end

      def wrap(text)
        queue = []
        chunks = []

        each_line text do |y, fx, tx|
          queue << y
          chunks << text.get("#{y}.0", "#{y}.0 lineend")
        end

        lines = Control.wrap_lines_of(chunks.join(' ')).join("\n")
        from, to = queue.first, queue.last
        text.replace("#{from}.0", "#{to}.0 lineend", lines)

        finish(text)
      end

      # Delete selection without copying it.
      def delete(text)
        case select_mode(text)
        when :select_char, :select_block
          queue = text.tag_ranges(:sel).flatten
          Delete.delete(text, *queue)
          text.mark_set(:insert, queue.first)
        when :select_line
          from, to = text.tag_ranges(:sel).flatten
          to = "#{to} + 1 lines linestart"
          Delete.delete(text, from, to)
          text.mark_set(:insert, from)
        else
          Kernel.raise "Not in select mode?"
        end

        finish(text)
      end

      # Copy selection and delete it.
      def kill(text)
        case select_mode(text)
        when :select_char, :select_block
          queue = text.tag_ranges(:sel).flatten
          Delete.kill(text, *queue)
          text.mark_set(:insert, queue.first)
        when :select_line
          from, to = text.tag_ranges(:sel).flatten
          Clipboard.copy(text, text.get(from, to))
          to = "#{to} + 1 lines linestart"
          Delete.delete(text, from, to)
          text.mark_set(:insert, from)
        else
          Kernel.raise "Not in select mode?"
        end

        finish(text)
      end

      def indent(text)
        indent_size = text.options.shiftwidth
        indent = ' ' * indent_size

        Undo.record text do |record|
          each_line text do |y, fx, tx|
            tx = fx + indent_size
            next if text.get("#{y}.#{fx}", "#{y}.#{tx}").empty?
            record.insert("#{y}.#{fx}", indent)
          end
        end

        refresh(text)
      end

      def unindent(text)
        indent_size = text.options.shiftwidth
        indent = ' ' * indent_size
        queue = []

        each_line text do |y, fx, tx|
          tx = fx + indent_size
          left, right = "#{y}.#{fx}", "#{y}.#{tx}"
          next unless text.get(left, right) == indent
          queue << left << right
        end

        text.delete(*queue)
        refresh(text)
      end

      def evaluate(text)
        text.tag_ranges(:sel).each do |from, to|
          code = text.get(from, to)

          Control.stdout_capture_evaluate(code) do |res,out|
            text.insert("#{to} lineend", "\n%s%p" % [out, res] )
          end
        end

        finish(text)
      end

      def copy(text)
        chunks = text.tag_ranges(:sel).map{|sel| text.get(*sel) }
        Clipboard.copy(text, chunks.size == 1 ? chunks.first : chunks)
        finish(text)
      end


      def comment(text)
        comment = "#{text.options.comment_line} "
        indent = nil
        lines = []

        each_line text do |y, fx, tx|
          lines << y

          next if indent == 0 # can't get lower

          line = text.get("#{y}.#{fx}", "#{y}.#{tx}")

          next unless start = line =~ /\S/

          indent ||= start
          indent = start if start < indent
        end

        indent ||= 0

        Undo.record text do |record|
          lines.each do |y|
            record.insert("#{y}.#{indent}", comment)
          end
        end

        refresh(text)
      end

      def uncomment(text)
        comment = "#{text.options.comment_line} "
        regex = /#{Regexp.escape(comment)}/

        Undo.record text do |record|
          each_line text do |y, fx, tx|
            from, to = "#{y}.#{fx}", "#{y}.#{tx}"
            line = text.get(from, to)

            if line.sub!(regex, '')
              record.replace(from, to, line)
            end
          end
        end

        refresh(text)
      end

      # Replace every character in the selection with the character entered.
      def replace_char(text, char = text.event.unicode)
        replace_with(text, char, full = true)
        text.minor_mode(:select_replace_char, select_mode(text))
      end

      def replace_string(text)
        text.ask 'Replace selection with: ', do |answer, action|
          case action
          when :attempt
            if answer.size > 0
              replace_with(text, answer, full = false)
              VER.message "replaced #{answer.size} chars"
              :abort
            else
              VER.warn "replacement required"
            end
          end
        end
      end

      def replace_with_clipboard(text)
        string = text.clipboard_get
        ranges = text.tag_ranges(:sel)
        from, to = ranges.first.first, ranges.last.last
        text.replace(from, to, string)
        finish(text)
        text.mark_set :insert, from
      end

      # TODO: find better name for +full+
      def replace_with(text, string, full)
        origin = text.index(:insert)

        Undo.record text do |record|
          if full
            each_line text do |y, fx, tx|
              diff = tx - fx
              record.replace("#{y}.#{fx}", "#{y}.#{tx}", string * diff)
            end
          else
            string_size = string.size
            each_line text do |y, fx, tx|
              record.replace("#{y}.#{fx}", "#{y}.#{tx}", string)
            end
          end
        end

        text.mark_set(:insert, origin)
      end

      def finish(text, mode = nil)
        text.minor_mode(select_mode(text), :control)
      end

      def clear(text)
        text.store(self, :start, nil)
        text.tag_remove(:sel, '1.0', 'end')
      end

      # For every chunk selected, this yields the corresponding coordinates as
      # [from_y, from_x, to_y, to_x].
      # It takes into account the current selection mode.
      # In many cases from_y and to_y are identical, but don't rely on this.
      #
      # @see each_selected_line
      def each(text)
        return Enumerator.new(self, :each, text) unless block_given?

        text.tag_ranges(:sel).each do |sel|
          (fy, fx), (ty, tx) = sel.map{|pos| pos.split('.').map(&:to_i) }

          case select_mode(text)
          when :select_char
            if fy == ty
              yield fy, fx, ty, tx
            elsif (ty - fy) == 1
              efy, efx = text.index("#{fy}.#{fx} lineend").split
              sty, stx = text.index("#{ty}.#{tx} linestart").split
              yield fy, fx, efy, efx
              yield sty, stx, ty, tx
            else
              efy, efx = text.index("#{fy}.#{fx} lineend").split
              yield fy, fx, efy, efx

              ((fy + 1)...ty).each do |y|
                sy, sx = text.index("#{y}.0 linestart").split
                ey, ex = text.index("#{y}.0 lineend").split
                yield sy, sx, ey, ex
              end

              sty, stx = text.index("#{ty}.#{tx} linestart").split
              yield sty, stx, ty, tx
            end
          when :select_line
            fy.upto(ty) do |y|
              sy, sx = text.index("#{y}.0 linestart").split
              ey, ex = text.index("#{y}.0 lineend").split
              yield sy, sx, ey, ex
            end
          when :select_block
            yield fy, fx, ty, tx
          else
            Kernel.raise "Not in select mode?"
          end
        end
      end

      # Abstraction for [each] that yields one y coordinate per #
      # line.
      # You usually want to use this if you work with selections.
      def each_line(text)
        each text do |fy, fx, ty, tx|
          fy.upto(ty) do |y|
            yield y, fx, tx
          end
        end
      end

      def pipe_execute(text, *cmd)
        require 'open3'

        Open3.popen3(*cmd) do |si, sose, thread|
          queue = []
          text.tag_ranges(:sel).each do |from, to|
            si.write(text.get(from, to))
            queue << from << to
          end

          si.close
          output = sose.read

          return if queue.empty?

          Undo.record text do |record|
            record.delete(*queue)
            record.insert(queue.first, output.chomp)
          end
        end
      end

      # FIXME: yes, i know i'm calling `tag add` for every line, which makes
      #        things slower, but it seems like there is a bug in the text widget.
      #        So we aggregate the information into a single eval.
      def refresh_block(text, start)
        ly, lx, ry, rx =
          if text.compare('insert', '>', start)
            [*text.index('insert').split, *start.split]
          else
            [*start.split, *text.index('insert').split]
          end

        from_y, to_y = [ly, ry].sort
        from_x, to_x = [lx, rx].sort
      end

      def refresh_char(text, start)
        if text.compare('insert', '>', start)
          text.tag_add(:sel, start, "insert + 1 chars")
        else
          text.tag_add(:sel, "insert", "#{start} + 1 chars")
        end
      end

      def refresh_line(text, start)
        if text.compare('insert', '>', start)
          text.tag_add(:sel, "#{start} linestart", 'insert lineend')
        else
          text.tag_add(:sel, 'insert linestart', "#{start} lineend")
        end
      end
    end
  end
end
