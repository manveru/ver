require 'ver/methods/completion'
require 'ver/methods/control'
require 'ver/methods/delete'
require 'ver/methods/insert'
require 'ver/methods/move'
require 'ver/methods/search'
require 'ver/methods/select'
require 'ver/methods/views'

module VER
  module Methods
    include Completion
    include Control
    include Delete
    include Insert
    include Move
    include Search
    include Select
    include Views
  end
end
