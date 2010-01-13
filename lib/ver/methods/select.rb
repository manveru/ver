module VER
  module Methods
    module Select
      # Convert all characters within the selection to upper-case using
      # String#upcase.
      # Usually only works for alphabetic ASCII characters.
      def selection_upper_case
        undo_record do |record|
          each_selected_line do |y, fx, tx|
            from, to = "#{y}.#{fx}", "#{y}.#{tx}"
            record.replace(from, to, get(from, to).upcase)
          end
        end

        refresh_selection
      end

      # Convert all characters within the selection to lower-case using
      # String#downcase.
      # Usually only works for alphabetic ASCII characters.
      def selection_lower_case
        undo_record do |record|
          each_selected_line do |y, fx, tx|
            from, to = "#{y}.#{fx}", "#{y}.#{tx}"
            record.replace(from, to, get(from, to).downcase)
          end
        end

        refresh_selection
      end

      # Toggle case within the selection.
      # This only works for alphabetic ASCII characters, no other encodings.
      def selection_toggle_case
        undo_record do |record|
          each_selected_line do |y, fx, tx|
            from, to = "#{y}.#{fx}", "#{y}.#{tx}"
            record.replace(from, to, get(from, to).tr('a-zA-Z', 'A-Za-z'))
          end
        end

        refresh_selection
      end

      def wrap_selection
        queue = []
        text = []

        each_selected_line do |y, fx, tx|
          queue << y
          text << get("#{y}.0", "#{y}.0 lineend")
        end

        lines = wrap_lines_of(text.join(' '))
        from, to = queue.first, queue.last
        replace("#{from}.0", "#{to}.0 lineend", lines.join("\n"))

        finish_selection
      end

      def start_selection_mode(name)
        self.mode = name
        start_selection(name)
      end

      def switch_selection_mode(name)
        self.mode = name
        switch_selection(name)
      end

      def start_selection(name)
        self.selection_start = index(:insert)
        switch_selection(name)
      end

      def switch_selection(name)
        self.selection_mode = name.to_sym
        refresh_selection
      end

      %w[char line block].each do |suffix|
        name = "select_#{suffix}"
        define_method "start_#{name}_mode" do
          start_selection_mode name
        end

        define_method "switch_#{name}_mode" do
          switch_selection_mode name
        end
      end

      # Delete selection without copying it.
      def delete_selection
        queue = tag_ranges(:sel).flatten
        delete(*queue)
        mark_set(:insert, queue.first)

        finish_selection
      end

      # Copy selection and delete it.
      def kill_selection
        queue = tag_ranges(:sel).flatten
        kill(*queue)
        mark_set(:insert, queue.first)

        finish_selection
      end

      def indent_selection
        indent_size = options.shiftwidth
        indent = ' ' * indent_size

        undo_record do |record|
          each_selected_line do |y, fx, tx|
            tx = fx + indent_size
            next if get("#{y}.#{fx}", "#{y}.#{tx}").empty?
            record.insert("#{y}.#{fx}", indent)
          end
        end

        refresh_selection
      end

      def unindent_selection
        indent_size = options.shiftwidth
        indent = ' ' * indent_size
        queue = []

        each_selected_line do |y, fx, tx|
          tx = fx + indent_size
          left, right = "#{y}.#{fx}", "#{y}.#{tx}"
          next unless get(left, right) == indent
          queue << left << right
        end

        delete(*queue)
        refresh_selection
      end

      def selection_evaluate
        tag_ranges(:sel).each do |from, to|
          code = get(from, to)

          stdout_capture_evaluate(code) do |res,out|
            insert("#{to} lineend", "\n%s%p" % [out, res] )
          end
        end

        finish_selection
      end

      def copy_selection
        chunks = tag_ranges(:sel).map{|sel| get(*sel) }
        copy(chunks.size == 1 ? chunks.first : chunks)
        finish_selection
      end

      def pipe_selection
        status_ask 'Pipe command: ' do |cmd|
          pipe_selection_execute(cmd)
          finish_selection
        end
      end

      def comment_selection
        comment = "#{options.comment_line} "
        indent = nil
        lines = []

        each_selected_line do |y, fx, tx|
          lines << y

          next if indent == 0 # can't get lower

          line = get("#{y}.#{fx}", "#{y}.#{tx}")

          next unless start = line =~ /\S/

          indent ||= start
          indent = start if start < indent
        end

        indent ||= 0

        undo_record do |record|
          lines.each do |y|
            record.insert("#{y}.#{indent}", comment)
          end
        end

        refresh_selection
      end

      def uncomment_selection
        comment = "#{options.comment_line} "
        regex = /#{Regexp.escape(comment)}/

        undo_record do |record|
          each_selected_line do |y, fx, tx|
            from, to = "#{y}.#{fx}", "#{y}.#{tx}"
            line = get(from, to)

            if line.sub!(regex, '')
              record.replace(from, to, line)
            end
          end
        end

        refresh_selection
      end

      # Replace every character in the selection with the character entered.
      def selection_replace_char
        VER.message 'Enter character to replace the selection with'

        keymap.gets 1 do |char|
          if char.size == 1
            replace_selection_with(char, full = true)
            VER.message "replaced 1 char"
          else
            VER.message 'replace aborted'
          end
        end
      end

      def selection_replace_string
        status_ask 'Replace selection with: ', do |string|
          if string.size > 0
            replace_selection_with(string, full = false)
            "replaced #{string.size} chars"
          else
            'replace aborted'
          end
        end
      end

      def replace_selection_with_clipboard
        string = clipboard_get
        ranges = tag_ranges(:sel)
        from, to = ranges.first.first, ranges.last.last
        replace(from, to, string)
        finish_selection
        mark_set :insert, from
      end

      def refresh_selection
        return unless start = selection_start

        tag_remove :sel, 1.0, :end

        case selection_mode
        when :select_char  ; refresh_selection_char(start)
        when :select_line  ; refresh_selection_line(start)
        when :select_block ; refresh_selection_block(start)
        end
      end

      private

      # TODO: find better name for +full+
      def replace_selection_with(string, full)
        origin = index(:insert)

        undo_record do |record|
          if full
            each_selected_line do |y, fx, tx|
              diff = tx - fx
              record.replace("#{y}.#{fx}", "#{y}.#{tx}", string * diff)
            end
          else
            string_size = string.size
            each_selected_line do |y, fx, tx|
              record.replace("#{y}.#{fx}", "#{y}.#{tx}", string)
            end
          end
        end

        mark_set :insert, origin
      end

      def finish_selection(mode = nil)
        undo_separator
        clear_selection
        mode ? self.mode = mode : keymap.use_previous_mode
        apply_mode_style(keymap.mode)
      end

      def clear_selection
        self.selection_start = nil
        tag_remove :sel, '1.0', 'end'
      end

      # For every chunk selected, this yields the corresponding coordinates as
      # [from_y, from_x, to_y, to_x].
      # It takes into account the current selection mode.
      # In many cases from_y and to_y are identical, but don't rely on this.
      #
      # @see each_selected_line
      def each_selection
        tag_ranges(:sel).each do |sel|
          (fy, fx), (ty, tx) = sel.map{|pos| pos.split('.').map(&:to_i) }

          case selection_mode
          when :select_char
            if fy == ty
              yield fy, fx, ty, tx
            elsif (ty - fy) == 1
              efy, efx = index("#{fy}.#{fx} lineend").split
              sty, stx = index("#{ty}.#{tx} linestart").split
              yield fy, fx, efy, efx
              yield sty, stx, ty, tx
            else
              efy, efx = index("#{fy}.#{fx} lineend").split
              yield fy, fx, efy, efx

              ((fy + 1)...ty).each do |y|
                sy, sx = index("#{y}.0 linestart").split
                ey, ex = index("#{y}.0 lineend").split
                yield sy, sx, ey, ex
              end

              sty, stx = index("#{ty}.#{tx} linestart").split
              yield sty, stx, ty, tx
            end
          when :select_line
            fy.upto(ty) do |y|
              sy, sx = index("#{y}.0 linestart").split
              ey, ex = index("#{y}.0 lineend").split
              yield sy, sx, ey, ex
            end
          when :select_block
            yield fy, fx, ty, tx
          else
            Kernel.raise "Not in select mode?"
          end
        end
      end

      # Abstraction for [each_selection] that yields one y coordinate per #
      # line.
      # You usually want to use this if you work with selections.
      def each_selected_line
        each_selection do |fy, fx, ty, tx|
          fy.upto(ty) do |y|
            yield y, fx, tx
          end
        end
      end

      def pipe_selection_execute(*cmd)
        require 'open3'

        Open3.popen3(*cmd) do |si, sose, thread|
          queue = []
          tag_ranges(:sel).each do |from, to|
            si.write(get(from, to))
            queue << from << to
          end

          si.close
          output = sose.read

          return if queue.empty?

          delete(*queue)
          insert(queue.first, output)
        end
      end

      # FIXME: yes, i know i'm calling `tag add` for every line, which makes
      #        things slower, but it seems like there is a bug in the text widget.
      #        So we aggregate the information into a single eval.
      def refresh_selection_block(start)
        ly, lx, ry, rx =
          if compare('insert', '>', start)
            [*index('insert').split, *start.split]
          else
            [*start.split, *index('insert').split]
          end

        from_y, to_y = [ly, ry].sort
        from_x, to_x = [lx, rx].sort

        code = [%(set win "#{tk_pathname}")]

        from_y.upto to_y do |y|
          code << "$win tag add sel #{y}.#{from_x} #{y}.#{to_x + 1}"
        end

        Tk.execute_only(Tk::TclString.new(code.join("\n")))
      end

      def refresh_selection_char(start)
        if compare('insert', '>', start)
          tag_add :sel, start, "insert + 1 chars"
        else
          tag_add :sel, "insert", "#{start} + 1 chars"
        end
      end

      def refresh_selection_line(start)
        if compare('insert', '>', start)
          tag_add :sel, "#{start} linestart", 'insert lineend'
        else
          tag_add :sel, 'insert linestart', "#{start} lineend"
        end
      end
    end
  end
end
