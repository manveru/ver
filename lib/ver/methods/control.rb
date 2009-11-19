module VER
  module Methods
    module Control
      # Substitute over all lines of the buffer
      def gsub(regexp, with)
        total = 0
        index('1.0').upto(index('end')) do |index|
          lineend = index.lineend
          line = get(index, lineend)

          if line.gsub!(regexp, with)
            replace(index, lineend, line)
            total += 1
          end
        end

        message "Performed gsub on #{total} lines"
      end

      # Substitute on current line
      def sub(regexp, with)
        linestart = index('insert linestart')
        lineend = linestart.lineend
        line = get(linestart, lineend)

        if line.sub!(regexp, with)
          replace(linestart, lineend, line)
        end
      end

      def open_grep_list
        View::List::Grep.new self do |file, line|
          view.find_or_create(file, line)
        end
      end

      def open_method_list
        View::List::Methods.new self do |file, line|
          view.find_or_create(file, line)
        end
      end

      # TODO: make this better?
      def status_ex
        completion = method(:status_ex_filter)

        View::List::Ex.new self, completion do |command|
          begin
            result = eval(command)
            status.message "%s # => %p" % [command, result]
          rescue Exception => ex
            status.error "%s # => %p" % [command, ex]
          end
        end
      end

      def status_ex_filter(input)
        input = input.to_s.split.last
        return [] if !input || input.empty?

        begin
          regexp = Regexp.new(input)
        rescue ArgumentError, RegexpError, SyntaxError
          regexp = Regexp.new(Regexp.escape(input))
        end

        self.methods.grep(regexp).sort_by{|sym| sym =~ regexp }
      end

      def open_console
        View::Console.new(self)
      end

      def open_terminal
        require 'ver/view/term'
        View::Terminal.new(self)
      end

      def wrap_line
        text = get('insert linestart', 'insert lineend')
        lines = wrap_lines_of(text, 80).join("\n")
        lines.rstrip!

        replace('insert linestart', 'insert lineend', lines)
      end

      def status_theme_select
        return unless @syntax

        status_ask 'Theme name: ' do |name|
          load_theme(name) || "No theme called #{name} found"
        end
      end

      def theme_switch
        return unless @syntax

        View::List::Theme.new(self){|name| load_theme(name) }
      end

      def syntax_switch
        return unless @syntax

        View::List::Syntax.new(self){|name| load_syntax(name) }
      end

      def status_evaluate
        status_ask 'Eval expression: ' do |term|
          begin
            eval(term)
          rescue Exception => ex
            ex
          end
        end
      end

      def smart_evaluate
        if sel = tag_ranges(:sel)
          from, to = sel.first
          return selection_evaluate if from && to
        end

        line_evaluate
      end

      def line_evaluate
        text = get('insert linestart', 'insert lineend')
        stdout_capture_evaluate(text) do |res,out|
          insert("insert lineend", "\n%s%p" % [out, res] )
        end
      end

      def stdout_capture_evaluate(code)
        begin
          old_stdout = $stdout.dup
          rd, wr = IO.pipe
          $stdout.reopen(wr)
          result = eval(code)
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

      def buffer_switch
        View::List::Buffer.new self do |file|
          view.find_or_create(file) if File.exists?(file)
        end
      end

      def window_switch(count = nil)
        if count
          # p count: count
        else
          View::List::Window.new self do |view|
            view.push_top
            view.focus
          end
        end
      end

      def file_open_popup
        filetypes = [
          ['ALL Files',  '*'    ],
          ['Text Files', '*.txt'],
        ]

        fpath = Tk.get_open_file(filetypes: filetypes)

        return unless fpath

        view.find_or_create(fpath)
      end

      def file_open_fuzzy
        View::List::FuzzyFileFinder.new self do |path|
          view.find_or_create(path)
        end
      end

      def join_lines
        start_of_next_line = search(/\S/, 'insert lineend').first
        replace('insert lineend', start_of_next_line, ' ')
      rescue RuntimeError => exception
        return if exception.message =~ /Index "\d+\.\d+" before "insert lineend" in the text/
        Kernel.raise exception
      end

      def replace_char
        status_ask 'Replace with: ', take: 1 do |char|
          if char.size == 1
            replace('insert', 'insert + 1 chars', char)
            backward_char
            "replaced #{char.size} chars"
          else
            status.message 'replace aborted'
          end
        end
      end

      def indent_line
        insert('insert linestart', '  ')
      end

      def unindent_line
       line = get('insert linestart', 'insert lineend')

       return unless line =~ /^(\s\s?)/

       replace(
         'insert linestart',
         "insert linestart + #{$1.size} chars",
         ''
       )
      end

      def clean_previous_line
        from, to = index('insert - 1 line linestart'), index('insert - 1 line lineend')
        line = get(from, to)
        bare = line.rstrip
        replace(from, to, bare) if bare.empty?
      end

      def start_insert_mode
        self.mode = :insert
      end

      def start_control_mode
        self.mode = :control
      end

      def copy_line
        copy get('insert linestart', 'insert lineend + 1 chars')
      end

      def copy_right_word
        copy get('insert', 'insert wordend')
      end

      def copy_left_word
        copy get('insert', 'insert wordstart')
      end

      # FIXME: nasty hack or neccesary?
      def paste
        text = Tk::Clipboard.get
        paste_continous text

      rescue RuntimeError => ex
        if ex.message =~ /form "STRING" not defined/
          array = Tk::Clipboard.get type: Array
          paste_tk_array array
        else
          Kernel.raise ex
        end
      end

      def undo
        edit_undo
        touch!
      rescue RuntimeError => ex
        status.value = ex.message
      end

      def redo
        edit_redo
        touch!
      rescue RuntimeError => ex
        status.value = ex.message
      end

      private

      def wrap_lines_of(text, wrap = 80)
        Kernel.raise ArgumentError, "+wrap+ must be > 1" unless wrap > 1
        wrap -= 1

        indent = text[/^\s+/] || ''
        indent_size = indent.size
        lines = [indent.dup]

        text.scan(/\S+/) do |chunk|
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

        lines
      end

      def status_ask(prompt, options = {}, &callback)
        @status.ask(prompt, options){|*args|
          begin
            callback.call(*args)
          rescue => ex
            VER.error(ex)
          ensure
            begin
              focus
            rescue RuntimeError
              # might have been destroyed, stay silent
            end
          end
        }
      end
    end
  end
end
