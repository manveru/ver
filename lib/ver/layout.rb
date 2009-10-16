module VER
  class Layout < Ttk::Frame
    attr_reader :strategy, :views

    def initialize(parent, options = {})
      super

      pack(fill: :both, expand: true)

      @views = []
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

      if previous = @views.last
        apply
        previous.focus
      else
        Tk.exit
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

    def apply(options = {})
      strategy.apply(self, options)
    end

    module VerticalTiling
      DEFAULT = { left: 1, right: 3 }

      module_function

      def apply(layout, options = {})
        slaves = layout.views
        left, right = DEFAULT.merge(options).values_at(:left, :right)
        head, tail, hidden = slaves[0...left], slaves[left..right], slaves[right..-1]
        width = tail.size == 0 ? 1.0 : 0.5
        head_step = 1.0 / head.size
        tail_step = 1.0 / tail.size

        hidden.each{|slave| slave.place_forget } if hidden

        head.each_with_index{|slave, idx|
          slave.place(relx: 0.0, rely: (head_step * idx),
                      relheight: head_step, relwidth: width)
        } if head

        tail.each_with_index{|slave, idx|
          slave.place(relx: 0.5, rely: (tail_step * idx),
                      relheight: tail_step, relwidth: width)
        } if tail
      end
    end

    module HorizontalTiling
      DEFAULT = { top: 1, bottom: 3 }

      module_function

      def apply(layout, options = {})
        slaves = layout.views
        top, bottom = DEFAULT.merge(options).values_at(:top, :bottom)
        head, tail, hidden = slaves[0...top], slaves[top..bottom], slaves[bottom..-1]
        height = tail.size == 0 ? 1.0 : 0.5
        head_step = 1.0 / head.size
        tail_step = 1.0 / tail.size

        hidden.each{|slave| slave.place_forget } if hidden

        head.each_with_index{|slave, idx|
          slave.place(relx: (head_step * idx), rely: 0.0,
                      relheight: height, relwidth: head_step)
        } if head

        tail.each_with_index{|slave, idx|
          slave.place(relx: (tail_step * idx), rely: 0.5,
                      relheight: height, relwidth: tail_step)
       } if tail
      end
    end
  end
end
