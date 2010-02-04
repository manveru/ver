module VER
  class Executor
    autoload :Entry,   'ver/executor/entry'
    autoload :ExLabel, 'ver/executor/label'

    attr_reader :caller, :tree, :label, :entry, :ybar
    attr_accessor :update_on_change

    def initialize(caller)
      @caller = caller
      @tab_count = 0

      setup_widgets
      setup_layout

      @label.setup
      @label.focus
    end

    def setup_widgets
      layout = caller.layout

      @frame = Tk::Tile::Frame.new(layout)
      @top = Tk::Tile::Frame.new(@frame)
      @bottom = Tk::Tile::Frame.new(@frame)

      @tree  = Treeview.new(@top)
      @ybar  = Tk::Tile::YScrollbar.new(@top)
      @tree.yscrollbar(@ybar)

      @label = ExLabel.new(@bottom, callback: self)
    end

    def setup_layout
      caller.layout.add_buffer(@frame)

      @top.grid_configure(row: 0, column: 0, sticky: :nswe)
      @tree.grid_configure(row: 0, column: 0, sticky: :nswe)
      @ybar.grid_configure(row: 0, column: 1, sticky: :ns)
      @top.grid_rowconfigure(@tree, weight: 1)
      @top.grid_columnconfigure(@tree, weight: 1)

      @frame.grid_rowconfigure(@top, weight: 1)
      @frame.grid_columnconfigure(@top, weight: 1)

      @bottom.grid_configure(row: 1, column: 0, sticky: :we)
      @label.grid_configure(row: 0, column: 0, sticky: :w)
    end

    def use_entry(klass)
      @entry = klass.new(@bottom, callback: self, mode: :executor_entry)
      @entry.grid_configure(row: 0, column: 1, sticky: :we)
      @bottom.grid_columnconfigure(@entry, weight: 1)

      @entry.setup
      @entry
    end

    def destroy
      [@entry, @label, @tree, @ybar, @top, @bottom].compact.each(&:destroy)

      caller.layout.close_buffer(@frame)
      @frame.destroy
      @caller.focus
    end
  end
end
