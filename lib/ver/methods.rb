require 'ver/methods/move'
require 'ver/methods/views'
require 'ver/methods/insert'
require 'ver/methods/control'
require 'ver/methods/search'
require 'ver/methods/select'
require 'ver/methods/completion'

module VER
  module Methods
    include Move
    include Views
    include Insert
    include Control
    include Search
    include Select
    include Completion
  end
end
