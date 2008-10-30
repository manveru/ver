require 'ver/methods/insert'
require 'ver/methods/control'

module VER
  module Methods
    module File
      include Control, Insert

      def show_help
        VER.help
      end

      def show_doc
        VER.doc(/left/)
      end

      # TODO: use irbs completion proc?
      RUBY_FILTER_PROC = lambda{|got| }

      def ruby_filter
        VER.ask('Ruby filter: text.', RUBY_FILTER_PROC) do |ruby|
        end
      end

      ASK_HELP_PROC = lambda{|got| }

      def ask_help
        VER.ask('Help: ', HELP_PROC) do |topic|
          VER.help(topic)
        end
      end

      ASK_DOC_PROC = lambda{|got|
        [true, []]
      }

      def ask_doc
        VER.ask('Method: ', ASK_DOC_PROC) do |name|
          VER.doc(/#{name}/)
        end
      end
    end
  end
end

