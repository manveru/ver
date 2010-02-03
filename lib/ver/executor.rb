module VER
  class Executor
    autoload :Entry,   'ver/executor/entry'
    autoload :ExLabel, 'ver/executor/label'

    attr_reader :caller, :tree, :entry, :frame
    attr_accessor :update_on_change

    def initialize(caller)
      @caller = caller
      @tab_count = 0

      setup_widgets
      setup_grid

      @label.setup
      @label.focus
    end

    def setup_widgets
      @frame = Tk::Tile::Frame.new(VER.root)
      @tree_frame = Tk::Tile::Frame.new(@frame)
      @tree  = Treeview.new(@tree_frame)
      @ybar  = Tk::Tile::YScrollbar.new(@tree_frame)
      @tree.yscrollbar(@ybar)
      @label = ExLabel.new(@frame, callback: self)

      @frame.place(anchor: :n, relx: 0.5, relheight: 0.5, relwidth: 0.9)

    end

    def setup_grid
      @label.grid_configure(row: 0 ,column: 0, sticky: :w)
      @entry.grid_configure(row: 0, column: 1, sticky: :we) if @entry

      @frame.grid_rowconfigure(0, weight: 0)
      @frame.grid_rowconfigure(1, weight: 2)
      @frame.grid_columnconfigure(0, weight: 0)
      @frame.grid_columnconfigure(1, weight: 2)

      @tree_frame.grid_configure(row: 1, column: 0, columnspan: 2, sticky: :nswe)
      @tree.grid_configure(row: 0, column: 0, sticky: :nswe)
      @ybar.grid_configure(row: 0, column: 1, sticky: :ns)

      @tree_frame.grid_rowconfigure(0, weight: 1)
      @tree_frame.grid_columnconfigure(0, weight: 2)
      @tree_frame.grid_columnconfigure(1, weight: 0)
    end

    def use_entry(klass)
      @entry = klass.new(@frame, callback: self, mode: :executor_entry)

      setup_grid

      @entry.setup
      @entry
    end

    def destroy
      @label.destroy
      @entry.destroy if @entry
      @ybar.destroy
      @tree.destroy
      @tree_frame.destroy
      @frame.destroy
      @caller.focus
    end
  end
end
