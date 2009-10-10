module VER
  module Methods
    module Control
      def status_theme_select
        return unless @highlight_syntax

        status_ask 'Theme name: ' do |name|
          load_theme(name) || "No theme called #{name} found"
        end
      end

      def theme_switch
        return unless @highlight_syntax

        ThemeListView.new(self){|name| load_theme(name) }
      end

      def syntax_switch
        return unless @highlight_syntax

        SyntaxListView.new(self){|name| load_syntax(name) }
      end

      def status_evaluate
        status_ask 'Eval expression: ' do |term|
          eval(term)
        end
      end

      def status_ask(prompt, &callback)
        @status.ask(prompt){|*args|
          begin
            callback.call(*args)
          rescue => ex
            p ex
            status.message ex.message
          ensure
            focus
          end
        }
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
        result = eval(text)
        insert("insert lineend", "\n#{result.inspect}\n")
      end

      def buffer_switch(count = nil)
        if count
          p count: count
        else
          BufferListView.new self do |view|
            view.focus
            # open_path(path)
          end
        end
      end

      def file_save
        save_to(filename)
      end

      def file_save_popup
        filetypes = [
          ['ALL Files',  '*'    ],
          ['Text Files', '*.txt'],
        ]

        filename  = ::File.basename @filename
        extension = ::File.extname  @filename
        directory = ::File.dirname  @filename

        fpath = Tk.getSaveFile(
          initialfile: filename,
          initialdir: directory,
          defaultextension: extension,
          filetypes: filetypes
        )

        return if fpath.empty?

        save_to(fpath)
      end

      # Some strategies are discussed at:
      #
      # http://bitworking.org/news/390/text-editor-saving-routines
      #
      # I try another, "wasteful" approach, copying the original file to a
      # temporary location, overwriting the contents in the copy, then moving the
      # file to the location of the original file.
      #
      # This way all permissions should be kept identical without any effort, but
      # it will take up additional disk space.
      #
      # If there is some failure during the normal saving procedure, we will
      # simply overwrite the original file in place, make sure you have good insurance ;)
      def save_to(to)
        save_smart(filename, to)
      rescue => ex
        puts "#{ex.class}: #{ex}", *ex.backtrace
        save_dumb(filename, to)
      end

      def save_smart(from, to)
        sha1 = Digest::SHA1.hexdigest([from, to].join)
        temp_path = File.join(Dir.tmpdir, 'ver', sha1)
        temp_dir = File.dirname(temp_path)

        FileUtils.mkdir_p(temp_dir)
        FileUtils.copy_file(from, temp_path, preserve = true)
        File.open(temp_path, 'w+') do |io|
          io.write(self.value)
        end
        FileUtils.mv(temp_path, to)

        status.message "Saved to #{to}"
      rescue Errno::ENOENT
        save_dumb(to)
      end

      def save_dumb(to)
        File.open(to, 'w+') do |io|
          io.write(self.value)
        end

        status.message "Saved to #{to}"
      end

      def file_open_popup
        filetypes = [
          ['ALL Files',  '*'    ],
          ['Text Files', '*.txt'],
        ]

        fpath = Tk.getOpenFile(filetypes: filetypes)

        return if fpath.empty?

        open_path(fpath)
      end

      def file_open_fuzzy
        FuzzyFileFinderView.new self do |path|
          open_path(path)
        end
      end

      def delete_char_left
        delete 'insert - 1 char'
      end

      def delete_char_right
        delete 'insert'
      end

      def delete_word_right
        delete 'insert', 'insert wordend'
      end

      def delete_word_left
        delete 'insert wordstart', 'insert'
      end

      def delete_line
        delete 'insert linestart', 'insert lineend + 1 char'
      end

      def delete_to_eol
        delete 'insert', 'insert lineend'
      end

      def delete_to_eol_then_insert
        delete_to_eol
        start_insert_mode
      end

      def join_lines
        start_of_next_line = search(/\S/, 'insert lineend')
        replace('insert lineend', start_of_next_line, ' ')
      rescue RuntimeError => exception
        return if exception.message =~ /Index "\d+\.\d+" before "insert lineend" in the text/
        raise exception
      end

      def insert_string(string)
        # puts "Insert %p in mode %p" % [string, keymap.mode]
        insert :insert, string unless string.empty?
      end

      def ignore_string(string)
        status.message "Ignore %p in mode %p" % [string, keymap.mode]
      end

      def replace_char
        status_ask 'Replace with: ' do |string|
          replace('insert', 'insert + 1 chars', string)
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

        if line.empty?
          insert('insert lineend', "\n")
        else
          indentation = line[/^\s+/] || ''
          insert('insert lineend', "\n" << indentation)
          mark_set(:insert, 'insert + 1 line lineend')
        end

        start_insert_mode
      end

      def insert_indented_newline_above
        y, x = index(:insert).split('.').map(&:to_i)

        if y > 1
          go_line_up
          insert_indented_newline_below
        else
          insert('insert linestart', "\n")
          mark_set(:insert, 'insert - 1 line')
        end
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
      end

      def insert_tab
        insert :insert, "\t"
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
        text = TkClipboard.get
        paste_continous text

      rescue RuntimeError => ex
        if ex.message =~ /form "STRING" not defined/
          array = TkClipboard.get type: Array
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
    end
  end
end