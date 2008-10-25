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

      EXECUTE_PROC = lambda{|got|
        methods = View.active.methods.singleton_methods.map{|m| m.to_s }
        choices = methods.grep(/^#{got}/)
        valid = methods.include?(got)
        [valid, choices]
      }

      def execute(command = nil)
        if command
          send(*command.to_s.split)
        else
          VER.ask('Execute: ', EXECUTE_PROC) do |cmd|
            send(*cmd.split) if cmd
            View.active.draw
          end
        end
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

      # FIXME: Ruby is very, very, noisy on invalid regular expressions and may
      #       raise two different errors. the raising we can deal with, but
      #       without closing $stderr the warnings are unstoppable.
      #       So we try to use one of the many hacks from DHH (found in facets)
      SEARCH_PROC = lambda{|got|
        valid = false

        unless got.empty?
          view = View.active

          begin
            silently do
              if got == got.downcase # go case insensitive
                regex = /#{got}/i
              else
                regex = /#{got}/
              end

              cursors = view.buffer.grep_cursors(regex)
              valid = true unless cursors.empty?
              view.highlights = cursors
            end
          rescue RegexpError, SyntaxError => ex
            Log.error(ex)
            View[:ask].draw_exception(ex)
          end

          view.draw
          view.window.refresh
        end

        [valid, [got]]
      }

    end
  end
end

