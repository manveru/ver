module VER
  class Text < Tk::Text
    MODE_CURSOR = {
      :insert       => {insertbackground: 'red',    blockcursor: false},
      :control      => {insertbackground: 'green',  blockcursor: true},
      :select_char  => {insertbackground: 'yellow', blockcursor: true},
      :select_line  => {insertbackground: 'yellow', blockcursor: true},
      :select_block => {insertbackground: 'yellow', blockcursor: true},
    }

    attr_accessor :mode, :keymap, :syntax_highlight_in_sync, :status, :view

    def initialize(*args)
      super

      @syntax_highlight_in_sync = false
      @keymap = Keymap.vim(self)

      self.mode = :insert
    end

    def go_char_left(count = 1)
      mark_set :insert, "insert - #{count} char"
    end

    def go_char_right(count = 1)
      mark_set :insert, "insert + #{count} char"
    end

    def go_line_up(count = 1)
      mark_set :insert, "insert - #{count} line"
    end

    def go_line_down(count = 1)
      mark_set :insert, "insert + #{count} line"
    end

    def go_word_left
      mark_set :insert, 'insert - 1 char'
      mark_set :insert, 'insert wordstart'
    end

    def go_word_right
      mark_set :insert, 'insert + 1 char'
      mark_set :insert, 'insert wordend'
    end

    def go_beginning_of_line
      mark_set :insert, 'insert linestart'
    end

    def go_end_of_line
      mark_set :insert, 'insert lineend'
    end

    def go_beginning_of_file
      mark_set :insert, '0.0'
    end

    def go_end_of_file
      mark_set :insert, :end
    end

    def go_page_up
      height = Tk.root.winfo_height
      linespace = cget(:font).metrics(:linespace)
      diff = height / linespace

      mark_set :insert, "insert - #{diff} line"
      see :insert
    end

    def go_page_down
      height = Tk.root.winfo_height
      linespace = cget(:font).metrics(:linespace)
      diff = height / linespace

      mark_set :insert, "insert + #{diff} line"
      see :insert
    end

    def delete_char_left
      delete 'insert - 1 char'
    end

    def delete_char_right
      delete 'insert'
    end

    def insert_newline_below
      mark_set :insert, 'insert lineend'
      insert :insert, "\n"
      start_insert_mode
    end

    def insert_newline_above
      mark_set :insert, 'insert linestart'
      insert :insert, "\n"
      mark_set :insert, 'insert - 1 char'
      start_insert_mode
    end

    def insert_newline
      insert :insert, "\n"
    end

    def insert_space
      insert :insert, ' '
    end

    def insert_tab
      insert :insert, "\t"
    end

    def start_insert_mode
      self.mode = :insert
    end

    def start_control_mode
      self.mode = :control
      # configure insertbackground: 'green'
      # status.configure(background: 'green')
    end

    def start_select_char_mode
      self.mode = :select_char
      @selection_start = index(:insert).split('.').map(&:to_i)
      # configure insertbackground: 'orange'
      # status.configure(background: 'orange')
    end

    def start_select_line_mode
      self.mode = :select_line
      # configure insertbackground: 'orange'
      # status.configure(background: 'orange')
    end

    def start_select_block_mode
      self.mode = :select_block
      # configure insertbackground: 'orange'
      # status.configure(background: 'orange')
    end

    def quit
      Tk.exit
    end

    def copy_selection
      text = get(*tag_ranges(:sel).first)

      TkClipboard.clear
      TkClipboard.append(text)
    end

    def save
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

      VER.status.value = "Saved to #{path}"
    end

    def save_to(to)
      from = view.file_path
      save_smart(from, to)
    rescue => ex
      puts ex, *ex.backtrace
      save_dumb(from, to)
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

      # p [from, temp_path, to]
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

      VER.file_open(fpath)
    end

    # lines start from 1
    # end is maximum lines + 1
    def status_projection(into)
      format = "%d,%d  %d%%"

      insert_y, insert_x = index(:insert).split('.').map(&:to_i)
      end_y, end_x       = index(:end   ).split('.').map(&:to_i)

      percent = (100.0 / (end_y - 2)) * (insert_y - 1)

      values = [
        insert_y, insert_x,
        percent,
      ]

      into.value = format % values
    end

    # Wrap Tk methods to behave as we want and to generate events

    def mark_set(mark_name, index)
      super

      Tk.event_generate(self, '<Movement>')

      if @mode =~ /^select/ && start = @selection_start
        now = index(:insert).split('.').map(&:to_i)
        left, right = [start, now].sort.map{|pos| pos.join('.') }
        tag_remove :sel, '0.0', 'end'
        tag_add :sel, left, right
      end

      see :insert if mark_name == :insert
    end

    def undo
      edit_undo
      refresh_highlight
    rescue RuntimeError => ex
      status.value = ex.message
    end

    def redo
      edit_redo
      refresh_highlight
    rescue RuntimeError => ex
      status.value = ex.message
    end

    def delete(*args)
      super
      refresh_highlight
    end

    def delete_movement(movement)
      p :delete_movement => movement
    end

    def insert(*args)
      super
      refresh_highlight
    end

    def refresh_highlight
      @highlighter ||= Thread.new{
        sleep 0.1 # give @highlighter time to be defined
        loop do
          sleep 0.01 until @highlighter[:needed]
          syntax = Syntax.from_filename(__FILE__)
          syntax.highlight(self, value)
          @highlighter[:needed] = false
        end
      }

      @highlighter[:needed] = true
    end

    private

    def mode=(name)
      @keymap.current_mode = @mode = name.to_sym

      cursor = MODE_CURSOR[@mode]

      configure cursor
      # status.configure(background: cursor[:insertbackground])
    end
  end
end
