module VER
  module Methods
    module Control
      module_function

      def enter(text, old_mode, new_mode)
        clean_line(text, :insert)
      end

      def leave(text, old_mode, new_mode)
        # clean_line(text, :insert)
      end

      def temporary(buffer, action)
        action.to_method(buffer).call
      end

      def insert_at(text, motion, *count)
        Move.send(motion, text, *count)
        text.minor_mode(:control, :insert)
      end

      def insert_indented_newline_above(text)
        Insert.insert_indented_newline_above(text)
      end

      def insert_indented_newline_below(text)
        Insert.insert_indented_newline_below(text)
      end

      def open_file_under_cursor(text)
        Open.open_file_under_cursor(text)
      end

      def source_buffer(buffer)
        if filename = buffer.filename
          buffer.message("Source #{filename}")
          load(filename.to_s)
        else
          buffer.warn("#{buffer.uri} is no file")
        end
      end

      def cursor_vertical_top(text)
        insert = text.count('1.0', 'insert', :displaylines)
        last   = text.count('1.0', 'end', :displaylines)

        fraction = ((100.0 / last) * insert) / 100

        text.yview_moveto(fraction)
      end

      def cursor_vertical_top_sol(text)
        cursor_vertical_top(text)
        Move.start_of_line(text)
      end

      def cursor_vertical_center(text, index = :insert)
        insert = text.count('1.0', index, :displaylines)
        last   = text.count('1.0', 'end', :displaylines)
        shown  = text.count('@0,0', "@0,#{text.winfo_height}", :displaylines)

        fraction = ((100.0 / last) * (insert - (shown / 2))) / 100

        text.yview_moveto(fraction)
      end

      def cursor_vertical_center_sol(text)
        cursor_vertical_center(text)
        Move.start_of_line(text)
      end

      def cursor_vertical_bottom(text)
        insert = text.count('1.0', 'insert', :displaylines) + 1
        last   = text.count('1.0', 'end', :displaylines)
        shown  = text.count('@0,0', "@0,#{text.winfo_height}", :displaylines)

        fraction = ((100.0 / last) * (insert - shown)) / 100

        text.yview_moveto(fraction)
      end

      def cursor_vertical_bottom_sol(text)
        cursor_vertical_bottom(text)
        start_of_line(text)
      end

      def cursor_horizontal_center(buffer)
        x, y, width, height = *buffer.bbox('insert')
        line_middle = y + (height / 2) # gives less room for error?
        buffer_middle = buffer.winfo_width / 2
        set("@#{buffer_middle},#{y}")
      end

      def chdir(text)
        text.ask 'Change to: ' do |path, action|
          case action
          when :attempt
            path = File.expand_path(path.to_s)

            begin
              Dir.chdir(path)
              text.message 'Changed working directory to %s' % [path]
              :abort
            rescue Errno::ENOENT => ex
              VER.warn ex
            end
          end
        end
      end

      # Toggle case of the character under the cursor up to +count+ characters
      # forward (+count+ is inclusive the first character).
      # This only works for alphabetic ASCII characters, no other encodings.
      def toggle_case(text, count = text.prefix_count)
        from, to = 'insert', "insert + #{count} chars"
        chunk = text.get(from, to)
        chunk.tr!('a-zA-Z', 'A-Za-z')
        text.replace(from, to, chunk)
      end

      # Assigns env variables used in the given command.
      # - $f: The current buffer's filename
      # - $d: The current buffer's directory
      # - $F: A space-separated list of all buffer filenames
      # - $i: A string acquired from the user with a prompt
      # - $c: The current clipboard text
      # - $s: The currently selected text
      #
      # @param [String] command
      #   The string containing the command executed
      def prepare_exec(text, command)
        prepare_exec_f(text) if command =~ /\$f/
        prepare_exec_d(text) if command =~ /\$d/
        prepare_exec_F(text) if command =~ /\$F/
        prepare_exec_i(text) if command =~ /\$i/
        prepare_exec_c(text) if command =~ /\$c/
        prepare_exec_s(text) if command =~ /\$s/
      end

      def prepare_exec_f(text)
        p f: (ENV['f'] = filename.to_s)
      end

      def prepare_exec_d(text)
        p d: (ENV['d'] = filename.directory.to_s)
      end

      def prepare_exec_F(text)
        p F: (ENV['F'] = VER.buffers.map{|key, buffer| buffer.filename }.join(' '))
      end

      def prepare_exec_i(text)
        raise NotImplementedError
      end

      def prepare_exec_c(text)
        p c: (ENV['c'] = clipboard_get)
      end

      def prepare_exec_s(text)
        content = []

        each_selected_line do |y, fx, tx|
          content << get("#{y}.#{fx}", "#{y}.#{tx}")
        end

        ENV['s'] = content.join("\n")
      end

      ENV_EXPORTERS = %w[
        current_line current_word directory filepath line_index line_number
        scope selected_text
      ]

      # Set up the env for a script, then execute it.
      # For now, I only setup the env, until we figure out a good way to find
      # bundle commands.
      def exec_bundle
        ENV_EXPORTERS.each do |exporter|
          ENV["VER_#{exporter.upcase}"] = ENV["TM_#{exporter.upcase}"] =
            send("exec_env_#{exporter}").to_s
        end

        yield if block_given?
      end

      # textual content of the current line
      def exec_env_current_line
        get('insert linestart', 'insert lineend')
      end

      # the word in which the caret is located.
      def exec_env_current_word
        get('insert wordstart', 'insert wordend')
      end

      # the folder of the current document (may not be set).
      def exec_env_directory
        filename.dirname.to_s
      end

      # path (including file name) for the current document (may not be set).
      def exec_env_filepath
        filename.to_s
      end

      # the index in the current line which marks the caret's location.
      # This index is zero-based and takes the utf-8 encoding of the line (e.g.
      # read as TM_CURRENT_LINE) into account.
      def exec_env_line_index
        index('insert').x
      end

      # the carets line position (counting from 1).
      def exec_env_line_number
        index('insert').y
      end

      def exec_env_scope
        tag_names('insert').join(', ')
      end

      # full content of the selection (may not be set).
      # Note that environment variables have a size limitation of roughly 64 KB,
      # so if the user selects more than that, this variable will not reflect
      # the actual selection (commands that need to work with the selection
      # should generally set this to be the standard input).
      def exec_env_selected_text
        content = []

        each_selected_line do |y, fx, tx|
          content << get("#{y}.#{fx}", "#{y}.#{tx}")
        end

        content.join("\n")
      end

      def exec_into_new(text, command = nil)
        if command
          target = text.options.home_conf_dir/'shell-result.txt'
          prepare_exec(command)
          system(command)
          target.open('w+'){|io| io.write(`#{command}`) }
          VER.find_or_create_buffer(target)
        else
          text.ask 'Command: ' do |answer, action|
            case action
            when :attempt
              begin
                exec_into_new(answer)
                :abort
              rescue => ex
                VER.warn(ex)
              end
            end
          end
        end
      end

      def exec_into_void(text)
        text.ask 'Command: ' do |command, action|
          case action
          when :attempt
            begin
              system(command)
              text.message("Exit code: #{$?}")
              :abort
            rescue => ex
              VER.warn(ex)
            end
          end
        end
      end

      # Substitute over all lines of the buffer
      def gsub(text, regexp, with)
        total = 0
        Undo.record text do |record|
          text.index('1.0').upto(text.index('end')) do |index|
            lineend = index.lineend
            line = text.get(index, lineend)

            if line.gsub!(regexp, with)
              record.replace(index, lineend, line)
              total += 1
            end
          end
        end

        text.message "Performed gsub on #{total} lines"
      end

      # Substitute on current line
      def sub(text, regexp, with)
        linestart = text.index('insert linestart')
        lineend = linestart.lineend
        line = text.get(linestart, lineend)

        if line.sub!(regexp, with)
          text.replace(linestart, lineend, line)
        end
      end

      def executor(text, action = nil)
        VER::Executor.new(text, action: action)
      end
      alias ex executor
      module_function :ex

      def wrap_line(text)
        content = text.get('insert linestart', 'insert lineend')
        textwidth = text.options.textwidth
        lines = wrap_lines_of(content, textwidth).join("\n")
        lines.rstrip!

        text.replace('insert linestart', 'insert lineend', lines)
      end

      def smart_evaluate(text)
        if sel = text.tag_ranges(:sel)
          from, to = sel.first
          return Selection.evaluate(text) if from && to
        end

        line_evaluate(text)
      end

      def line_evaluate(text)
        code = text.get('insert linestart', 'insert lineend')
        file = (text.filename || text.uri).to_s
        stdout_capture_evaluate(code, file, binding) do |res, out|
          text.at_insert.lineend.insert("\n%s%p" % [out, res])
        end
      end

      def stdout_capture_evaluate(code, file, binding = binding)
        begin
          old_stdout = $stdout.dup
          rd, wr = IO.pipe
          $stdout.reopen(wr)
          result = eval(code, binding, file.to_s)
          $stdout.reopen old_stdout; wr.close
          stdout = rd.read

          yield(result, stdout)
        rescue Exception => exception
          yield(exception, '')
        ensure
          wr.closed? || $stdout.reopen(old_stdout) && wr.close
          rd.closed? || rd.close
        end
      end

      # for some odd reason, vim likes to have arbitrary commands that reduce
      # the argument by one if it's greater 1...
      def join_forward(buffer, count = buffer.prefix_count)
        count = count > 1 ? (count - 1) : count
        buffer.undo_record do |record|
          count.times do
            buffer.insert = buffer.at_insert.lineend
            record.replace('insert', 'insert + 1 chars', ' ')
          end
        end
      end

      def join_forward_nospace(buffer, count = buffer.prefix_count)
        count = count > 1 ? (count - 1) : count
        buffer.undo_record do |record|
          count.times do
            buffer.insert = buffer.at_insert.lineend
            record.replace('insert', 'insert + 1 chars', '')
          end
        end
      end

      def join_backward(text)
        from, to = 'insert - 1 lines linestart', 'insert lineend'
        lines = text.get(from, to)
        text.replace(from, to, lines.gsub(/\s*\n\s*/, ' '))
      end

      def indent_line(text, count = text.prefix_count)
        indent = (' ' * text.options[:shiftwidth] * count)
        text.insert('insert linestart', indent)
      end

      def unindent_line(text, count = text.prefix_count)
        indent = ' ' * text.options[:shiftwidth]
        replace_from = 'insert linestart'
        replace_to = "insert linestart + #{indent.size} chars"

        Undo.record text do |record|
          count.times do
            line = text.get('insert linestart', 'insert lineend')

            return unless line.start_with?(indent)

            record.replace(replace_from, replace_to, '')
          end
        end
      end

      def clean_line(text, index, record = text)
        index = text.index(index)
        from, to = index.linestart, index.lineend
        line = text.get(from, to)
        bare = line.rstrip
        record.replace(from, to, bare) if bare.empty?
      end

      def wrap_lines_of(content, wrap = 80)
        Kernel.raise ArgumentError, "+wrap+ must be > 1" unless wrap > 1
        wrap -= 1

        indent = content[/^\s+/] || ''
        indent_size = indent.size
        lines = [indent.dup]

        content.scan(/\S+/) do |chunk|
          last = lines.last
          last_size = last.size
          chunk_size = chunk.size

          if last_size + chunk_size > wrap
            lines << indent + chunk
          elsif last_size == indent_size
            last << chunk
          elsif chunk =~ /\.$/
            last << ' ' << chunk
            lines << indent.dup
          else
            last << ' ' << chunk
          end
        end

        lines.pop if lines.last == indent
        lines
      end
    end
  end
end
