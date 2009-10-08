module VER
  class Layout < Ttk::Frame
    def initialize(parent, options = {})
      super
      pack(fill: :both, expand: true)
      @views = []
      @focus = nil
    end

    def create_view
      view = View.new(self)
      yield view
      @views << view

      apply
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

    def focus(number)
      slaves = winfo_children
      @focus = slaves[number]
      @focus.text.focus
    end

    module VerticalTiling
      DEFAULT = { left: 1, right: -1 }

      def apply(options = {})
        slaves = winfo_children
        left, right = DEFAULT.merge(options).values_at(:left, :right)
        head, tail = slaves[0...left], slaves[left..right]
        width = tail.size == 0 ? 1.0 : 0.5
        head_step = 1.0 / head.size
        tail_step = 1.0 / tail.size

        head.each_with_index do |slave, idx|
          slave.place(relx: 0.0, rely: (head_step * idx),
                      relheight: head_step, relwidth: width)
        end

        tail.each_with_index do |slave, idx|
          slave.place(relx: 0.5, rely: (tail_step * idx),
                      relheight: tail_step, relwidth: width)
        end
      end
    end

    module HorizontalTiling
      DEFAULT = { top: 1, bottom: -1 }

      def apply(options = {})
        slaves = winfo_children
        top, bottom = DEFAULT.merge(options).values_at(:top, :bottom)
        head, tail = slaves[0...top], slaves[top..bottom]
        height = tail.size == 0 ? 1.0 : 0.5
        head_step = 1.0 / head.size
        tail_step = 1.0 / tail.size

        head.each_with_index do |slave, idx|
          slave.place(relx: (head_step * idx), rely: 0.0,
                      relheight: height, relwidth: head_step)
        end

        tail.each_with_index do |slave, idx|
          slave.place(relx: (tail_step * idx), rely: 0.5,
                      relheight: height, relwidth: tail_step)
        end
      end
    end
  end
end
