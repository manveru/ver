require 'ver/methods/buffer'
require 'ver/methods/movement'
require 'ver/methods/search'
require 'ver/methods/selection'
require 'ver/methods/switch'

module VER
  module Methods
    module Control
      include Switch, Buffer, Movement, Selection, Search
    end
  end
end
