module VER
  class View::List::Window < View::List
    def update
      list.value = sublist(windows.keys)
    end

    def windows
      path_view = parent.layout.views.map{|view| [view.filename.to_s, view] }
      Hash[path_view]
    end

    def pick_action(filename)
      view = windows[filename]
      callback.call(view) if callback && view
    end
  end

  class View::List::Buffer < View::List
    def update
      list.value = sublist(buffers)
    end

    def buffers
      VER.paths.map(&:to_s).select {|b| ! b.empty? }
    end
  end
end
