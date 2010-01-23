require_relative 'common_mode'
require_relative 'action'

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
    include CommonMode

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

      synchronize
    end

    def inherits(name)
      mode = self.class[name]
      keymap.merge!(mode.keymap)
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
      minors.each do |name|
        minor = MinorMode[name]
        self.minors.delete(minor)
      end
    end

    # recursively try to find the sequence in the major mode and its minor
    # modes.
    def resolve(sequence, minors = [])
      case found = keymap[sequence]
      when INCOMPLETE
      when IMPOSSIBLE
        minors.find{|minor| found = minor.resolve(sequence) }
      end

      if found == IMPOSSIBLE && fa = self.fallback_action
        fa
      else
        found
      end
    end

    def synchronize
      (keymap.keys - bound_keys).each do |key|
        bind_key(key)
        bound_keys << key
      end
      minors.each do |minor|
        minor.synchronize(self)
      end
    end

    def bind_key(key)
      tag.bind(key) do |event|
        event.widget.major_mode.on_event(event)
        Tk.callback_break
      end
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
      @widget, @event = widget, @event
    end

    def method_missing(method, *args)
      result = @widget.send(method, *args)

      if method =~ /=/
        ::VER::WidgetEvent.class_eval(<<-RUBY, __FILE__, __LINE__)
          def #{method}(arg)
            @widget.#{method} = arg
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
  end

  class WidgetMajorMode < Struct.new(:widget, :major, :minors, :history, :stack)
    INCOMPLETE = Keymap::INCOMPLETE
    IMPOSSIBLE = Keymap::IMPOSSIBLE

    def initialize(widget, major)
      self.widget = widget
      self.major = MajorMode[major]
      self.minors = self.major.minors.dup
      self.history = SizedArray.new(100)
      self.stack = []

      establish
    end

    def use(*minors)
      minors.each do |name|
        minor = MinorMode[name]
        minor.synchronize(major)
        self.minors << minor
      end
      self.minors.uniq!
    end

    def forget(*minors)
      minors.each do |name|
        minor = MinorMode[name]
        self.minors.delete(minor)
      end
    end

    def on_event(event)
      stack << event.sequence
      history << event

      case result = resolve(stack)
      when IMPOSSIBLE
        stack.clear
      when INCOMPLETE
      else
        stack.clear
        result.call(WidgetEvent.new(widget, event))
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
      Tk::Event.generate(widget, "<<LeaveMode#{to_camel_case}>>", data: name)
    end

    def replacing(other)
      Tk::Event.generate(widget, "<<EnterMode#{to_camel_case}>>", data: name)
      Tk::Event.generate(widget, "<<EnterMode>>", data: name)
    end

    def name
      major.name
    end

    def to_camel_case
      major.name.to_s.split('_').map{|e| e.capitalize}.join
    end

    private

    def establish
      tags = widget.bindtags
      specific = tags[0, 1]
      general = tags[-3..-1]
      widget.bindtags(*specific, major.tag, *general)
    end
  end
end
