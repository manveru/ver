module VER
  # The status bar
  class Status < Tk::Tile::Entry
    attr_accessor :keymap, :view
    attr_reader :mode

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

    def quit
      Tk.exit
    end

    def text
      view.text
    end

    def ask(question, &callback)
      @question, @backup_value, @callback = question, value, callback

      message @question
      focus
    end

    def ask_submit
      answer = value.sub(@question, '')
      result = @callback.call(answer)
      message result.inspect
    end

    def ask_abort
      message @backup_value
      text.focus
    end

    def message(string)
      self.value = string
    end

    def insert_string(string)
      insert cursor, string
    end

    def delete_char_left
      cursor = self.cursor
      return if @question.size == cursor
      delete(cursor - 1)
    end

    def delete_char_right
      delete(cursor)
    end

    def go_char_left
      cursor = self.cursor
      return if @question.size == cursor
      self.cursor = cursor - 1
    end

    def go_char_right
      self.cursor = cursor + 1
    end

    def go_word_left
      if index = value.rindex(/.\b\s/, cursor - 1)
        self.cursor = index
      else
        self.cursor = @question.size
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