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

    def create_view(options = {})
      view = View.new(self, options)
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
      strategy.prepare(self, @options).first(3)
    end

    module Tiling
      DEFAULT = { master: 1, stacking: 3, center: 0.2 }

      def prepare(layout, given_options)
        options = DEFAULT.merge(given_options)
        slaves = layout.stack
        master, stacking = options.values_at(:master, :stacking)
        given_options.merge!(options)
        head, tail, hidden = slaves[0...master], slaves[master..stacking], slaves[stacking..-1]
        return head, tail, hidden, options
      end

      def apply(layout, given_options = {})
        masters, stacked, hidden, options = prepare(layout, given_options)

        center = stacked.size == 0 ? 1.0 : options[:center]

        apply_hidden(hidden) if hidden
        apply_masters(masters, center) if masters
        apply_stacked(stacked, center) if stacked
      end

      def apply_hidden(windows)
        windows.each(&:place_forget)
      end
    end

    module VerticalTiling
      extend Tiling

      module_function

      def apply_masters(windows, center, step = 1.0 / windows.size)
        windows.each_with_index{|window, idx|
          window.place(relx: 0.0, rely: (step * idx),
                      relheight: step, relwidth: center) }
      end

      def apply_stacked(windows, center, step = 1.0 / windows.size)
        relwidth = 1.0 - center

        windows.each_with_index{|window, idx|
          window.place(relx: center, rely: (step * idx),
                      relheight: step, relwidth: relwidth) }
      end
    end

    module HorizontalTiling
      extend Tiling

      module_function

      def apply_masters(windows, center, step = 1.0 / windows.size)
        windows.each_with_index do |window, idx|
          window.place(relx: (step * idx), rely: 0.0,
                       relheight: center, relwidth: step)
        end
      end

      def apply_stacked(windows, center, step = 1.0 / windows.size)
        relheight = 1.0 - center
        windows.each_with_index do |window, idx|
          window.place(relx: (step * idx), rely: center,
                       relheight: relheight, relwidth: step)
        end
      end
    end
  end
end
