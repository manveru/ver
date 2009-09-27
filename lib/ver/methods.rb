require 'ver/methods/move'
require 'ver/methods/views'
require 'ver/methods/control'

module VER
  module Methods
    include Move
    include Views
    include Control
  end
end
