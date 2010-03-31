module VER
  module Methods
    module Macro
      module_function

      def enter(buffer, old_mode, new_mode)
        name = buffer.events.last.unicode
        buffer.store(self, :current, name)
      end

      def leave(buffer, old_mode, new_mode)
        history = []
        name = buffer.store(self, :current)
        macro_invocation = [:minor_mode, MinorMode[:control], :macro]

        buffer.actions.reverse_each do |widget, mode, action|
          break if action.invocation == macro_invocation
          history << ->{ action.call(widget) }
        end

        buffer.store(self, name, history.reverse)
      end

      def repeat(buffer)
        if actions = buffer.store(self, current(buffer))
          actions.each(&:call)
        else
          buffer.warn("No macro used yet")
        end
      end

      def play(buffer, name)
        if actions = buffer.store(self, name)
          actions.each(&:call)
        else
          buffer.warn("No macro called %p" % [name])
        end
      end

      def current(buffer)
        buffer.store(self, :current)
      end
    end
  end
end
