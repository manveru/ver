module VER
  class BufferListView < ListView
    def update
      list.value = sublist(buffers)
    end

    def buffers
      path_view = parent.layout.views.map{|view| [view.filename, view] }
      Hash[path_view]
    end

    def pick_action(filename)
      view = buffers[filename]
      callback.call(view) if callback && view
    end
  end
end