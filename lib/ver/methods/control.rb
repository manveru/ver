module VER
  module Methods
    module Control
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
          eval(term)
        end
      end

      def smart_evaluate
        from, to = tag_ranges(:sel).first

        if from && to
          selection_evaluate
        else
          line_evaluate
        end
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
        rescue => exception
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

        fpath = Tk.getOpenFile(filetypes: filetypes)

        return if fpath.empty?

        view.find_or_create(fpath)
      end

      def file_open_fuzzy
        View::List::FuzzyFileFinder.new self do |path|
          view.find_or_create(path)
        end
      end

      def join_lines
        start_of_next_line = search(/\S/, 'insert lineend')
        replace('insert lineend', start_of_next_line, ' ')
      rescue RuntimeError => exception
        return if exception.message =~ /Index "\d+\.\d+" before "insert lineend" in the text/
        raise exception
      end

      # Most of the input will be in US-ASCII, but an encoding can be set per view for the input.
      # For just about all purposes, UTF-8 should be what you want to input, and it's what Tk
      # can handle best.
      def insert_string(string)
        return if string.empty?

        if !string.frozen? && string.encoding == Encoding::ASCII_8BIT
          begin
            string.encode!(@encoding)
          rescue Encoding::UndefinedConversionError
            string.force_encoding(@encoding)
          end
        end

        # puts "Insert %p in mode %p" % [string, keymap.mode]
        insert :insert, string
      end

      def replace_char
        status_ask 'Replace with: ', take: 1 do |char|
          if char.size == 1
            replace('insert', 'insert + 1 chars', char)
            go_char_left
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

      def insert_indented_newline_below
        line = get('insert linestart', 'insert lineend')

        indent = line.empty? ? "" : (line[/^\s+/] || '')
        mark_set :insert, 'insert lineend'
        insert :insert, "\n#{indent}"

        start_insert_mode
      end

      def insert_indented_newline_above
        if index(:insert).y > 1
          go_line_up
          insert_indented_newline_below
        else
          insert('insert linestart', "\n")
          mark_set(:insert, 'insert - 1 line')
        end

        start_insert_mode
      end

      def insert_newline
        insert :insert, "\n"
      end

      def insert_indented_newline
        line1 = get('insert linestart', 'insert lineend')
        indentation1 = line1[/^\s+/] || ''
        insert :insert, "\n"

        line2 = get('insert linestart', 'insert lineend')
        indentation2 = line2[/^\s+/] || ''

        replace(
          'insert linestart',
          "insert linestart + #{indentation2.size} chars",
          indentation1
        )

        clean_previous_line
      end

      def clean_previous_line
        from, to = index('insert - 1 line linestart'), index('insert - 1 line lineend')
        line = get(from, to)
        bare = line.rstrip
        replace(from, to, bare) if bare.empty?
      end

      def insert_tab
        insert :insert, "\t"
      end

      def after_char_insert_mode
        go_char_right
        start_insert_mode
      end

      def eol_then_insert_mode
        go_end_of_line
        start_insert_mode
      end

      def sol_then_insert_mode
        go_beginning_of_line
        start_insert_mode
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
        raise ArgumentError, "+wrap+ must be > 1" unless wrap > 1
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

