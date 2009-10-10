module VER
  # The status bar
  class Status < VER::Entry
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
      @keymap.mode = @mode = name.to_sym
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

    def delete_char_left
      return if @question.size == cursor
      super
    end

    def go_char_left
      return if @question.size == cursor
      super
    end

    def go_word_left
      if index = value.rindex(/.\b\s/, cursor - 1)
        self.cursor = index
      else
        self.cursor = @question.size
      end
    end
  end
end