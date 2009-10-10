module VER
  class BufferListView < ListView
    def update
      list.value = buffers_for(entry.value)
    end

    def buffers_for(name)
      if name == name.downcase
        buffers.select{|buffer| buffer.downcase.include?(name) }
      else
        buffers.select{|buffer| buffer.include?(name) }
      end
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