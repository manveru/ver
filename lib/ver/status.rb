module VER
  # The status bar
  class Status < VER::Entry
    attr_accessor :keymap, :view
    attr_reader :mode

    def initialize(view, options = {})
      options[:style] ||= self.class.obtain_style_name
      super
      self.view = view

      keymap_name = VER.options.fetch(:keymap)
      self.keymap = Keymap.get(name: keymap_name, receiver: self)
    end

    def destroy
      style_name = style
      super
    ensure
      self.class.return_style_name(style_name)
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