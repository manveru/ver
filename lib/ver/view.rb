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

      # vertical scrollbar
      @ybar = Ttk::Scrollbar.new(self)
      @text.yscrollbar(@ybar)

      # horizontal scrollbar
      @xbar = Ttk::Scrollbar.new(self)
      @text.xscrollbar(@xbar)

      # status field
      @status = Ttk::Entry.new(self, font: 'Terminus 9', takefocus: 0)
      @text.status = @status
      @text.view = self

      TkGrid.grid @text,   row: 0, column: 0, sticky: :nsew
      TkGrid.grid @ybar,   row: 0, column: 1, sticky: :ns
      TkGrid.grid @xbar,   row: 1, column: 0, sticky: :ew
      TkGrid.grid @status, row: 2, column: 0, columnspan: 2, sticky: :ew

      TkGrid.columnconfigure self, 0,    weight: 1
      TkGrid.columnconfigure self, 1, weight: 0
      TkGrid.rowconfigure    self, 0,    weight: 1
      TkGrid.rowconfigure    self, 1, weight: 0
    end

    def file_open(file_path)
      @file_path = file_path
      @text.value = File.read(file_path)

      @status.value = "Opened #@file_path"

      @text.edit_reset
      @text.focus
      @text.set_mark :insert, '0.0'

      highlight_syntax

      # @text.bind 'Control-l', proc{ refresh }

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
      load 'lib/ver/theme/murphy.rb'
      highlight_syntax
      display_stat
    end

    def highlight_syntax
      Thread.new{
        syntax = Syntax.from_filename(@file_path)
        syntax.highlight(@text, @text.value)
      }
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
