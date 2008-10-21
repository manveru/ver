module VER
  class Exception < StandardError; end
  class CancelAction < Exception; end
  class ActionError < Exception; end
end
