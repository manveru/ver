module VER
  class MiniBuffer < Tk::Text
    include Keymapped

    attr_accessor :messages_expire, :messages_pending, :char_width

    def initialize(*args)
      super

      font = VER.options.font
      configure(
        font: font,
        wrap: :none,
        undo: true,
        borderwidth: 0,
        exportselection: true,
        insertofftime: 0,
        setgrid: false, # wtf?
        autoseparators: true,
        blockcursor: false,
        background: '#000',
        foreground: '#fff',
        insertbackground: '#fff'
      )

      self.major_mode = :MiniBuffer
      self.messages_expire = false
      self.messages_pending = 0
      self.char_width = font.measure('0')

      tag_configure 'info', foreground: '#fff'
      tag_configure 'warn', foreground: '#f00'
      tag_configure 'highlight', background: '#330'

      bind('<Configure>'){ adjust_size }
    end

    def adjust_size
      configure(
        width: (tk_parent.winfo_width / char_width.to_f).floor,
        height: count('1.0', 'end', :lines)
      )
    end

    def prompt=(prompt)
      replace 'prompt.first', 'prompt.last', prompt, 'prompt'
    rescue
      insert '1.0 linestart', prompt, 'prompt'
    end

    def prompt
      get('prompt.first', 'prompt.last')
    rescue
      ''
    end

    def answer=(answer)
      replace 'answer.first', 'answer.last', answer, 'answer'
    rescue
      insert 'prompt.last', answer, 'answer'
    rescue
      insert 'end', answer, 'answer'
    end

    def answer
      get('answer.first', 'answer.last')
    rescue
      ''
    end

    def message(string, tag = 'info')
      Tk::After.idle do
        insert = index('insert')

        begin
          replace "#{tag}.first", "#{tag}.last", " #{string}", tag
        rescue
          insert '1.0 lineend', " #{string}", tag
        end

        mark_set('insert', insert)
        see "#{tag}.first"

        message_expire(tag) #  if messages_expire
        message_notify(tag)
        message_buffer_insert(string, tag)
      end
    end

    def message_buffer_insert(string, tag)
      string = "#{string}\n" unless string.end_with?("\n")
      buffer = Buffer[:Messages]
      buffer.text.execute(:insert, :end, string, tag)

      last_focus = Tk::Focus.focus # for some reason
      buffer.text.see(:end)        # this changes focus to the text
      Tk::Focus.focus(last_focus)  # so we restore it here
    end

    def message_notify(tag, timeout = 500)
      tag_add('highlight', "#{tag}.first", "#{tag}.last")

      Tk::After.ms timeout.to_int do
        tag_remove('highlight', "#{tag}.first", "#{tag}.last")
      end
    end

    def message_expire(tag, timeout = 3000)
      self.messages_pending += 1

      Tk::After.ms timeout.to_int do
        self.messages_pending -= 1
        if messages_pending == 0
          delete("#{tag}.first", "#{tag}.last") rescue nil
        end
      end
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

    def ask(prompt, options = {}, &action)
      @action = action || options[:action]
      @caller = options.fetch(:caller)

      self.prompt = prompt
      self.answer = options[:value].to_s

      message ''
      warn ''
      self.messages_expire = true
      bind('<FocusOut>'){ focus }
      focus
    end

    def abort(event = nil)
      self.answer = ''
      self.prompt = ''
      bind('<FocusOut>'){ }
      self.messages_expire = false
      Buffer[:Completions].hide
      @caller.focus
    end

    def attempt(event = nil)
      invoke(:attempt)
    end

    def self.answer_from(text)
      line = text.get('current linestart', 'current lineend')
      minibuf = VER.minibuf
      minibuf.answer = line
      minibuf.complete_small
    end

    def show_completions(completions)
      buffer = Buffer[:Completions]
      text = buffer.text
      text.delete('1.0', 'end')
      completions.each do |completion|
        text.insert('end', completion, 'ver.minibuf.completion')
        text.insert('end', "\n")
      end
      buffer.show
    end

    def complete_small(event = nil)
      if choices = invoke(:complete)
        if choices.size == 1
          self.answer = choices.first
        end
      end
    end

    def complete_large(event = nil)
      if choices = invoke(:complete)
        if choices.size == 1
          self.answer = choices.first
        elsif choices.size > 1
          show_completions(choices)
        end
      end
    end

    def invoke(action, *args)
      Tk::Event.generate(self, "<<#{action.capitalize}>>")
      case result = @action.call(answer, action, *args)
      when :abort
        abort
      else
        result
      end
    end

    def insert_string(event)
      case string = event.unicode
      when /^([[:word:][:ascii:]]| )+$/
        insert(:insert, string, 'answer')
        invoke(:modified)
      else
        p string
      end
    end

    def insert_selection(event = nil)
      insert(:insert, Tk::Selection.get, 'answer')
      invoke(:modified)
    end

    def insert_tab(event = nil)
      insert(:insert, "\t", 'answer')
      invoke(:modified)
    end

    def end_of_line(event = nil)
      return if tag_ranges('answer').empty?
      mark_set('insert', 'answer.last')
      invoke(:movement)
    end

    def kill_end_of_line(event = nil)
      return if tag_ranges('answer').empty?
      delete('insert', 'answer.last')
      invoke(:modified)
    end

    def kill_next_char(event = nil)
      return if tag_ranges('answer').empty?
      delete('insert')
      invoke(:modified)
    end

    def kill_next_word(event = nil)
      return if tag_ranges('answer').empty?
      line = get('insert', 'answer.last')
      return unless word = line[/^\s*(?:\w+|[^\w\s]+)\s*/]
      delete('insert', "insert + #{word.size} chars")
      invoke(:modified)
    end

    def kill_prev_char(event = nil)
      return if tag_ranges('answer').empty?
      delete('insert - 1 chars')
      invoke(:modified)
    end

    def kill_prev_word(event = nil)
      return if tag_ranges('answer').empty?
      line = get('answer.first', 'insert').reverse
      return unless word = line[/^\s*(?:\w+|[^\w\s]+)\s*/]
      delete("insert - #{word.size} chars", 'insert')
      invoke(:modified)
    end

    def next_char(event = nil)
      return if tag_ranges('answer').empty?
      return if compare('insert', '>=', 'answer.last')
      mark_set('insert', 'insert + 1 chars')
      invoke(:movement)
    end

    def prev_char(event = nil)
      return if tag_ranges('answer').empty?
      return if compare('insert', '<=', 'answer.first')
      mark_set('insert', 'insert - 1 chars')
      invoke(:movement)
    end

    def start_of_line(event = nil)
      return if tag_ranges('answer').empty?
      mark_set('insert', 'answer.first')
      invoke(:movement)
    end

    def transpose_chars(event = nil)
      return if tag_ranges('answer').empty?
      insert = index('insert')
      line = get('insert', 'answer.last')
      line[0, 2] = line[0, 2].reverse
      replace('insert', 'answer.last', line, 'answer')
      mark_set('insert', insert)
      invoke(:modified)
    end
  end
end
