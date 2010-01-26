module VER
  def self.minor_mode(name, &block)
    major = MinorMode[name]
    major.instance_eval(&block)
  end

  # A minor mode contains modifications for major modes.
  # It supports unidirectional inheritance to form a tree-like structure together
  # with other instance of MinorMode.
  # Every minor mode maintains its own keymap and performs lookup within that.
  # When no match can be found, the parents will be asked until a definite
  # result is returned.
  #
  # A MinorMode is expected to interact with the WidgetMajorMode only, not with
  # MajorMode directly.
  #
  # Modification of a MinorMode will not be fully reflected until the
  # [WidgetMajorMode#synchronize] method has been called and the minor mode is
  # part of the tree of minors of this major mode.
  class MinorMode < Struct.new(:name, :parents, :keymap, :receiver,
                               :fallback_action, :enter_action, :leave_action)
    INCOMPLETE = Keymap::INCOMPLETE
    IMPOSSIBLE = Keymap::IMPOSSIBLE

    MODES = {}

    # Find or create the minor mode for the given name.
    def self.[](name)
      name = name.to_sym

      if MODES.key?(name)
        MODES[name]
      else
        new(name)
      end
    end

    # Delete all minor modes.
    def self.clear
      MODES.clear
    end

    def initialize(name)
      self.name = name.to_sym
      self.parents = []
      self.keymap = Keymap.new
      self.receiver = nil

      MODES[self.name] = self
    end

    # recursively try to find the sequence in the minor mode and its parents.
    def resolve(sequence)
      case found = keymap[sequence]
      when INCOMPLETE
      when IMPOSSIBLE
        parents.find{|parent|
          next if parent == self
          found = parent.resolve(sequence)
          found != IMPOSSIBLE
        }
      end

      if found == IMPOSSIBLE && fa = self.fallback_action
        fa
      else
        found
      end
    end

    # Add a parent for this minor mode.
    def inherits(*names)
      names.each do |name|
        minor = self.class[name]
        self.parents << minor unless minor == self
      end
      self.parents.uniq!
    end

    def become(other, *sequences)
      action = Action.new(receiver, :minor_mode, [self, other])

      sequences.each do |sequence|
        keymap[sequence] = action
      end
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
      (KEYSYMS.values - keymap.keys.to_a).each do |name|
        keymap[name] = action
      end
    end

    def enter(invocation, &block)
      action = Action.new(receiver, *invocation, &block)
      self.enter_action = action
    end

    def leave(invocation, &block)
      action = Action.new(receiver, *invocation, &block)
      self.leave_action = action
    end

    def handler(object)
      self.receiver = object
    end

    def replace_parent(widget_major, old, new)
      parents.dup.each do |parent|
        if parent == old
          new.replaces widget_major, old do
            parents[parents.index(old)] = new
          end
        else
          parent.replace_parent(widget_major, old, new)
        end
      end
    end

    def replaces(widget_major, other)
      other.replaced_by(widget_major, self) if other
      yield if block_given?
      self.replacing(widget_major, other)
    end

    def replaced_by(widget_major, other)
      return unless widget_major.respond_to?(:widget)
      widget = widget_major.widget
      leave_action.call(widget, self, other) if leave_action
      Tk::Event.generate(widget, "<<LeaveMode>>", data: name)
      Tk::Event.generate(widget, "<<LeaveMinorMode>>", data: name)
      Tk::Event.generate(widget, "<<LeaveMinorMode#{to_camel_case}>>", data: name)
    end

    def replacing(widget_major, other)
      return unless widget_major.respond_to?(:widget)
      widget = widget_major.widget
      enter_action.call(widget, other, self) if enter_action
      Tk::Event.generate(widget, "<<EnterMinorMode#{to_camel_case}>>", data: name)
      Tk::Event.generate(widget, "<<EnterMinorMode>>", data: name)
      Tk::Event.generate(widget, "<<EnterMode>>", data: name)
    end

    def synchronize_recursively(widget_major)
      unfold.each do |minor|
        minor.synchronize(widget_major)
      end
    end

    def synchronize(widget_major)
      keymap.keys.each do |key|
        widget_major.bind_key(key)
      end
    end

    def unfold(all = [self])
      pending = self.parents.dup

      while current = pending.shift
        unless all.include?(current)
          all << current
          pending.concat(current.unfold(all)).flatten!
        end
      end

      all
    end

    def to_camel_case
      name.to_s.split('_').map{|e| e.capitalize}.join
    end

    def to_sym
      name
    end

    def inspect
      "#<VER::MinorMode name=%p>" % [name]
    end
  end
end
