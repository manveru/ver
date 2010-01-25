module VER
  def self.major_mode(name, &block)
    major = MajorMode[name]
    major.instance_eval(&block)
  end

  # This mode is responsible for maintaining a keymap of its own and a list of
  # minor modes that are immediately queried.
  # A major mode can inherit the keymap of another major mode in order to
  # specialize it.
  # The inherited keymap is duplicated upon inheritance and the original will
  # not be modified, the duplicate is merged in a manner that will not replace
  # existing sequences.
  #
  # Every widget in VER has one major mode.
  # For any widget, a major mode may change minor modes, which will not affect
  # other widgets using the same major mode.
  class MajorMode < Struct.new(:name, :minors, :keymap, :receiver,
                               :fallback_action, :tag, :bound_keys)

    MODES = {}
    INCOMPLETE = Keymap::INCOMPLETE
    IMPOSSIBLE = Keymap::IMPOSSIBLE

    def self.[](name)
      name = name.to_sym

      if MODES.key?(name)
        MODES[name]
      else
        new(name)
      end
    end

    def self.clear
      MODES.each_value(&:destroy)
    end

    def initialize(name)
      self.name = name.to_sym
      self.minors = []
      self.keymap = Keymap.new
      self.bound_keys = Set.new
      self.tag = Tk::BindTag.new("#{name}-mode")

      MODES[self.name] = self
    end

    def destroy
      tag.bind.each{|key| tag.unbind(key) }
      MODES.delete(name)
    end

    def handler(object)
      self.receiver = object
    end

    def map(invocation, *sequences, &block)
      action = Action.new(receiver, *invocation, &block)

      sequences.each do |sequence|
        keymap[sequence] = action
      end
    end

    def missing(invocation, &block)
      action = Action.new(receiver, *invocation, &block)
      self.fallback_action = action
      keymap['<Key>'] = action
    end

    def enter(invocation, &block)
      action = Action.new(receiver, *invocation, &block)
      tag.bind "<<EnterMajorMode#{to_camel_case}>>" do |event|
        action.call(WidgetEvent.new(event.widget, event))
      end
    end

    def leave(invocation, &block)
      action = Action.new(receiver, *invocation, &block)
      tag.bind "<<LeaveMajorMode#{to_camel_case}>>" do |event|
        action.call(WidgetEvent.new(event.widget, event))
      end
    end

    def inherits(name)
      mode = self.class[name]
      keymap.merge!(mode.keymap)
    end

    def use(*minors)
      minors.each do |name|
        minor = MinorMode[name]
        self.minors << minor
      end

      self.minors.uniq!
    end

    def forget(*minors)
      self.minors -= minors.map{|name| MinorMode[name] }
    end

    # recursively try to find the sequence in the major mode and its minor
    # modes.
    def resolve(sequence, minors = [])
      case found = keymap[sequence]
      when INCOMPLETE
      when IMPOSSIBLE
        minors.find{|minor|
          found = minor.resolve(sequence)
          found != IMPOSSIBLE
        }
      end

      if found == IMPOSSIBLE && fa = self.fallback_action
        fa
      else
        found
      end
    end

    def replace_minor(old, new)
      minors.each do |minor|
        minor.replace_parent(self, MinorMode[old], MinorMode[new])
      end
    end

    def bind_key(key)
      tag.bind(key) do |event|
        event.widget.major_mode.on_event(event)
        Tk.callback_break
      end
      bound_keys << key
    end

    def to_sym
      name
    end

    def inspect
      "#<VER::MajorMode name=%p>" % [name]
    end
  end

  class WidgetEvent < BasicObject
    attr_reader :widget, :event

    def initialize(widget, event)
      @widget, @event = widget, event
    end

    def method_missing(method, *args)
      ::Kernel.p([method, args])
      result = @widget.send(method, *args)

      if method =~ /=/
        ::VER::WidgetEvent.class_eval(<<-RUBY, __FILE__, __LINE__)
          def #{method}(arg)
            @widget.#{method} arg
          end
        RUBY
      else
        ::VER::WidgetEvent.class_eval(<<-RUBY, __FILE__, __LINE__)
          def #{method}(*args)
            @widget.#{method}(*args)
          end
        RUBY
      end

      result
    end
    alias send method_missing
  end

  class WidgetMajorMode < Struct.new(:widget, :major, :minors, :history, :stack)
    INCOMPLETE = Keymap::INCOMPLETE
    IMPOSSIBLE = Keymap::IMPOSSIBLE

    def initialize(widget, major)
      self.widget = widget
      self.major = MajorMode[major]
      self.history = SizedArray.new(100)
      self.stack = []
      self.minors = []

      establish_tag
      use(*self.major.minors)
    end

    def bound_keys
      major.bound_keys
    end

    def bind(sequence, &block)
      widget.bind(sequence, &block)
    end

    def bind_key(key)
      major.bind_key(key)
    end

    def use(*minors)
      minors.each do |name|
        minor = MinorMode[name]
        minor.synchronize(self)
        self.minors << minor
      end

      self.minors.uniq!
    end

    def forget(*minors)
      self.minors -= minors.map{|name| MinorMode[name] }
    end

    def on_event(event)
      p event
      stack << event.sequence
      history << event

      stack_string = stack.map{|seq| SYMKEYS[seq] || seq }.join(' - ')

      case result = resolve(stack)
      when INCOMPLETE
        VER.message "#{stack_string} -"
        # don't do anything yet...
      when IMPOSSIBLE
        VER.message "#{stack_string} is undefined"
        stack.clear
      else
        stack.clear
        result.call(WidgetEvent.new(widget, event))
        VER.message "#{stack_string} => #{result}"
      end
    end

    def resolve(sequence)
      major.resolve(sequence, minors)
    end

    def replaces(other)
      other.replaced_by(self) if other
      yield if block_given?
      self.replacing(other)
    end

    def replaced_by(other)
      Tk::Event.generate(widget, "<<LeaveMode>>", data: name)
      Tk::Event.generate(widget, "<<LeaveMajorMode>>", data: name)
      Tk::Event.generate(widget, "<<LeaveMajorMode#{to_camel_case}>>", data: name)
    end

    def replacing(other)
      Tk::Event.generate(widget, "<<EnterMajorMode#{to_camel_case}>>", data: name)
      Tk::Event.generate(widget, "<<EnterMajorMode>>", data: name)
      Tk::Event.generate(widget, "<<EnterMode>>", data: name)
    end

    def replace_minor(old, new)
      old, new = MinorMode[old], MinorMode[new]

      minors.dup.each do |minor|
        if minor == old
          new.replaces self, old do
            minors[minors.index(old)] = new
          end
        else
          minor.replace_parent(self, old, new)
        end
      end

      synchronize
    end

    def synchronize
      (major.keymap.keys - major.bound_keys).each do |key|
        major.bind_key(key)
      end

      minors.each do |minor|
        minor.synchronize(self)
      end
    end

    def name
      major.name
    end

    def to_tcl
      widget.tk_pathname
    end

    def to_camel_case
      major.name.to_s.split('_').map{|e| e.capitalize}.join
    end

    def inspect
      out = ['#<Ver::WidgetMajorMode']
      { major: major.name,
        minors: minors.map{|m| m.name },
        history: history.map{|h| h.keysym },
        stack: stack.map{|s| s.keysym },
      }.each{|k,v| out << "#{k}=#{v.inspect}" }
      out.join(' ') << '>'
    end

    def establish_tag
      tags = widget.bindtags
      specific = tags[0, 1]
      general = tags[-3..-1]
      widget.bindtags(*specific, major.tag, *general)
    end
  end
end
