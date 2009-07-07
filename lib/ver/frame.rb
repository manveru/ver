module VER
  class Frame < Curses::Window
    autoload :Status, 'ver/frame/status'
    autoload :View, 'ver/frame/view'

    def initialize(height = nil, width = nil, left = nil, top = nil)
      super(height.to_i, width.to_i, left.to_i, top.to_i)
    end
  end
end
