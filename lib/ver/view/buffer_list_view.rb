module VER
  class BufferListView < ListView
    def initialize(*args, &block)
      super
    end

    def update
      value = entry.value

      if value == value.downcase
        selected = buffers.select{|buffer| buffer.downcase.include?(value) }
      else
        selected = buffers.select{|buffer| buffer.include?(value) }
      end

      list.delete 0, :end
      list.insert :end, *selected
    end

    def buffers
      path_view = parent.layout.views.map{|view| [view.filename, view] }
      Hash[path_view]
    end

    def pick_action
      view = buffers[list.get(0)]
      callback.call(view) if callback && view
    end
  end
end