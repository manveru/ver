module VER
  module Methods
    module Select
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

      def delete_selection
        queue = tag_ranges(:sel).flatten
        delete(*queue)
        mark_set(:insert, queue.first)

        finish_selection
      end

      def indent_selection
        each_selected_line do |y, fx, tx|
          tx = fx + 2
          next if get("#{y}.#{fx}", "#{y}.#{tx}").empty?
          insert("#{y}.#{fx}", '  ')
        end

        edit_separator
        refresh_selection
      end

      def unindent_selection
        queue = []

        each_selected_line do |y, fx, tx|
          tx = fx + 2
          left, right = "#{y}.#{fx}", "#{y}.#{tx}"
          next unless get(left, right) == '  '
          queue << left << right
        end

        delete(*queue)
        edit_separator
        refresh_selection
      end

      def selection_evaluate
        tag_ranges(:sel).each do |from, to|
          code = get(from, to)

          begin
            result = eval(code)
            insert("#{to} lineend", "\n%p" % [result])
          rescue => exception
            insert("#{to} lineend", "\n%p" % [exception])
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
        each_selected_line do |y, fx, tx|
          insert("#{y}.0 linestart", '# ')
        end

        edit_separator
        refresh_selection
      end

      def uncomment_selection
        each_selected_line do |y, fx, tx|
          delete("#{y}.0 linestart", "#{y}.0 linestart + 2 chars")
        end

        edit_separator
        refresh_selection
      end

      def replace_selection_with_char
        status_ask 'Replace selection with: ', take: 1 do |char|
          if char.size == 1
            pos = index(:insert)
            each_selected_line do |y, fx, tx|
              tx = fx + 1
              next if get("#{y}.#{fx}", "#{y}.#{tx}").empty?
              replace("#{y}.#{fx}", "#{y}.#{tx}", char)
            end

            edit_separator
            mark_set :insert, pos
            "replaced #{char.size} chars"
          else
            status.message 'replace aborted'
          end
        end
      end

      private

      def finish_selection(mode = nil)
        edit_separator
        clear_selection
        mode ? self.mode = mode : keymap.use_previous_mode
        apply_mode_style(keymap.mode)
      end

      def clear_selection
        self.selection_start = nil
        tag_remove :sel, '1.0', 'end'
      end

      def each_selection
        tag_ranges(:sel).each do |sel|
          (fy, fx), (ty, tx) = sel.map{|pos| pos.split('.').map(&:to_i) }
          yield fy, fx, ty, tx
        end
      end

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
    end
  end
end
