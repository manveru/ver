module VER
  class Mixer
    attr_accessor :key
    attr_reader :view, :modules

    def initialize(view, *modules)
      @view, @modules = view, modules
      @key = nil

      modules.each{|mod| extend(mod) }
    end

    def mode
      view.mode
    end

    def cursor
      view.cursor
    end

    def window
      view.window
    end

    def buffer
      view.buffer
    end

    def inspect
      "<Mixer for %p>" % [modules]
    end
  end
end
