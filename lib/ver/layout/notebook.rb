module VER
  class NotebookLayout < Tk::Tile::LabelFrame
    attr_reader :strategy, :stack, :options, :note

    class Notebook < Tk::Tile::Notebook
    end

    def initialize(parent, options = {})
      super
      pack(fill: :both, expand: true)
      @stack = []
      @options = {}
      @note = Notebook.new(self)
      @note.pack fill: :both, expand: true
    end

    def create_buffer(options = {})
      buffer = Buffer.new(self, options)
      yield buffer
      note.add(buffer, text: buffer.text.short_filename)
      note.select(buffer)
      buffer.focus
    end

    def close_buffer(buffer)
      note.forget(buffer)
      buffer.destroy
    end

    def focus_next(current)
      index = note.index(current)
      total = note.index('end') - 1

      note.select(index == total ? 0 : index + 1)
      Tk::Focus.focus(note.select)
    end

    def focus_prev(current)
      index = note.index(current)

      note.select(index == 0 ? (note.index('end') - 1) : index - 1)
      Tk::Focus.focus(note.select)
    end

    def push_up(current)
      index = note.index(current)

      if index == 0
        note.insert('end', index)
      else
        note.insert(index - 1, index)
      end
    end

    def push_down(current)
      index = note.index(current)
      total = note.index('end') - 1

      if index == total
        note.insert(0, index)
      else
        note.insert(index + 1, index)
      end
    end

    def push_top(current)
      note.insert(0, current)
    end

    def push_bottom(current)
      note.insert('end', current)
    end
  end
end
