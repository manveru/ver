module VER
  class View
    class AskFuzzyFile < AskLarge
      DEFAULT = {
        :interactive => true,
        :methods => [Methods::Ask, Methods::AskFile],
        :mode => :ask_file
      }

      attr_accessor :selection, :choices

      def initialize(name = :ask_fuzzy_file, options = {})
        super

        @finder = FuzzyFileFinder.new
        @prompt = 'Fuzzy File:'
        self.input = ''

        update_choices
      end

      def draw_selected_choice(choice)
        score, path = choice[:score], choice[:highlighted_path]
        window.color = Color[:black, :white]
        window.puts " %d) %-#{window.width}s" % [score * 100, path]
      end

      def draw_choice(choice)
        score, path = choice[:score], choice[:highlighted_path]

        window.color =
          case score
          when 0          ; return
          when 0   ..0.25 ; Color[:red]
          when 0.25..0.75 ; Color[:yellow]
          when 0.75..1    ; Color[:green]
          end

        window.puts " %d) %-#{window.width}s" % [score * 100, path]
      end

      def update_choices
        input = buffer[0..-1]
        format = "[%.2f] %s"

        @choices = @finder.find(input).sort_by{|m| [-m[:score], m[:path]] }
      rescue ::Exception => ex
        VER.error(ex)
        @choices = []
      ensure
        if @choices.size == 1
          @pick = @choices.first
        else
          @pick = nil
        end
      end

      def pick
        @pick || @choices.first
      end
    end
  end
end
