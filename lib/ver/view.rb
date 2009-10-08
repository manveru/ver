module VER
  class View < TkFrame
    attr_reader :text, :status

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
      # setup_scrollbars # enable if you really want some.
      setup_status
      setup_grid
      setup_misc
      setup_events
    end

    def setup_text
      # -tabs "[expr {4 * [font measure $font 0]}] left" -tabstyle wordprocessor
      font_name = 'Terminus 9'
      font_measure = TkFont.measure(font_name, '0')
      tab_width = font_measure * 2 # rhs is number of characters

      @text = VER::Text.new(
        self,
        autoseparators:   true, # insert separators into the undo flow
        borderwidth:      0,
        exportselection:  true, # copy into X11 buffer automatically
        font:             font_name,
        insertbackground: '#f00', # initial value (hardcoded for insert mode)
        insertofftime:    0, # blinking cursor be gone!
        setgrid:          true, # tell the wm that this is a griddy window
        tabs:             tab_width,
        tabstyle:         :wordprocessor,
        undo:             true, # enable undo capabilities
        wrap:             :word
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

    def setup_grid
      TkGrid.grid @text,   row: 0, column: 0, sticky: :nsew              if @text
      TkGrid.grid @ybar,   row: 0, column: 1, sticky: :ns                if @ybar
      TkGrid.grid @xbar,   row: 1, column: 0, sticky: :ew                if @xbar
      TkGrid.grid @status, row: 2, column: 0, sticky: :ew, columnspan: 2 if @status

      TkGrid.columnconfigure self, 0, weight: 1
      TkGrid.columnconfigure self, 1, weight: 0
      TkGrid.rowconfigure    self, 0, weight: 1
      TkGrid.rowconfigure    self, 1, weight: 0
    end

    def setup_misc
      @text.status = @status
      @text.view = self
    end

    def setup_events
      %w[Movement Modified].each do |name|
        @text.bind("<#{name}>"){ __send__("on_#{name.downcase}") }
      end
    end

    def open_path(path)
      @text.open_path(path)
    end

    # handling events

    def on_movement
      @text.see :insert
      @text.refresh_selection
      @text.status_projection(@status)
    end

    def on_modified
      @text.see :insert
      @text.refresh_highlight
      @text.status_projection(@status)
    end

    # @text.bind '<Modified>',       proc{|e| refresh; p :modified }
    # @text.bind '<Undo>',           proc{|e| refresh; p :undo }
    # @text.bind '<Redo>',           proc{|e| refresh; p :redo }
    # @text.bind '<Copy>',           proc{|e| p :copy }
    # @text.bind '<Cut>',            proc{|e| refresh; p :cut }
    # @text.bind '<Paste>',          proc{|e| refresh; p :paste }
    # @text.bind '<PasteSelection>', proc{|e| refresh; p :paste_selection }
    # @text.bind '<Movement>',       proc{|e| p :movement }
  end
end
