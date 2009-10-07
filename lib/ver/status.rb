module VER
  # The status bar
  class Status < Tk::Tile::Entry
    attr_accessor :mode, :keymap, :view, :prompt

    def initialize(view, options = {})
      super
      self.view = view

      keymap_name = VER.options.fetch(:keymap)
      self.keymap = Keymap.get(name: keymap_name, receiver: self)

      self.mode = :status_query
    end

    def method_missing(meth, *args)
      p meth => args
    end

    def mode=(name)
      @keymap.current_mode = name.to_sym
      @mode = name
    end

    def text
      view.text
    end

    def ask(prompt, &callback)
      self.value = @prompt = prompt
      focus
      @callback = callback
    end

    def message(string)
      self.value = string
    end

    def status_issue
      answer = value.sub(@prompt, '')
      result = @callback.call(answer)
      self.value = result.inspect
    end

    def insert_string(string)
      insert :end, string
    end

    def delete_char_left
      cursor = self.cursor
      return if prompt.size == cursor
      delete(cursor - 1)
    end

    def delete_char_right
      delete(cursor)
    end

    def go_char_left
      cursor = self.cursor
      return if prompt.size == cursor
      self.cursor = cursor - 1
    end

    def go_char_right
      self.cursor = cursor + 1
    end

    def go_word_left
      if index = value.rindex(/.\b\s/, cursor - 1)
        self.cursor = index
      else
        self.cursor = prompt.size
      end
    end

    def go_word_right
      if match = value.match(/\s\b/, cursor)
        offset_from, offset_to = match.offset(0)
        self.cursor = offset_to
      else
        self.cursor = :end
      end
    end
  end
end