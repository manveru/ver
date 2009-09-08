module VER
  # The status bar
  class Status < Ttk::Entry
    attr_accessor :mode, :keymap, :view, :prompt

    def initialize(view, options = {})
      super

      @keymap = Keymap.vim(self)
      self.mode = :status_query
      self.view = view
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

    def status_issue
      answer = value.sub(@prompt, '')
      result = @callback.call(answer)
      self.value = result.inspect
    end
  end
end
