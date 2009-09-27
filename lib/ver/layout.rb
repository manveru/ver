module VER
  class Layout < Ttk::Frame
    def initialize(parent, options = {})
      super
      pack(fill: :both, expand: true)
      @views = []
      @focus = nil
    end

    def create_view
      View.new(self, relief: :ridge).tap do |view|
        yield(view)
        @views << view
      end

      apply
    end

    def remove_view
      @views.delete @focus
    end

    def focus_next
      index = @views.index(@focus)
      focus(index ? index + 1 : 0)
    end

    def focus_prev
      index = @views.index(@focus)
      focus(index ? index - 1 : -1)
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
