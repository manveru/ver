module VER
  class View::List::Buffer < View::List
    def update
      list.value = sublist(buffers.keys)
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