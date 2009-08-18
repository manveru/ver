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

    def go_char_left
      mark_set :insert, 'insert - 1 char'
      see :insert
    end

    def go_char_right
      mark_set :insert, 'insert + 1 char'
      see :insert
    end

    def go_line_up
      mark_set :insert, 'insert - 1 line'
      see :insert
    end

    def go_line_down
      mark_set :insert, 'insert + 1 line'
      see :insert
    end

    def go_word_left
      mark_set :insert, 'insert - 1 char'
      mark_set :insert, 'insert wordstart'
      see :insert
    end

    def go_word_right
      mark_set :insert, 'insert + 1 char'
      mark_set :insert, 'insert wordend'
      see :insert
    end

    def go_beginning_of_file
      mark_set :insert, '0.0'
      see :insert
    end

    def go_end_of_file
      mark_set :insert, :end
      see :insert
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

    def save
    end

    def save_as
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

    # Wrap Tk methods to behave as we want and to generate events

    def mark_set(mark_name, index)
      Tk.event_generate(self, '<Movement>')

      super

      if @mode =~ /^select/ && start = @selection_start
        now = index(:insert).split('.').map(&:to_i)
        p start: start, now: now
        left, right = [start, now].sort.map{|pos| pos.join('.') }
        tag_remove :sel, '0.0', 'end'
        tag_add :sel, left, right
      end
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
