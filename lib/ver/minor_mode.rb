module VER
  def self.minor_mode(name, &block)
    minor = MinorMode[name]
    minor.instance_eval(&block)
    minor.handler nil
    minor
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
    include Platform
    include ModeResolving
    include Keymap::Results

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
      self.name = name = name.to_sym

      if MODES.key?(name)
        raise ArgumentError, "Duplicate #{self.class}: %p" % [name]
      else
        MODES[name] = self
      end

      self.parents = []
      self.keymap = Keymap.new
      self.receiver = nil

      MODES[self.name] = self
    end

    # recursively try to find the pattern in the minor mode and its parents.
    def resolve(pattern)
      super(pattern, parents)
    end

    # Add a parent for this minor mode.
    def inherits(*names)
      names.each do |name|
        minor = self.class[name]
        next if minor == self
        parents << minor
      end

      parents.uniq!
    end

    def become(other, *patterns)
      action = Action.new([:minor_mode, self, other], receiver, self)
      patterns.each{|pattern| keymap[pattern] = action }
    end

    def map(invocation, *patterns)
      action = Action.new(invocation, receiver, self)
      patterns.each{|pattern| keymap[pattern] = action }
    end

    def missing(invocation, &block)
      action = Fallback.new(invocation, receiver, self)
      self.fallback_action = action
    end

    def enter(invocation, &block)
      action = Action.new(invocation, receiver, self)
      self.enter_action = action
    end

    def leave(invocation, &block)
      action = Action.new(invocation, receiver, self)
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

    def actions
      unfold.map{|minor| minor.keymap.actions }
    end

    def to_sym
      name
    end

    def inspect
      "#<VER::MinorMode name=%p>" % [name]
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
