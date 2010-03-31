module VER
  # The WidgetMajorMode associates a widget with a major mode.
  # It keeps a limited history of the events that arrive at [on_event].
  # It also maintains a stack of the event patterns and tries to match
  # against the keymaps of the major and minor modes.
  #
  # This class has its own list of minor modes, which can be modified and may
  # differ from the minor modes of the original major mode.
  #
  # It is responsible to keep the keymaps of major and minor modes functioning
  # by ensuring that they are actually bound to the tag of the major mode.
  class WidgetMajorMode < Struct.new(:widget, :major, :minors, :stack,
                                     :event_history, :action_history, :reader,
                                     :read_amount)
    include Keymap::Results

    def initialize(widget, major)
      self.widget = widget
      self.major = MajorMode[major]
      self.event_history  = SizedArray.new(500) # this may be too small still
      self.action_history = SizedArray.new(100)
      self.stack = []
      self.minors = []

      establish_tag
      use(*self.major.minors)
      listen

      # in case we had some keymap updates, they must have been registered by
      # now, since otherwise we wouldn't be here.
      # This will be called around 3 times per startup.
      Event.done_yet?
    end

    def listen
      VER.root.bind('<<PluginLoaded>>'){|event| synchronize }
    end

    def bound_keys
      major.bound_keys
    end

    # Shortcut to bind a pattern on the associated widget.
    def bind(pattern, &block)
      widget.bind(pattern, &block)
    end

    def bind_key(key)
      major.bind_key(key)
    end

    def use(*minors)
      minors.each do |name|
        minor = MinorMode[name]
        next if self.minors.any?{|m| m.name == minor.name }
        self.minors << minor
      end

      synchronize
    end

    def forget(*minors)
      self.minors -= minors.map{|name| MinorMode[name] }
    end

    def fake(input)
      input.scan(/<[\w-]+>|[^<>]/) do |name|
        # get the widget that currently has focus, this might not be self.
        path = Tk::Focus.focus
        widget = Tk.pathname_to_widget(path)

        if widget == self.widget
          on_event(Event[name])
          Tk.update
        else
          widget.type(name)
        end
      end
    end

    def on_event(event)
      VER.touch
      stack << event.pattern

      # replace with our subset
      event = Event.new(event.pattern, event.keysym, event.unicode)
      event_history << event

      return handle_reader(event) if reader && read_amount

      result = resolve(stack)
      case result
      when Incomplete
        message result.to_s(widget)
        # don't do anything yet...
      when Impossible
        warn result.to_s
        stack.clear
      else
        stack.clear
        message ''
        mode, action = *result
        widget_event = WidgetEvent.new(widget, event)
        action.call(widget_event)
        action_history << [widget_event, *result]
      end
    end

    def message(*args)
      if widget.respond_to?(:message)
        widget.message(*args)
      else
        VER.message(*args)
      end
    end

    def warn(*args)
      if widget.respond_to?(:warn)
        widget.warn(*args)
      else
        VER.warn(*args)
      end
    end

    # ignore event for now, it might be needed later
    def handle_reader(event)
      read_amount = self.read_amount

      if stack.size >= read_amount
        stack.clear

        # before we call, we reset the state in case the reader adds a new reader.
        reader = self.reader
        self.reader = self.read_amount = nil
        reader.call(*event_history.last(read_amount))
        true
      else
        false
      end
    end

    def read(amount, &reader)
      amount = amount.to_int
      raise ArgumentError, "amount must be greater than 0" unless amount > 0
      self.read_amount = amount
      self.reader = reader
    end

    def resolve(pattern)
      major.resolve(pattern, minors)
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
      major.keymap.keys.each do |key|
        major.bind_key(key)
      end

      minors.each do |minor|
        minor.synchronize_recursively(self)
      end
    end

    def actions
      major.actions + minors.map{|minor| minor.actions }.flatten
    end

    def to_hash
      [major.keymap, *minors].inject{|h, m| h.merge(m.keymap) }
    end

    def name
      major.name
    end

    def tag
      major.tag
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
        minors: minors.map{|m| m.to_sym },
        event_history: event_history.map(&:keysym),
        stack: stack,
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
