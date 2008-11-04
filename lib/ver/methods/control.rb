require 'ver/methods/buffer'
require 'ver/methods/movement'
require 'ver/methods/search'
require 'ver/methods/selection'
require 'ver/methods/switch'

module VER
  module Methods
    module Control
      include Switch, Buffer, Movement, Selection, Search

      def ask_grep
        ask_grep = View::AskGrep.new(:ask_grep)

        if view.buffer.respond_to?(:filename)
          ask_grep.glob = view.buffer.filename
        end
        ask_grep.open
      end

      # FIXME: don't assume View[:file]
      EXECUTE_PROC = lambda{|got|
        methods = View[:file].methods.singleton_methods.map{|m| m.to_s }
        regex = /#{Regexp.escape(got.split.first)}/
        choices = methods.grep(regex)
        valid = choices.size == 1
        [valid, choices]
      }

      def execute(command = nil)
        if command
          send(*command.to_s.split)
        else
          ask_execute
        end
      rescue ::Exception => ex
        VER.error(ex)
      end

      def ask_execute
        VER.ask('Execute: ', EXECUTE_PROC) do |cmd|
          send(*cmd.split) if cmd
        end
      end
    end
  end
end
