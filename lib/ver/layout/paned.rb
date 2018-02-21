module VER
  # A Layout containing frames in a master and slave pane.
  class PanedLayout < Tk::Tile::LabelFrame
    # contains the frames in the order they are displayed
    attr_reader :frames

    # contains the master and slave pane
    attr_reader :layout_pane

    # contains master frames
    attr_reader :master_pane

    # contains slave frames
    attr_reader :slave_pane

    # options specific for the paned layout
    attr_reader :options

    # default options
    OPTIONS = { masters: 1, slaves: 3, center: 0.5 }

    # Create a new PanedLayout for given +parent+ and +options+.
    # The +options+ may contain :masters and :slaves, which will be merged with
    # the default [OPTIONS].
    def initialize(parent, options = {})
      @options = OPTIONS.dup
      @options[:masters] = options.delete(:masters) if options.key?(:masters)
      @options[:slaves]  = options.delete(:slaves)  if options.key?(:slaves)

      super

      pack(fill: :both, expand: true)

      @frames = []

      @layout_pane = Tk::Tile::PanedWindow.new(self, orient: :horizontal)
      @master_pane = Tk::Tile::PanedWindow.new(@layout_pane, orient: :vertical)
      @slave_pane  = Tk::Tile::PanedWindow.new(@layout_pane, orient: :vertical)
      @layout_pane.pack fill: :both, expand: true
      @layout_pane.add(@master_pane, weight: 1)
      @layout_pane.add(@slave_pane, weight: 1)

      @layout_pane.bind('<Map>') { apply }
    end

    # Add the given +buffer+.frame to the {frames}, apply, and focus +buffer+.
    def add_buffer(buffer)
      frames.unshift(buffer.frame)
      apply
      buffer.focus
    end

    # Remove given +buffer+ from {frames} and apply.
    def forget_buffer(buffer)
      frames.delete(buffer.frame)
      apply
    end

    # Create a new {Buffer} inside the {PanedLayout}, +options+ are passed to
    # {Buffer.new}.
    # The new {Buffer} will be at top of the {frames}.
    #
    # @see add_buffer
    def create_buffer(options = {})
      buffer = Buffer.new(self, options)
      yield buffer
      add_buffer(buffer)
      buffer
    end

    # Forget and destroy the given +buffer+.
    #
    # @see forget_buffer
    def close_buffer(buffer)
      forget_buffer(buffer)
      buffer.frame.destroy

      if previous = visible.first
        previous.focus
      else
        Methods::Save.quit(nil)
      end
    end

    def apply
      masters, slaves = masters_slaves

      (master_pane.panes - masters.map(&:tk_pathname)).each do |bff|
        master_pane.forget(bff)
      end

      (slave_pane.panes - slaves.map(&:tk_pathname)).each do |bff|
        slave_pane.forget(bff)
      end

      masters.each { |bff| master_pane.insert(:end, bff, weight: 1) }
      slaves.each { |bff| slave_pane.insert(:end, bff, weight: 1) }

      if slaves.empty?
        begin
          layout_pane.forget(slave_pane)
        rescue StandardError
          nil
        end
      else
        begin
          layout_pane.add(slave_pane, weight: 1)
        rescue StandardError
          nil
        end

        width = layout_pane.winfo_width
        center = (width * options[:center]).to_i

        # layout_pane.sashpos(0, center)
      end
    end

    def masters_slaves
      masters_max, slaves_max = options.values_at(:masters, :slaves)
      frames.compact!
      possible = frames.select(&:shown?)
      [[*possible[0, masters_max]], [*possible[masters_max, slaves_max]]]
    end

    def visible?(frame)
      visible.index(frame)
    end

    def visible
      masters_slaves.flatten
    end

    def show(frame)
      frame.shown = true
      push_up(frame) until visible?(frame)
      frame.focus
    end

    def hide(frame)
      frame.shown = false
      apply
    end

    def focus_next(frame)
      return unless index = visible.index(frame)

      found = visible[index + 1] || visible[0]
      found.focus
    end

    def focus_prev(frame)
      return unless index = visible.index(frame)

      found = visible[index - 1]
      found.focus
    end

    def push_up(frame)
      return unless index = frames.index(frame)
      previous = frames[index - 1]
      frame.raise(previous)
      frames[index - 1] = frame
      frames[index] = previous

      apply
      previous.focus unless visible?(frame)
    end

    def push_down(frame)
      return unless index = frames.index(frame)
      following = frames[index + 1] || frames[0]
      frame.raise(following)
      frames[frames.index(following)] = frame
      frames[index] = following

      apply
      following.focus unless visible?(frame)
    end

    def push_top(frame)
      frames.unshift(frames.delete(frame))
      apply
    end

    def push_bottom(frame)
      frames.push(frames.delete(frame))
      apply
      frames.last.focus unless visible?(frame)
    end

    def cycle_next(frame)
      return unless index = frames.index(frame)
      frames.push(frames.shift)
      apply
      frames[index].focus
    end

    def cycle_prev(frame)
      return unless index = frames.index(frame)
      frames.unshift(frames.pop)
      apply
      frames[index].focus
    end
  end
end
