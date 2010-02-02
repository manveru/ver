module VER
  class PanedLayout < Tk::Tile::LabelFrame
    # contains the buffers in the order they are displayed
    attr_reader :stack

    # contains the master and slave pane
    attr_reader :layout_pane

    # contains master buffers
    attr_reader :master_pane

    # contains slave buffers
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

      @stack = []

      @layout_pane = Tk::Tile::PanedWindow.new(self, orient: :horizontal)
      @master_pane = Tk::Tile::PanedWindow.new(@layout_pane, orient: :vertical)
      @slave_pane  = Tk::Tile::PanedWindow.new(@layout_pane, orient: :vertical)
      @layout_pane.pack fill: :both, expand: true
      @layout_pane.add(@master_pane, weight: 1)
      @layout_pane.add(@slave_pane, weight: 1)

      @layout_pane.bind('<Map>'){ apply }
    end

    # Add the given +buffer+ to the {stack}, apply, and focus +buffer+.
    def add_buffer(buffer)
      stack.unshift(buffer)
      apply
      buffer.focus
    end

    # Remove given +buffer+ from {stack} and apply.
    def forget_buffer(buffer)
      stack.delete(buffer)
      apply
    end

    # Create a new {Buffer} inside the {PanedLayout}, +options+ are passed to
    # {Buffer.new}.
    # The new {Buffer} will be at top of the {stack}.
    #
    # @see add_buffer
    def create_buffer(options = {})
      buffer = Buffer.new(self, options)
      yield buffer
      add_buffer(buffer)
    end

    # Forget and destroy the given +buffer+.
    #
    # @see forget_buffer
    def close_buffer(buffer)
      forget_buffer(buffer)
      buffer.destroy

      if previous = stack.first
        previous.focus
      else
        VER.exit
      end
    end

    def apply
      masters, slaves = masters_slaves

      (master_pane.panes - masters.map{|bff| bff.tk_pathname }).each do |bff|
        master_pane.forget(bff)
      end

      (slave_pane.panes - slaves.map{|bff| bff.tk_pathname }).each do |bff|
        slave_pane.forget(bff)
      end

      masters.each{|bff| master_pane.insert(:end, bff, weight: 1) }
      slaves.each{|bff| slave_pane.insert(:end, bff, weight: 1) }

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

    def visible?(buffer)
      visible.index(buffer)
    end

    def visible
      masters_slaves.flatten
    end

    def focus_next(buffer)
      return unless index = visible.index(buffer)

      found = visible[index + 1] || visible[0]
      found.focus
    end

    def focus_prev(buffer)
      return unless index = visible.index(buffer)

      found = visible[index - 1]
      found.focus
    end

    def push_up(buffer)
      return unless index = stack.index(buffer)
      previous = stack[index - 1]
      buffer.raise(previous)
      stack[index - 1], stack[index] = buffer, previous

      apply
      previous.focus unless visible?(buffer)
    end

    def push_down(buffer)
      return unless index = stack.index(buffer)
      following = stack[index + 1] || stack[0]
      buffer.raise(following)
      stack[stack.index(following)], stack[index] = buffer, following

      apply
      following.focus unless visible?(buffer)
    end

    def push_top(buffer)
      stack.unshift(stack.delete(buffer))
      apply
    end

    def push_bottom(buffer)
      stack.push(stack.delete(buffer))
      apply
      stack.last.focus unless visible?(buffer)
    end

    def cycle_next(buffer)
      return unless index = stack.index(buffer)
      stack.push(stack.shift)
      apply
      stack[index].focus
    end

    def cycle_prev(buffer)
      return unless index = stack.index(buffer)
      stack.unshift(stack.pop)
      apply
      stack[index].focus
    end
  end
end
