module VER
  class BufferListView < ListView
    def update
      list.value = p(buffers_for(entry.value))
    end

    def buffers_for(name)
      if name == name.downcase
        buffers.keys.select{|filename| filename.downcase.include?(name) }
      else
        buffers.keys.select{|filename| filename.include?(name) }
      end
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