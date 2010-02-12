module VER
  class Buffer < Tk::Tile::Frame
    autoload :Console, 'ver/buffer/console'

    def self.[](name, line = nil, column = nil)
      find_or_create(name, line, column)
    end

    def self.create(path = nil, line = nil, column = nil)
      VER.layout.create_buffer do |buffer|
        case path
        when nil
          buffer.open_empty
        when Symbol
          buffer.open_symbolic(path, line, column)
        when Pathname
          buffer.open_path(path, line, column)
        else
          raise ArgumentError, "invalid path: %p" % [path]
        end

        VER.buffers[buffer.name] = buffer
        yield(buffer) if block_given?
        buffer
      end
    end

    def self.find_or_create(name, line = nil, column = nil, &block)
      case name
      when Pathname, Symbol
        if buffer = VER.buffers[name]
          buffer.after_found(line, column)
        else
          create(name, line, column, &block)
        end
      when String
        path = Pathname(name.to_str).expand_path
        find_or_create(path, line, column, &block)
      else
        raise ArgumentError, "Invalid path: %p" % [path]
      end
    end

    attr_reader :layout, :text, :status, :shown

    def initialize(layout, options = {})
      peer = options.delete(:peer)
      options[:style] ||= VER.obtain_style_name('Buffer', 'TFrame')
      super

      @layout = layout
      @text = @status = @ybar = @xbar = nil
      @shown = true
      setup(peer)

      configure takefocus: false, padding: 2, border: 0, relief: :solid
    end

    # this should be customized when neccesary
    def name
      text.filename || text.name
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
    def setup(peer)
      setup_widgets(peer)
      setup_grid
      setup_misc
    end

    def setup_widgets(peer)
      if peer
        setup_peer(peer)
      else
        setup_text
      end

      setup_vertical_scrollbar if VER.options.vertical_scrollbar
      setup_horizontal_scrollbar if VER.options.horizontal_scrollbar
      setup_status
    end

    def setup_peer(peer)
      @text = peer.peer_create(self)
    end

    def setup_text
      font, tabstop = VER.options.font, VER.options.tabstop
      tabs = font.measure('0') * tabstop

      @text = VER::Text.new(
        self,
        borderwidth:      0,
        exportselection:  true, # copy into X11 buffer automatically
        foreground:       '#fff', # when first showing, it's not highlighted...
        background:       '#000',
        font:             font,
        insertofftime:    VER.options.insertofftime,
        insertontime:     VER.options.insertontime,
        setgrid:          false,
        takefocus:        true,
        tabs:             tabs,
        tabstyle:         :wordprocessor,
        wrap:             :word
      )
    end

    def setup_vertical_scrollbar
      @ybar = Tk::Tile::YScrollbar.new(self)
      @text.yscrollbar(@ybar)
    end

    def setup_horizontal_scrollbar
      @xbar = Tk::Tile::XScrollbar.new(self)
      @text.xscrollbar(@xbar)
    end

    def setup_status
      @status = Status.new(self)
    end

    def setup_grid
      @text.grid_configure   row: 0, column: 0, sticky: :nsew              if @text
      @ybar.grid_configure   row: 0, column: 1, sticky: :ns                if @ybar
      @xbar.grid_configure   row: 1, column: 0, sticky: :ew                if @xbar
      @status.grid_configure row: 2, column: 0, sticky: :ew, columnspan: 2 if @status

      grid_columnconfigure 0, weight: 1
      grid_columnconfigure 1, weight: 0
      grid_rowconfigure    0, weight: 1
      grid_rowconfigure    1, weight: 0
      grid_rowconfigure    2, weight: 0
    end

    def setup_misc
      @text.status = @status
      @text.buffer = self
    end

    def open_path(path, line = 1, column = 0)
      Methods::Open.open_path(text, path, line, column)
    end

    def open_symbolic(name, line = 1, column = 0)
      Methods::Open.open_symbolic(text, name, line, column)
    end

    def open_empty
      Methods::Open.open_empty(text)
    end

    def focus
      text.focus
    end

    def after_found(line, column, &block)
      layout.push_top(self)
      focus
      go_line_column(line, column)
      yield(self) if block_given?
      self
    end

    def go_line_column(line, column)
      insert = text.index(:insert)
      text.mark_set(:insert, "#{line || insert.y}.#{column || insert.x}")
    end

    def create_peer
      layout.create_buffer(peer: text) do |buffer|
        yield(buffer) if block_given?
      end
    end

    def close
      Methods::Save.may_close text do
        layout.close_buffer(self)
      end
    end

    def shown?
      @shown
    end

    def hidden?
      not @shown
    end

    def show
      @shown = true
      layout.apply
    end

    def hide
      @shown = false
      layout.apply
    end

    def destroy
      style_name = style
      buffer_name = name
      [@text, @ybar, @xbar, @status].compact.each(&:destroy)

      super
    ensure
      VER.buffers.delete(buffer_name)
      VER.return_style_name(style_name)
    end

    def style
      style = cget(:style)
      style.first if style
    end

    def filename
      text.filename
    end
  end
end
