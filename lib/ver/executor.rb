module VER
  class Executor
    require_relative 'executor/entry'
    require_relative 'executor/label'

    class Frame < Tk::Tile::Frame
      attr_accessor :shown
      alias shown? shown

      def initialize(parent, options = {})
        super
        @shown = true
      end
    end

    attr_reader :caller, :tree, :label, :entry, :ybar, :frame
    attr_accessor :update_on_change

    def initialize(caller, options = {})
      @caller = caller
      @tab_count = 0

      setup_widgets
      setup_layout

      @label.setup

      if action = options.delete(:action)
        @label.action(action.to_s)
      else
        @label.focus
      end
    end

    def setup_widgets
      layout = caller.layout

      @frame  = Frame.new(layout)
      @top    = Frame.new(@frame)
      @bottom = Frame.new(@frame)

      @tree  = Treeview.new(@top)
      @ybar  = Tk::Tile::YScrollbar.new(@top)
      @tree.yscrollbar(@ybar)

      @label = ExLabel.new(@bottom, callback: self)
    end

    def setup_layout
      @frame.place anchor: :n, relx: 0.5, relwidth: 0.95, relheight: 0.95
      # VER.defer{ caller.layout.add_buffer(@frame) }

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

    def destroy(caller_focus = true)
      [@entry, @label, @tree, @ybar, @top, @bottom].compact.each(&:destroy)

      # caller.layout.close_buffer(self)
      @frame.destroy
      @caller.focus if caller_focus
    end
  end
end
