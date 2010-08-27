module VER
  class MiniBuffer < Text
    HISTORY = Hash.new{|h,k| h[k] = SizedArray.new(50) }

    # NOTE:
    #   {Text#dump} on a peer text widget causes segfault, I've reported the
    #   issue to the tk maintainers and they are working on it.
    #   All tcl/tk versions are affected AFAIK, take care.
    class Peer < MiniBuffer
      attr_reader :buffer

      def initialize(text, parent, buffer, options = {})
        @tk_parent = parent
        @buffer = buffer
        @tk_pathname = Tk.register_object(parent, self)
        Tk.execute(text.tk_pathname, 'peer', 'create', @tk_pathname, options)
        setup_common
      end
    end

    def self.answer_from(text)
      line = text.get('current linestart', 'current lineend')
      minibuf = VER.minibuf
      minibuf.answer = line
      minibuf.complete_small
    end

    include Keymapped

    attr_accessor :messages_expire, :char_width, :ask_stack,
                  :at_insert, :completion_buffer
    attr_reader :asking, :messages, :messages_pending, :buffer

    def initialize(*args)
      super
      setup
    end

    def peer_create(parent, buffer, *args)
      Peer.new(self, parent, buffer, *args)
    end

    def setup
      setup_common

      @info.configure(foreground: '#fff')
      @warn.configure(foreground: '#f00')
      @highlight.configure(background: '#330')

      # Now to the difficult part.
      # When i talk about "tag", i mean the prompt and answer tags.
      #
      # If the "tag" contents are deleted, we will get errors in all places
      # where it's used.
      # To avoid that, we add extra tags called "tag"_keeper.
      # These are elided and contain only one character, their priority is
      # higher than "tag" to sure they never show.
      # The character within is also tagged with "tag".
      # When doing modifications, we just have to make sure that the
      # "tag"_keeper tag stays around.
      # To simplify referencing, we add a mark called "tag" with left gravity.
      # When getting contents of "tag", get only non-elided part.

      @prompt_keeper = tag(:prompt_keeper)
      insert('1.0', 'p', @prompt_keeper)
      @prompt_mark = mark(:prompt, '1.1', :left)
      @prompt_tag  = tag(:prompt, '1.0', '1.1')
      @prompt_keeper.configure(elide: true)
      tag_lower(@prompt_tag, @prompt_keeper)

      @answer_keeper = tag(:answer_keeper)
      insert('1.1', 'a', :answer_keeper)
      @answer_mark = mark(:answer, '1.2', :left)
      @answer_tag  = tag(:answer, '1.1', '1.2')
      @answer_keeper.configure(elide: true)
      tag_lower(@answer_tag, @answer_keeper)

      bind('<Configure>'){ pack_forget }
    end

    def setup_common
      configure(
        autoseparators: true,
        background: '#000',
        blockcursor: false,
        borderwidth: 0,
        exportselection: true,
        font: VER.options.font,
        foreground: '#fff',
        highlightbackground: '#000', # this specifies the colors
        highlightcolor: '#fff',      # that are used when the widget
        highlightthickness: 1,       # has input focus.
        insertbackground: '#fff',
        insertofftime: 0,
        setgrid: false, # wtf?
        undo: true,
        wrap: :word
      )

      self.major_mode = :MiniBuffer
      self.messages_expire = false
      @messages_pending = Hash.new(0)
      @messages = SizedArray.new(10)
      self.char_width = VER.options.font.measure('0')
      self.ask_stack = []
      self.at_insert = mark(:insert)
      self.completion_buffer = Tk::Text.new(tk_parent)
      @old_grid_info = nil

      [ :info, :warn, :highlight, :prompt, :answer ].each do |name|
        instance_variable_set("@#{name}", tag(name))
      end

      bind('<Configure>', &method(:adjust_size))
      bind('<Destroy>', &method(:on_destroy))
    end

    def on_destroy(event)
      @lock = true
    end

    def type(string)
      major_mode.fake(string)
    end

    def history
      HISTORY[@prompt.get]
    end

    def adjust_size(event = nil)
      if get_displaychars('1.0', 'end').strip.empty?
        if (info = grid_info) && !info.empty?
          @old_grid_info = info
          grid_forget
        end
      else
        height = count('1.0', 'end', 'displaylines') || 1
        grid_configure(@old_grid_info) if @old_grid_info
        configure(height: height)
      end

      # a generous 25ms to make sure the display is updated.
      # Might need longer, lemme know if that's the case.
      Tk::After.ms(25){ buffer.adjust_sight } if buffer
    rescue => ex
      VER.error(ex)
    end

    def prompt=(value)
      replace('prompt', 'prompt.last', value, 'prompt')
    end

    def prompt
      get_displaychars('prompt', 'prompt.last')
    end

    def answer=(value)
      replace('answer', 'answer.last', value, 'answer')
    end

    def answer
      get_displaychars('answer', 'answer.last')
    end

    def warn(object)
      case object
      when Exception
        message("#{object.class}: #{object}", 'warn')
      when Symbol, String
        message(object.to_s, 'warn')
      else
        message(object.to_str, 'warn')
      end
    end

    def message(string, tag = 'info')
      insert = at_insert.index

      begin
        replace("#{tag}.first", "#{tag}.last", " #{string}", tag)
        # mark(tag, "#{tag}.first", :left)
      rescue
        begin
          insert(tag, " #{string}", tag)
        rescue
          insert('1.0 lineend', " #{string}", tag)
        end
      end

      if string.to_s.strip != ''
        messages << string
        message_expire(tag) #  if messages_expire
        # message_notify(tag)
      end
      adjust_size

      self.insert = insert
      see "#{tag}.first"
    end

    def message_notify(tag, timeout = 500)
      tag_add('highlight', "#{tag}.first", "#{tag}.last")

      Tk::After.ms timeout.to_int do
        begin
          tag_remove('highlight', "#{tag}.first", "#{tag}.last")
        rescue
        end
      end
    end

    def message_expire(tag, timeout = 5000)
      self.messages_pending[tag] += 1

      Tk::After.ms timeout.to_int do
        self.messages_pending[tag] -= 1
        if messages_pending[tag] == 0
          delete("#{tag}.first", "#{tag}.last") rescue nil
          adjust_size
        end
      end
    end

    def claim_focus
      bind('<FocusOut>'){ focus; Tk.callback_break }
      focus
    end

    def release_focus
      bind('<FocusOut>'){ }
    end

    def ask(prompt, options = {}, action = nil, &block)
      action ||= block

      if @asking
        ask_stack << [prompt, options, action]
      else
        @asking = true
        @action = action || options[:action]
        @caller = options.fetch(:caller)

        self.prompt = prompt
        self.answer = options[:value]
        self.insert = 'answer.last'

        message ''
        warn ''
        self.messages_expire = true

        # Make sure display is ready.
        Tk.update
        focus
      end
    end

    def abort(event = nil)
      self.prompt = ''
      self.answer = ''
      completion_buffer.place_forget rescue nil
      @asking = false

      if ask_stack.empty?
        self.messages_expire = false
        @caller.focus
      else
        ask(*ask_stack.shift)
      end
    end

    def attempt(event = nil)
      HISTORY[@prompt.get] << answer
      invoke(:attempt)
    end

    def show_completions(completions)
      buffer = completion_buffer
      buffer.delete('1.0', 'end')
      completions.each do |completion|
        buffer.insert('end', completion, 'ver.minibuf.completion')
        buffer.insert('end', "\n")
      end
      buffer.place relx: 0.0, rely: 0.9, anchor: :sw, relheight: 0.9
    end

    def complete_small(event = nil)
      if choices = invoke(:complete)
        case choices.size
        when 0
        when 1
          self.answer = choices.first
        else
          self.answer = common_subchoice(choices)
        end
      end
    end

    def complete_large(event = nil)
      if choices = invoke(:complete)
        case choices.size
        when 0
        when 1
          self.answer = choices.first
        else
          self.answer = common_subchoice(choices)
          show_completions(choices)
        end
      end
    end

    def common_subchoice(choices)
      longest = choices.max_by{|choice| choice.size }
      common = ''

      longest.each_char do |char|
        current = common + char

        if choices.all?{|choice| choice.start_with?(current) }
          common << char
        else
          break
        end
      end

      common
    end

    def invoke(action, *args)
      Tk::Event.generate(self, "<<#{action.capitalize}>>")
      result = @action.call(answer, action, *args)
      result == :abort ? abort : result
    end

    def events
      major_mode.event_history
    end

    def insert_string
      case string = events.last.unicode
      when /^[^\n\r[:cntrl:]]+$/
        insert(:insert, string, 'answer')
        invoke(:modified)
      else
        l insert_string: string
      end
    end

    def insert_selection(event = nil)
      insert(:insert, Tk::Selection.get(type: 'UTF8_STRING'), 'answer')
      invoke(:modified)
    end

    def insert_tab(event = nil)
      insert(:insert, "\t", 'answer')
      invoke(:modified)
    end

    def end_of_line(event = nil)
      mark_set('insert', 'answer.last')
      invoke(:movement)
    end

    def kill_end_of_line(event = nil)
      content = get_displaychars('insert', 'answer.last')
      copy(content) if content =~ /\S/
      delete('insert', 'answer.last')
      invoke(:modified)
    end

    def delete_next_char(event = nil)
      return unless line = get_displaychars('insert', 'answer.last')
      delete('insert') unless line == ''
      invoke(:modified)
    end

    def delete_next_word(event = nil)
      line = get_displaychars('insert', 'answer.last')
      return unless word = line[/^\s*(?:\w+|[^\w\s]+)\s*/]
      delete('insert', "insert + #{word.size} chars")
      invoke(:modified)
    end

    def delete_prev_char(event = nil)
      return unless compare('insert', '>', 'answer')
      delete('insert - 1 display chars')
      invoke(:modified)
    end

    def delete_prev_word(event = nil)
      line = get_displaychars('answer', 'insert').reverse
      return unless word = line[/^\s*(?:\w+|[^\w\s]+)\s*/]
      delete("insert - #{word.size} display chars", 'insert')
      invoke(:modified)
    end

    def next_char(event = nil)
      return if compare('insert', '>=', 'answer.last')
      mark_set('insert', 'insert + 1 chars')
      invoke(:movement)
    end

    def prev_char(event = nil)
      return if compare('insert', '<=', 'answer')
      mark_set('insert', 'insert - 1 chars')
      invoke(:movement)
    end

    def start_of_line(event = nil)
      mark_set('insert', 'answer')
      invoke(:movement)
    end

    def transpose_chars(event = nil)
      insert = index('insert')
      line = get_displaychars('insert', 'answer.last')
      line[0, 2] = line[0, 2].reverse
      replace('insert', 'answer.last', line, 'answer')
      mark_set('insert', insert)
      invoke(:modified)
    end

    def copy(string)
      Clipboard.dwim = string
    end

    def paste(event = nil)
      return unless content = Clipboard.dwim
      insert(:insert, content, 'answer')
      invoke(:modified)
    end

    def prev_history
      history = HISTORY[@prompt.get]
      l prev_history: history
    end

    def next_history
      history = HISTORY[@prompt.get]
      l next_history: history
    end
  end
end
