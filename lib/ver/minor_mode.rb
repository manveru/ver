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
  class MinorMode < Struct.new(:name, :parents, :children, :keymap, :receiver, :fallback_action)
    include CommonMode
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
      self.children = []
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
          found = parent.resolve(sequence)
          found != INCOMPLETE && found != IMPOSSIBLE
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
        mode = self.class[name]
        parents << mode
        parents.uniq!
        mode.children << self
      end
    end

    def become(other, *sequences)
    end

    def missing(invocation, &block)
      action = Action.new(receiver, *invocation, &block)
      keymap['<Key>'] = action
    end

    def enter(&block)
    end

    def leave(&block)
    end

    def handler(object)
      self.receiver = object
    end

    def synchronize(major)
      (keymap.keys - major.bound_keys).each do |key|
        major.bind_key(key)
        major.bound_keys << key
      end
    end

    def to_sym
      name
    end

    def inspect
      "#<VER::MinorMode name=%p>" % [name]
    end
  end
end
