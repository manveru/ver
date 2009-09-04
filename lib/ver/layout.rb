module VER
  class Layout < Ttk::Frame
    def initialize(parent, options = {})
      super
      pack(fill: :both, expand: true)
    end

    def create_view(&block)
      View.new(self).tap(&block)
    end

    def focus(number)
      slaves = winfo_children
      slaves[number].text.focus
    end

    VERTICAL_TILING = { left: 1, right: -1 }

    def vertical_tiling(options = {})
      slaves = winfo_children
      left, right = VERTICAL_TILING.merge(options).values_at(:left, :right)
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

    HORIZONTAL_TILING = { top: 1, bottom: -1 }

    def horizontal_tiling(options = {})
      slaves = winfo_children
      top, bottom = HORIZONTAL_TILING.merge(options).values_at(:top, :bottom)
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
