require 'ver/methods/completion'
require 'ver/methods/control'
require 'ver/methods/ctags'
require 'ver/methods/delete'
require 'ver/methods/help'
require 'ver/methods/insert'
require 'ver/methods/move'
require 'ver/methods/open'
require 'ver/methods/preview'
require 'ver/methods/save'
require 'ver/methods/search'
require 'ver/methods/select'
require 'ver/methods/views'
require 'ver/methods/shortcuts'

module VER
  module Methods
    include Completion
    include Control
    include Ctags
    include Delete
    include Help
    include Insert
    include Move
    include Open
    include Preview
    include Save
    include Search
    include Select
    include Shortcuts
    include Views
  end
end
