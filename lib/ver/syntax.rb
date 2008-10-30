module VER
  module Syntax
    LIST = {}

    def self.[](key)
      LIST[key]
    end

    def self.[]=(key, value)
      LIST[key] = value
    end

    def self.register(mod, *exts)
      exts.each{|ext| LIST[ext] = mod }
    end

    def self.find(filename)
      return unless filename.respond_to?(:to_str)

      filename = File.basename(filename.to_str)

      LIST.each do |key, mod|
        return mod.new if filename =~ key
      end

      return nil
    end

    require 'ver/syntax/ruby'
    register Ruby, /\.rb$/, /^Rakefile$/
  end
end
