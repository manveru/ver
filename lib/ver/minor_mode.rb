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
  class MinorMode < Struct.new(:name, :parents, :keymap, :receiver, :fallback_action)
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

    def enter(&block)
    end

    def leave(&block)
    end

    def handler(object)
      self.receiver = object
    end

    def synchronize(major)
      unfold.each do |minor|
        (minor.keymap.keys - major.bound_keys).each do |key|
          major.bind_key(key)
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

    def to_sym
      name
    end

    def inspect
      "#<VER::MinorMode name=%p>" % [name]
    end
  end
end
