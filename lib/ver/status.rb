module VER
  # The status bar
  class Status < VER::Entry
    attr_accessor :keymap, :view
    attr_reader :mode

    HISTORY = Hash.new{|k,v| k[v] = [] }

    def initialize(view, options = {})
      options[:style] ||= self.class.obtain_style_name
      super
      self.view = view
      @question = ''

      keymap_name = VER.options.keymap
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

    def ask(question, options = {}, &callback)
      @backup_value, @callback = value, callback
      @history_idx = -1

      self.question = question
      submit_when_taken(options[:take])
      focus
    end

    def submit_when_taken(length)
      return unless length
      target = value.size + length

      bind '<<Modified>>' do |event|
        if value.size >= target
          bind('<<Modified>>'){}
          ask_submit
        end
      end
    end

    def ask_submit
      answer = value
      history = HISTORY[@question]
      history.uniq!
      history << answer
      self.question = ''

      case result = @callback.call(answer)
      when String
        message result
      when Symbol
        result
      else
        message result.inspect
      end
    end

    def ask_abort
      self.question = ''
      self.value = @backup_value
      text.focus
    end

    def delete(from, to = Tk::None)
      if from < @question.size
        from = @question.size
      end

      super(from, to)
    end

    def value=(string)
      super([@question, string].join)
    end

    def value
      regex = Regexp.escape(@question)
      get.sub(/^#{regex}/, '')
    end

    def question=(string)
      execute_only(:delete, 0, :end)
      execute_only(:insert, 0, string)
      @question = string.to_s
      Tk::Event.generate(self, '<<Modified>>')
    end

    def cursor=(pos)
      return if pos < @question.size
      super
    end

    def history_prev
      @history_idx -= 1
      history = HISTORY[@question]

      if @history_idx < 0
        @history_idx = history.size - 1
      end

      # p prev: [history, @history_idx]
      answer = history[@history_idx]
      return unless answer
      self.value = answer
    end

    def history_next
      @history_idx += 1
      history = HISTORY[@question]

      if @history_idx > history.size
        @history_idx = 0
      end

      # p next: [history, @history_idx]
      answer = history[@history_idx]
      return unless answer
      self.value = answer
    end

    def history_complete
      history = HISTORY[@question]
      so_far = value.sub(@question, '')
      needle = Regexp.escape(so_far)
      list = history.grep(/#{needle}/i)
      return if list.empty?

      self.value = answer
    end
  end
end
