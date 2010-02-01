module VER
  # The WidgetMajorMode associates a widget with a major mode.
  # It keeps a limited history of the events that arrive at [on_event].
  # It also maintains a stack of the event sequences and tries to match
  # against the keymaps of the major and minor modes.
  #
  # This class has its own list of minor modes, which can be modified and may
  # differ from the minor modes of the original major mode.
  #
  # It is responsible to keep the keymaps of major and minor modes functioning
  # by ensuring that they are actually bound to the tag of the major mode.
  class WidgetMajorMode < Struct.new(:widget, :major, :minors, :stack,
                                     :event_history, :action_history)
    INCOMPLETE = Keymap::INCOMPLETE
    IMPOSSIBLE = Keymap::IMPOSSIBLE

    def initialize(widget, major)
      self.widget = widget
      self.major = MajorMode[major]
      self.event_history = SizedArray.new(100)
      self.action_history = SizedArray.new(100)
      self.stack = []
      self.minors = []

      establish_tag
      use(*self.major.minors)
      listen
    end

    def listen
      VER.root.bind('<<PluginLoaded>>'){|event| synchronize }
    end

    def bound_keys
      major.bound_keys
    end

    # Shortcut to bind a sequence on the associated widget.
    def bind(sequence, &block)
      widget.bind(sequence, &block)
    end

    def bind_key(key)
      major.bind_key(key)
    end

    def use(*minors)
      minors.each do |name|
        minor = MinorMode[name]
        self.minors << minor
      end

      self.minors.uniq!
      synchronize
    end

    def forget(*minors)
      self.minors -= minors.map{|name| MinorMode[name] }
    end

    def on_event(event)
      stack << event.sequence
      event_history << {
        sequence: event.sequence,
        keysym: event.keysym,
        unicode: event.unicode
      }

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
        mode, action = result
        widget_event = WidgetEvent.new(widget, event)
        action.call(widget_event)
        action_history << [widget_event, *result]
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
      major.keymap.keys.each do |key|
        major.bind_key(key)
      end

      minors.each do |minor|
        minor.synchronize_recursively(self)
      end
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
        event_history: event_history.map{|h| h[:keysym] },
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
