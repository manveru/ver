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
  end
end
