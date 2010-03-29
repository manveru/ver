module VER
  class Action < Struct.new(:invocation, :handler, :mode)
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
      VER.error("Exception from %p" % [self])
      VER.error(ex)
    end

    def combine(action)
      invocation = [*self.invocation, action]
      self.class.new(invocation, handler, mode)
    end

    def to_proc
      Proc.new{|widget, *args| call(widget, *args) }
    end

    def to_method(widget)
      case handler
      when Symbol
        method = [*invocation].first
        widget.send(handler).method(method)
      when Module
        method, *args = *invocation
        handler.method(method)
      when nil
        method = [*invocation].first
        widget.method(method)
      else
        raise ArgumentError
      end
    end

    def to_a
      [mode, self]
    end
  end

  class Fallback < Action
  end
end
