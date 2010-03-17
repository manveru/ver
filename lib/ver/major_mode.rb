module VER
  def self.major_mode(name, &block)
    major = MajorMode[name]
    major.instance_eval(&block)
    major.handler nil
    major
  end

  # This mode is responsible for maintaining a keymap of its own and a list of
  # minor modes that are immediately queried.
  # A major mode can inherit the keymap of another major mode in order to
  # specialize it.
  # The inherited keymap is duplicated upon inheritance and the original will
  # not be modified, the duplicate is merged in a manner that will not replace
  # existing patterns.
  #
  # The bound_keys property acts as a cache of the keys bound to the tag, so we
  # don't have to query the tag, as the bound proc is the same for all keys.
  class MajorMode < Struct.new(:name, :minors, :keymap, :receiver,
                               :fallback_action, :tag, :bound_keys)

    include Platform
    include ModeResolving
    include Keymap::Results

    MODES = {}

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
      self.name = name = name.to_sym

      if MODES.key?(name)
        raise ArgumentError, "Duplicate #{self.class}: %p" % [name]
      else
        MODES[name] = self
      end

      self.minors = []
      self.keymap = Keymap.new
      self.bound_keys = Set.new
      self.tag = Tk::BindTag.new("#{name}-mode")

      # and now register all we didn't have yet.
      Event.each{|event| bind_key(event) }
    end

    def destroy
      tag.bind.each{|key| tag.unbind(key) }
      MODES.delete(name)
    end

    def handler(object)
      self.receiver = object
    end

    def map(invocation, *patterns)
      action = Action.new(invocation, receiver, self)
      patterns.each{|pattern| keymap[pattern] = action }
    end

    def missing(invocation)
      action = Fallback.new(invocation, receiver, self)
      self.fallback_action = action
    end

    def enter(invocation)
      action = Action.new(invocation, receiver, self)
      tag.bind "<<EnterMajorMode#{to_camel_case}>>" do |event|
        action.call(WidgetEvent.new(event.widget, event))
      end
    end

    def leave(invocation)
      action = Action.new(invocation, receiver, self)
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
        next if self.minors.any?{|m| m.name == minor.name }
        self.minors << minor
      end
    end

    def forget(*minors)
      self.minors -= minors.map{|name| MinorMode[name] }
    end

    # recursively try to find the pattern in the major mode and its minors.
    def resolve(pattern, minors = [])
      super
    end

    def replace_minor(old, new)
      minors.each do |minor|
        minor.replace_parent(self, MinorMode[old], MinorMode[new])
      end
    end

    def bind_key(key)
      case key
      when Event
        pattern = key.pattern
      when String
        pattern = Event[key].pasttern
      else
        raise ArgumentError, "Invalid key: %p" % [key]
      end

      return if bound_keys.include?(pattern)

      tag.bind(pattern) do |event|
        event.widget.major_mode.on_event(event)
        Tk.callback_break
      end

      bound_keys << pattern
    end

    def actions
      keymap.actions
    end

    def to_sym
      name
    end

    def inspect
      "#<VER::MajorMode name=%p>" % [name]
    end

    def hash
      name.hash
    end

    # we assume that name is unique
    def eql?(other)
      other.class == self.class && other.name == self.name
    end
  end
end
