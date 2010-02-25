module VER
  class Action < Struct.new(:receiver, :method, :args, :block, :last)
    def initialize(receiver = nil, method = nil, args = [], &block)
      self.receiver = receiver
      self.method = method || :call
      self.args = args
      self.block = block
      self.last = [self.receiver, self.method, self.args]
    end

    def call(widget, *given_args)
      args = [*self.args, *given_args]

      Tracer.on if VER.options.tracer
      if receiver = self.receiver
        self.last = [receiver, method, widget.tk_pathname, args]
        receiver.send(method, widget, *args)
      elsif receiver = widget
        if widget.respond_to?(:event)
          self.last = [widget.tk_pathname, method, widget.event, args]
          widget.send(method, widget.event, *args)
        else
          self.last = [widget.tk_pathname, method, widget, args]
          widget.send(method, widget, *args)
        end
      end
    rescue => ex
      puts self
      pp ex, ex.backtrace
    ensure
      Tracer.off if VER.options.tracer
    end

    def combine(action)
      new_args = [*args, action].compact
      self.class.new(receiver, method, new_args, &block)
    end

    def to_s
      receiver, method, widget, *args = last
      joined = [widget, *args.map{|arg| arg.inspect }].compact.join(' ')

      "%s.%s(%s)" % [receiver, method, joined]
    end
  end
end
