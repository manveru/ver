module VER
  class View < TkFrame
    autoload :Entry, 'ver/view/entry'
    autoload :List,  'ver/view/list'

    attr_reader :layout, :text, :status

    def initialize(layout, options = {})
      super
      @layout = layout
      @text = @status = @ybar = @xbar = nil
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
      font = VER.options[:font]
      tab_width = font.measure('0') * 2

      @text = VER::Text.new(
        self,
        autoseparators:   true, # insert separators into the undo flow
        borderwidth:      0,
        exportselection:  true, # copy into X11 buffer automatically
        insertbackground: '#0f0', # initial value (hardcoded for control mode)
        font:             font,
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
      @status = Status.new(self, font: VER.options[:font], takefocus: 0)
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
      @status.mode = :status_query
    end

    def setup_events
      %w[Movement Modified Focus].each do |name|
        @text.bind("<#{name}>"){|event| __send__("on_#{name.downcase}", event) }
      end
    end

    def open_path(path)
      @text.open_path(path)
    end

    def open_empty
      @text.open_empty
    end

    # handling events

    def on_movement(event)
      @text.see :insert
      @text.refresh_selection
      @text.status_projection(@status)
    end

    def on_modified(event)
      @text.see :insert
      @text.refresh_highlight
      @text.status_projection(@status)
    end

    def on_focus(event)
      @text.set_window_title
    end

    # @text.bind '<Modified>',       proc{|e| refresh; p :modified }
    # @text.bind '<Undo>',           proc{|e| refresh; p :undo }
    # @text.bind '<Redo>',           proc{|e| refresh; p :redo }
    # @text.bind '<Copy>',           proc{|e| p :copy }
    # @text.bind '<Cut>',            proc{|e| refresh; p :cut }
    # @text.bind '<Paste>',          proc{|e| refresh; p :paste }
    # @text.bind '<PasteSelection>', proc{|e| refresh; p :paste_selection }
    # @text.bind '<Movement>',       proc{|e| p :movement }

    def focus
      text.focus
    end

    def create
      layout.create_view do |view|
        view.open_empty
      end
    end

    def close
      layout.close_view(self)
    end

    def focus_next
      layout.focus_next(self)
    end

    def focus_prev
      layout.focus_prev(self)
    end

    def destroy
      [@text, @ybar, @xbar, @status].each do |widget|
        widget.destroy if widget
      end

      super
    end

    def filename
      text.filename
    end
  end
end