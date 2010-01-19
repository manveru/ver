module VER
  class Mode
    class Action < Struct.new(:handler, :method, :args)
      def initialize(handler, invocation)
        self.handler = handler
        method, *args = *invocation
        self.method, self.args = method, args
        # p method: method, args: args
      end

      def call(widget, *arg)
        # p "%p.send(%p, %p, %p)" % [handler, method, widget, [*args, *arg]]
        if handler
          handler.send(method, widget, *[*args, *arg])
        else
          widget.send(method, *[*args, *arg])
        end
      rescue => ex
        p "%p.send(%p, %p, %p)" % [handler, method, widget, [*args, *arg]]
        VER.error(ex)
      end
    end
  end
end
