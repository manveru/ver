module VER
  class Buffer::List::Window < Buffer::List
    def update
      list.value = sublist(windows.keys)
    end

    def windows
      Hash[VER.buffers.map{|buffer| [buffer.filename.to_s, buffer] }]
    end

    def pick_action(filename)
      buffer = windows[filename]
      callback.call(buffer) if callback && buffer
    end
  end

  class Buffer::List::Buffer < Buffer::List
    def update
      list.value = sublist(buffers)
    end

    def buffers
      VER.paths.map(&:to_s).select {|b| ! b.empty? }
    end
  end
end
