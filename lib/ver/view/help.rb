require 'ver/action/help'

module VER
  class HelpView < View
    def draw
      @window.printw('help')
    end

    def topic(name)
      self.buffer = File.join(HELP_DIR, "#{name}.verh")
      View[:main].hide_window
      show_window
    end
  end
end
