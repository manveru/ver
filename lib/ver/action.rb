module VER
  class Action < Struct.new(:invocation, :handler)
    def call(widget, *given_args)
      case handler
      when Symbol
        widget.send(handler).send(*invocation, *given_args)
      when Module
        method, *args = *invocation
        handler.send(method, widget, *args, *given_args)
      when nil
        widget.send(*invocation, *given_args)
      else
        raise ArgumentError
      end
    rescue => ex
      require 'pp'
      puts self
      pp ex, ex.backtrace
    end

    def combine(action)
      invocation = [*self.invocation, action]
      self.class.new(invocation, handler)
    end
  end
end
