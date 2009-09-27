module VER
  module Methods
    module Control
      def status_search
        status_ask 'Search term: ' do |term|
          tag_all_matching(:search, Regexp.new(term))
        end
      end

      def search_next
        from, to = tag_nextrange('search', 'insert + 1 chars', 'end')
        mark_set(:insert, from) if from
      end

      def search_prev
        from, to = tag_prevrange('search', 'insert - 1 chars', '0.0')
        mark_set(:insert, from) if from
      end

      def search_next_word_under_cursor
        word = get('insert wordstart', 'insert wordend')
        tag_all_matching(:search, word)
        search_next
      end

      def search_prev_word_under_cursor
        word = get('insert wordstart', 'insert wordend')
        tag_all_matching(:search, word)
        search_prev
      end

      def status_evaluate
        status_ask 'Eval expression: ' do |term|
          eval(term)
        end
      end

      def status_ask(prompt, &callback)
        VER.status.ask(prompt){|*args|
          begin
            callback.call(*args)
          rescue => ex
            p ex
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
        insert("insert lineend", "\n#{result.inspect}")
      end

      def buffer_switch(count = 0)
        # p buffer_switch: count
        frame = TkFrame.new{
          pack fill: :both, expand: true
        }

        list = Tk::Listbox.new(frame){
          setgrid 'yes'
          width 0
          pack fill: :both, expand: true
        }

        input = Ttk::Entry.new(frame){
          pack fill: :x, expand: false
          focus
        }

        cleanup = lambda{
          input.destroy
          list.destroy
          frame.destroy
          focus
        }

        all_elements = VER.paths
        list.insert :end, *all_elements

        tag = TkBindTag.new
        tags = input.bindtags
        tags[tags.index(input.class) + 1, 0] = tag
        input.bindtags = tags

        tag.bind('Key'){
          value = input.value

          if value == value.downcase
            sub_elements = all_elements.select{|element|
              element.downcase.include?(value)
            }
          else
            sub_elements = all_elements.select{|element|
              element.include?(value)
            }
          end

          list.delete(0, :end)
          list.insert :end, *sub_elements
        }

        tag.bind('Return'){
          if list.size > 1
            p 'not specific enough'
          elsif list.size == 1
            view.file_open(list.get(0))
            cleanup.call
          else
            p 'too specific'
          end
        }

        tag.bind('Escape', &cleanup)
        tag.bind('Control-c', &cleanup)

        # list.bind("Double-Button-1"){
        #   selection = TkSelection.get
        #   p selection: selection
        # }
      end

      def file_save
        save_to(view.file_path)
      end

      def file_save_popup
        filetypes = [
          ['ALL Files',  '*'    ],
          ['Text Files', '*.txt'],
        ]

        path = view.file_path
        filename  = ::File.basename path
        extension = ::File.extname  path
        directory = ::File.dirname  path

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
        from = view.file_path
        save_smart(from, to)

        status.value = "Saved to #{to}"
      rescue => ex
        puts ex, *ex.backtrace
        save_dumb(from, to)

        status.value = "Saved to #{to}"
      end

      def save_smart(from, to)
        sha1 = Digest::SHA1.hexdigest([from, to].join)
        temp_path = File.join(Dir.tmpdir, 'ver', sha1)
        temp_dir = File.dirname(temp_path)

        FileUtils.mkdir_p(temp_dir)
        FileUtils.cp(from, temp_path)
        File.open(temp_path, 'w+') do |io|
          io.write(self.value)
        end
        FileUtils.mv(temp_path, to)
      end

      def save_dumb(from, to)
        File.open(to, 'w+') do |io|
          io.write(self.value)
        end
      end

      def file_open_popup
        filetypes = [
          ['ALL Files',  '*'    ],
          ['Text Files', '*.txt'],
        ]

        fpath = Tk.getOpenFile(filetypes: filetypes)

        return if fpath.empty?

        view.file_open(fpath)
      end

      def delete_char_left
        delete 'insert - 1 char'
      end

      def delete_char_right
        delete 'insert'
      end

      def delete_line
        delete 'insert linestart', 'insert lineend + 1 char'
      end

      def delete_to_eol
        delete 'insert', 'insert lineend'
      end

      def insert_string(string)
        puts "Insert %p in mode %p" % [string, keymap.current_mode]
        insert :insert, string unless string.empty?
      end

      def ignore_character(char)
        puts "Ignore %p in mode %p" % [char, keymap.current_mode]
      end

      def insert_indented_newline_below
        mark_set :insert, 'insert lineend'
        insert :insert, "\n"
        start_insert_mode
      end

      def insert_indented_newline_above
        mark_set :insert, 'insert linestart'
        insert :insert, "\n"
        mark_set :insert, 'insert - 1 char'
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

      def start_selection_mode(name)
        self.mode = name
        @selection_start = index(:insert).split('.').map(&:to_i)
        refresh_selection
      end

      def switch_selection_mode(name)
        start = @selection_start
        self.mode = name
        @selection_start = start
        refresh_selection
      end

      def start_select_char_mode
        start_select_char_mode :select_char
      end

      def switch_select_char_mode
        switch_selection_mode :select_char
      end

      def start_select_line_mode
        start_selection_mode :select_line
      end

      def switch_select_line_mode
        switch_selection_mode :select_line
      end

      def start_select_block_mode
        start_selection_mode :select_block
      end

      def switch_select_block_mode
        switch_selection_mode :select_block
      end

      def quit
        Tk.exit
      end

      def selection_evaluate(name = :sel)
        from, to = tag_ranges(name).first
        text = get(from, to)

        result = eval(text)

        insert("#{to} lineend", "\n#{result.inspect}")
      rescue => ex
        insert("#{to} lineend", "\n#{ex.inspect}")
      end

      def copy_selection(name = :sel)
        text = get(*tag_ranges(:sel).first)

        TkClipboard.clear
        TkClipboard.append(text)
      end

      def paste
        text = TkClipboard.get
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

      def delete_movement(movement)
        p delete_movement: movement
      end
    end
  end
end
