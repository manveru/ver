module VER
  class HelpView < MainView
    attr_reader :topic

    def topic=(name)
      filename = File.join(Config[:help_dir], "#{name}.verh")
      Log.debug :filename => filename
      self.buffer = filename
    end

    def draw
      super
    ensure
      window.refresh
    end

    def activate
      window.show
      window.color_set Color[:white]
      draw
      focus_input
    end

    def deactivate
      window.hide
    end
  end
end
