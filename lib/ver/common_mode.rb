module VER
  module CommonMode
    # these are DSL methods

    def map(invocation, *sequences, &block)
      action = Action.new(receiver, *invocation, &block)

      sequences.each do |sequence|
        keymap[sequence] = action
      end
    end

    # Assign a fallback action that is returned when resolve is impossible.
    def fallback(invocation, &block)
      action = Action.new(receiver, *invocation, &block)
      self.fallback_action = action
    end
  end
end
