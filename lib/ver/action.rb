module VER
  class Action < Struct.new(:receiver, :method, :args, :block)
    def initialize(receiver = nil, method = nil, args = [], &block)
      self.receiver = receiver
      self.method = method || :call
      self.args = args
      self.block = block
    end

    def call(*args)
      if receiver
        receiver.__send__(method, *args)
      else
        block.__send__(method, *args)
      end
    end

    def merge(action)
      new_args = [*args, action].compact
      self.class.new(receiver, method, new_args, &block)
    end
  end
end
