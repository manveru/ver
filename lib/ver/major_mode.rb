module VER
  def self.major_mode(name, &block)
    major = MajorMode[name]
    major.instance_eval(&block)
    major
  end

  # This mode is responsible for maintaining a keymap of its own and a list of
  # minor modes that are immediately queried.
  # A major mode can inherit the keymap of another major mode in order to
  # specialize it.
  # The inherited keymap is duplicated upon inheritance and the original will
  # not be modified, the duplicate is merged in a manner that will not replace
  # existing sequences.
  #
  # The bound_keys property acts as a cache of the keys bound to the tag, so we
  # don't have to query the tag, as the bound proc is the same for all keys.
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

      KEYSYMS.each{|key, sym| bind_key(sym) }

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
      else
        found = [self, found]
      end

      if found == IMPOSSIBLE && fa = self.fallback_action
        return self, fa
      else
        return found
      end
    end

    def replace_minor(old, new)
      minors.each do |minor|
        minor.replace_parent(self, MinorMode[old], MinorMode[new])
      end
    end

    def bind_key(key)
      return if bound_keys.include?(key)

      tag.bind(key) do |event|
        event.widget.major_mode.on_event(event)
        Tk.callback_break
      end

      bound_keys << key
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
  end
end
