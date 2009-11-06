module VER
  class View < Tk::Frame
    autoload :Entry,   'ver/view/entry'
    autoload :List,    'ver/view/list'
    autoload :Console, 'ver/view/console'

    attr_reader :layout, :text, :status

    def initialize(layout, options = {})
      super
      @layout = layout
      @text = @status = @ybar = @xbar = nil
      configure takefocus: false
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
      font, tabs = VER.options.values_at(:font, :tabs)

      @text = VER::Text.new(
        self,
        autoseparators:   true, # insert separators into the undo flow
        borderwidth:      0,
        exportselection:  true, # copy into X11 buffer automatically
        font:             font,
        insertofftime:    0, # blinking cursor be gone!
        setgrid:          true, # tell the wm that this is a griddy window
        takefocus:        true,
        tabs:             tabs,
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
      @status = Status.new(self, font: VER.options[:font], takefocus: false)
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
      %w[Modified Focus].each do |name|
        @text.bind("<#{name}>"){|event| __send__("on_#{name.downcase}", event) }
      end
    end

    def open_path(path, line = 1)
      @text.open_path(path, line)
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
      # @text.refresh_highlight
      @text.status_projection(@status)
    end

    def on_focus(event)
      @text.set_window_title
      @text.see(:insert)
    end

    def focus
      text.focus
    end

    def create(path = nil)
      layout.create_view do |view|
        path ? view.open_path(path) : view.open_empty
      end
    end

    def find_or_create(path)
      needle = Pathname(path.to_s).expand_path

      if found = layout.views.find{|view| view.filename == needle }
        found.push_top
        found.focus
      else
        create(needle)
      end
    end

    def close
      text.may_close do
        layout.close_view(self)
      end
    end

    def focus_next
      layout.focus_next(self)
    end

    def focus_prev
      layout.focus_prev(self)
    end

    def push_up
      layout.push_up(self)
    end

    def push_down
      layout.push_down(self)
    end

    def push_top
      layout.push_top(self)
    end

    def push_bottom
      layout.push_bottom(self)
    end

    def destroy
      [@text, @ybar, @xbar, @status].compact.each(&:destroy)

      super
    end

    def filename
      text.filename
    end
  end
end