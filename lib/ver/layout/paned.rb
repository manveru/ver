module VER
  class PanedLayout < Tk::Tile::LabelFrame
    # contains the views in the order they were opened
    attr_reader :views

    # contains the views in the order they are displayed
    attr_reader :stack

    # contains the master and slave pane
    attr_reader :layout_pane

    # contains master views
    attr_reader :master_pane

    # contains slave views
    attr_reader :slave_pane

    # options specific for the paned layout
    attr_reader :options

    # default options
    OPTIONS = {masters: 1, slaves: 3, center: 0.5}

    # Create a new PanedLayout for given +parent+ and +options+.
    # The +options+ may contain :masters and :slaves, which will be merged with
    # the default [OPTIONS].
    def initialize(parent, options = {})
      @options = OPTIONS.dup
      @options[:masters] = options.delete(:masters) if options.key?(:masters)
      @options[:slaves]  = options.delete(:slaves)  if options.key?(:slaves)

      super

      pack(fill: :both, expand: true)

      @views, @stack = [], []

      @layout_pane = Tk::Tile::PanedWindow.new(self, orient: :horizontal)
      @master_pane = Tk::Tile::PanedWindow.new(@layout_pane, orient: :vertical)
      @slave_pane  = Tk::Tile::PanedWindow.new(@layout_pane, orient: :vertical)
      @layout_pane.pack fill: :both, expand: true
      @layout_pane.add(@master_pane, weight: 1)
      @layout_pane.add(@slave_pane, weight: 1)

      @layout_pane.bind('<Map>'){ apply }
    end

    # Create a new [View] inside the [PanedLayout], +options+ are passed to
    # [View.new].
    # The new [View] will be at top of the [stack] and bottom of [views].
    def create_view(options = {})
      view = View.new(self, options)
      yield view
      views.push(view)
      stack.unshift(view)
      apply
      view.focus
    end

    def forget_view(view)
      views.delete(view)
      stack.delete(view)
      apply
    end

    def close_view(view)
      forget_view(view)
      view.destroy

      if previous = stack.first
        previous.focus
      else
        VER.exit
      end
    end

    def apply
      masters, slaves = masters_slaves

      (master_pane.panes - masters.map{|view| view.tk_pathname }).each do |view|
        master_pane.forget(view)
      end

      (slave_pane.panes - slaves.map{|view| view.tk_pathname }).each do |view|
        slave_pane.forget(view)
      end

      masters.each{|view| master_pane.insert(:end, view, weight: 1) }
      slaves.each{|view| slave_pane.insert(:end, view, weight: 1) }

      if slaves.empty?
        layout_pane.forget(slave_pane) rescue nil
      else
        layout_pane.add(slave_pane) rescue nil
        width = layout_pane.winfo_width
        center = width * options[:center]
        layout_pane.sashpos(0, center.to_i)
      end
    end

    def masters_slaves
      masters_max, slaves_max = options.values_at(:masters, :slaves)
      return [*stack[0, masters_max]], [*stack[masters_max, slaves_max]]
    end

    def visible?(view)
      visible.index(view)
    end

    def visible
      masters_slaves.flatten
    end

    def focus_next(current)
      return unless index = visible.index(current)

      found = visible[index + 1] || visible[0]
      found.focus
    end

    def focus_prev(current)
      return unless index = visible.index(current)

      found = visible[index - 1]
      found.focus
    end

    def push_up(current)
      return unless index = stack.index(current)
      previous = stack[index - 1]
      current.raise(previous)
      stack[index - 1], stack[index] = current, previous

      apply
      previous.focus unless visible?(current)
    end

    def push_down(current)
      return unless index = stack.index(current)
      following = stack[index + 1] || stack[0]
      current.raise(following)
      stack[stack.index(following)], stack[index] = current, following

      apply
      following.focus unless visible?(current)
    end

    def push_top(current)
      stack.unshift(stack.delete(current))
      apply
    end

    def push_bottom(view)
      stack.push(stack.delete(view))
      apply
      stack.last.focus unless visible?(view)
    end

    def cycle_next(current)
      return unless index = stack.index(current)
      stack.push(stack.shift)
      apply
      stack[index].focus
    end

    def cycle_prev(current)
      return unless index = stack.index(current)
      stack.unshift(stack.pop)
      apply
      stack[index].focus
    end
  end
end
