module VER
  class View < TkFrame
    attr_reader :text, :status, :file_path

    def initialize(parent, options = {})
      super
      setup
    end

    # +-------+---+
    # |       | @ |
    # |       | y |
    # | @text | b |
    # |       | a |
    # |       | r |
    # +-------+---+
    # | @xbar |   |
    # +-------+---+
    # |  @status  |
    # +-----------+
    def setup
      setup_text
      setup_scrollbars
      setup_status
      setup_grid
      setup_misc
    end

    def setup_text
      @text = VER::Text.new(
        self,
        font: 'Terminus 9',
        undo: true,
        tabstyle: 'wordprocessor',
        tabs: ['2c', '4c', '6c'],
        autoseparators: true,
        setgrid: true,
        exportselection: true,
        borderwidth: 0,
        insertbackground: '#f00',
        insertofftime: 0
      )
    end

    def setup_scrollbars
      # vertical scrollbar
      @ybar = Ttk::Scrollbar.new(self)
      @text.yscrollbar(@ybar)

      # horizontal scrollbar
      @xbar = Ttk::Scrollbar.new(self)
      @text.xscrollbar(@xbar)
    end

    def setup_status
      # status field
      @status = Status.new(self, font: 'Terminus 9', takefocus: 0)
    end

    def setup_misc
      @text.status = @status
      @text.view = self

      @text.bind('<Movement>'){|e|
        @text.status_projection(@status)
      }
    end

    def setup_grid
      TkGrid.grid @text,   row: 0, column: 0, sticky: :nsew
      TkGrid.grid @ybar,   row: 0, column: 1, sticky: :ns
      TkGrid.grid @xbar,   row: 1, column: 0, sticky: :ew
      TkGrid.grid @status, row: 2, column: 0, columnspan: 2, sticky: :ew

      TkGrid.columnconfigure self, 0, weight: 1
      TkGrid.columnconfigure self, 1, weight: 0
      TkGrid.rowconfigure    self, 0, weight: 1
      TkGrid.rowconfigure    self, 1, weight: 0
    end

    def file_open(file_path)
      @file_path = file_path
      @text.value = File.read(file_path)

      VER.status.value = "Opened #@file_path"

      @text.edit_reset
      @text.focus
      @text.set_mark :insert, '0.0'

      @text.refresh_highlight

      # @text.bind '<Modified>',       proc{|e| refresh; p :modified }
      # @text.bind '<Undo>',           proc{|e| refresh; p :undo }
      # @text.bind '<Redo>',           proc{|e| refresh; p :redo }
      # @text.bind '<Copy>',           proc{|e| p :copy }
      # @text.bind '<Cut>',            proc{|e| refresh; p :cut }
      # @text.bind '<Paste>',          proc{|e| refresh; p :paste }
      # @text.bind '<PasteSelection>', proc{|e| refresh; p :paste_selection }
      # @text.bind '<Movement>',       proc{|e| p :movement }
    end

    def refresh
      display_stat
    end

    def display_stat
      mark = @text.dump_mark(:insert).find{|k,m,p|
        p(k: k, m: m, p: p)
        next unless m.respond_to?(:id)
        m.id == 'insert'
      }
      pos = mark[2]
      @status.value = "#{pos}"
    end
  end
end
