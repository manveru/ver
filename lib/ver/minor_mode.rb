module VER
  def self.minor_mode(name, &block)
    major = MinorMode[name]
    major.instance_eval(&block)
  end

  # A minor mode contains modifications for major modes.
  # It supports bidirectional inheritance to form a tree-like structure together
  # with other instance of MinorMode.
  # Every minor mode maintains its own keymap and performs lookup within that.
  # When no match can be found, the parents will be asked until a definite
  # result is returned.
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

    # def hash
    #   name.hash
    # end

    # recursively try to find the sequence in the minor mode and its parents.
    def resolve(sequence)
      case found = keymap[sequence]
      when INCOMPLETE
      when IMPOSSIBLE
        parents.find{|parent|
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
        self.parents << self.class[name]
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

    def replace_parent(major, old, new)
      parents.dup.each do |parent|
        if parent == old
          new.replaces major.widget, old do
            parents[parents.index(old)] = new
          end
        else
          parent.replace_parent(major, old, new)
        end
      end
    end

    def replaces(widget, other)
      other.replaced_by(widget, self) if other
      yield if block_given?
      self.replacing(widget, other)
    end

    def replaced_by(widget, other)
      Tk::Event.generate(widget, "<<LeaveMode>>", data: name)
      Tk::Event.generate(widget, "<<LeaveMinorMode>>", data: name)
      Tk::Event.generate(widget, "<<LeaveMinorMode#{to_camel_case}>>", data: name)
    end

    def replacing(widget, other)
      Tk::Event.generate(widget, "<<EnterMinorMode#{to_camel_case}>>", data: name)
      Tk::Event.generate(widget, "<<EnterMinorMode>>", data: name)
      Tk::Event.generate(widget, "<<EnterMode>>", data: name)
    end

    def synchronize(major)
      unfold.each do |minor|
        (minor.keymap.keys - major.bound_keys).each do |key|
          major.bind_key(key)
        end

        major.bind "<<LeaveMinorMode#{minor.to_camel_case}>>" do |event|
          if action = minor.leave_action
            action.call(WidgetEvent.new(event.widget, event))
          end
        end

        major.bind "<<EnterMinorMode#{minor.to_camel_case}>>" do |event|
          if action = minor.enter_action
            action.call(WidgetEvent.new(event.widget, event))
          end
        end
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
