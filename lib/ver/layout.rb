module VER
  class Layout < Ttk::Frame
    attr_reader :strategy, :views, :options

    def initialize(parent, options = {})
      super

      pack(fill: :both, expand: true)

      @views = []
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
      @views.unshift view

      apply
      view.focus
    end

    def close_view(view)
      @views.delete view
      view.destroy

      if previous = @views.first
        apply
        previous.focus
      else
        VER.exit
      end
    end

    def focus_next(current)
      return unless index = @views.index(current)

      found = @views[index + 1] || @views[0]
      found.focus
    end

    def focus_prev(current)
      return unless index = @views.index(current)

      found = @views[index - 1]
      found.focus
    end

    # called on #3
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    # |     |  2  | > |     |  3  | > |     |  1  | > |     |  1  |
    # |  1  +-----+ > |  1  +-----+ > |  3  +-----+ > |  3  +-----+
    # |     |  3  | > |     |  2  | > |     |  2  | > |     |  2  |
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    def push_up(current)
      return unless index = @views.index(current)
      previous = @views[index - 1]
      current.raise(previous)
      @views[index - 1], @views[index] = current, previous

      apply
    end

    # called on #3
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    # |     |  2  | > |     |  1  | > |     |  3  | > |     |  2  |
    # |  1  +-----+ > |  3  +-----+ > |  1  +-----+ > |  1  +-----+
    # |     |  3  | > |     |  2  | > |     |  2  | > |     |  3  |
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    def push_down(current)
      return unless index = @views.index(current)
      following = @views[index + 1] || @views[0]
      current.raise(following)
      @views[@views.index(following)], @views[index] = current, following

      apply
    end

    def push_top(current)
      @views.unshift(@views.delete(current))
      apply
    end

    def push_bottom(view)
      @views.push(@views.delete(view))
      apply
    end

    def apply(options = {})
      @options.merge!(options)
      strategy.apply(self, @options)
    end

    module Tiling
      DEFAULT = { master: 1, stacking: 3 }

      def prepare(layout, options)
        slaves = layout.views
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