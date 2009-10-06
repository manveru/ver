module VER
  # The status bar
  class Status < Ttk::Entry
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
  end
end
