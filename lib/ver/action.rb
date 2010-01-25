module VER
  class Action < Struct.new(:receiver, :method, :args, :block)
    def initialize(receiver = nil, method = nil, args = [], &block)
      self.receiver = receiver
      self.method = method || :call
      self.args = args
      self.block = block
    end

    def call(widget, *given_args)
      receiver = self.receiver || widget
      # puts "%p.send(%p, %p, *%p, *%p)" % [receiver, method, widget, args, given_args]
      receiver.send(method, widget, *args, *given_args)
    end

    def combine(action)
      new_args = [*args, action].compact
      self.class.new(receiver, method, new_args, &block)
    end
  end
end
