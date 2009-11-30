module VER
  class Layout < Tk::Tile::Frame
    attr_reader :strategy, :views, :stack, :options

    def initialize(parent, options = {})
      super

      pack(fill: :both, expand: true)

      # These two have to be kept in sync
      # @views contains the views in the order they were opened
      # @stack contains the views in the order they are displayed
      @views, @stack = [], []

      @options = {}
      self.strategy = Layout::VerticalTiling
    end

    def strategy=(mod)
      @strategy = mod
      apply if @views.any?
    end

    def create_view
      view = View.new(self)
      yield view
      @views.push(view)
      @stack.unshift(view)

      apply
      view.focus
    end

    def close_view(view)
      @views.delete(view)
      @stack.delete(view)
      view.destroy

      if previous = @views.first
        apply
        previous.focus
      else
        VER.exit
      end
    end

    def focus_next(current)
      visible = head_tail_hidden.first(2).flatten
      return unless index = visible.index(current)

      found = visible[index + 1] || visible[0]
      found.focus
    end

    def focus_prev(current)
      visible = head_tail_hidden.first(2).flatten

      return unless index = visible.index(current)

      found = visible[index - 1]
      found.focus
    end

    # called on #3
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    # |     |  2  | > |     |  3  | > |     |  1  | > |     |  1  |
    # |  1  +-----+ > |  1  +-----+ > |  3  +-----+ > |  3  +-----+
    # |     |  3  | > |     |  2  | > |     |  2  | > |     |  2  |
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    def push_up(current)
      return unless index = @stack.index(current)
      previous = @stack[index - 1]
      current.raise(previous)
      @stack[index - 1], @stack[index] = current, previous

      apply
    end

    # called on #3
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    # |     |  2  | > |     |  1  | > |     |  3  | > |     |  2  |
    # |  1  +-----+ > |  3  +-----+ > |  1  +-----+ > |  1  +-----+
    # |     |  3  | > |     |  2  | > |     |  2  | > |     |  3  |
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    def push_down(current)
      return unless index = @stack.index(current)
      following = @stack[index + 1] || @stack[0]
      current.raise(following)
      @stack[@stack.index(following)], @stack[index] = current, following

      apply
    end

    def push_top(current)
      @stack.unshift(@stack.delete(current))
      apply
    end

    def push_bottom(view)
      @stack.push(@stack.delete(view))
      apply
    end

    def apply(options = {})
      @options.merge!(options)
      strategy.apply(self, @options)
    end

    def head_tail_hidden(options = {})
      @options.merge!(options)
      strategy.prepare(self, @options)
    end

    module Tiling
      DEFAULT = { master: 1, stacking: 3 }

      def prepare(layout, options)
        slaves = layout.stack
        master, stacking = DEFAULT.merge(options).values_at(:master, :stacking)
        options.merge! master: master, stacking: stacking
        head, tail, hidden = slaves[0...master], slaves[master..stacking], slaves[stacking..-1]
      end

      def apply(layout, options = {})
        masters, stacked, hidden = prepare(layout, options)

        limit = stacked.size == 0 ? 1.0 : 0.5

        apply_hidden(hidden) if hidden
        apply_masters(masters, limit) if masters
        apply_stacked(stacked, limit) if stacked
      end

      def apply_hidden(windows)
        windows.each(&:place_forget)
      end
    end

    module VerticalTiling
      extend Tiling

      module_function

      def apply_masters(windows, width, step = 1.0 / windows.size)
        windows.each_with_index{|window, idx|
          window.place(relx: 0.0, rely: (step * idx),
                      relheight: step, relwidth: width) }
      end

      def apply_stacked(windows, width, step = 1.0 / windows.size)
        windows.each_with_index{|window, idx|
          window.place(relx: 0.5, rely: (step * idx),
                      relheight: step, relwidth: width) }
      end
    end

    module HorizontalTiling
      extend Tiling

      module_function

      def apply_masters(windows, height, step = 1.0 / windows.size)
        windows.each_with_index do |window, idx|
          window.place(relx: (step * idx), rely: 0.0,
                       relheight: height, relwidth: step)
        end
      end

      def apply_stacked(windows, height, step = 1.0 / windows.size)
        windows.each_with_index do |window, idx|
          window.place(relx: (step * idx), rely: 0.5,
                       relheight: height, relwidth: step)
        end
      end
    end
  end
end
