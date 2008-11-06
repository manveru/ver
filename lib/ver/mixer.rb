module VER
  class Mixer
    attr_accessor :key
    attr_reader :view, :modules

    def initialize(view)
      @view = view
      @key = nil

      extend(view.class::Methods)
    end

    def selection; view.selection end
    def cursor;    view.cursor    end
    def buffer;    view.buffer    end
    def window;    view.window    end
    def methods;   view.methods   end

    def inspect
      "<Mixer for %p>" % [modules]
    end

    def instance_eval(*args, &block)
      super(*args, &block)
    end

    public :instance_eval
  end
end
