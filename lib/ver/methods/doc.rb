module VER
  module Methods
    module Doc
      include Switch

      def buffer_close(buffer = nil)
        view.deactivate
      end

      def buffer_open
        view.deactivate
      end

      def view_close
        View.active = View[:main]
      end

      SEARCH_PROC = lambda{|got|
        regex = Regexp.escape(got)
        found = View[:doc].query(/#{regex}/)

        if found.size > 1
          choices = found.map{|file, name, doc|
            file = File.basename(file)
            "#{name}:#{file}"
            name
          }
        else
          choices = []
        end

        if choices.size == 1
          [true, choices]
        else
          [true, choices]
        end
      }

      def doc_grep
        VER.ask('Doc grep: ', SEARCH_PROC) do |query|
          return unless query
          escape = Regexp.escape(query)
          view.show(/#{escape}/)
        end
      end
    end
  end
end
