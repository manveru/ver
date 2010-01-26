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

      if receiver = self.receiver
        self.last = [receiver, method, widget.tk_pathname, args]
        receiver.send(method, widget, *args)
      else receiver = widget
        self.last = [widget.tk_pathname, method, widget.event, args]
        widget.send(method, widget.event, *args)
      end
    rescue => ex
      puts self
      pp ex, ex.backtrace
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
