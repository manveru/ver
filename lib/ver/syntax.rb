module VER
  module Syntax
    LIST = {}

    def self.[](key)
      LIST[key]
    end

    def self.[]=(key, value)
      LIST[key] = value
    end

    require 'ver/syntax/ruby'
    LIST[:ruby] = Ruby
  end
end
