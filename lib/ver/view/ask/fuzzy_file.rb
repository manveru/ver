module VER
  class View
    class AskFuzzyFile < AskLarge
      DEFAULT = {
        :interactive => true,
        :methods => [Methods::Ask, Methods::AskFile],
        :mode => :ask_file
      }

      attr_accessor :selection, :choices

      def initialize(*args)
        super
        @buffer = MemoryBuffer.new(:ask_file, '')
        @finder = FuzzyFileFinder.new

        update_choices
      end

      def draw
        line = "File: #{buffer[0..-1]}"

        window.move 1, 1
        window.puts line

        @choices[0...window.height].each do |choice|
          draw_choice(choice)
        end

        draw_padding

        window.move 1, line.size + 1
        window.color = Color[:white]
        window.box ?|, ?-
      end

      def draw_choice(choice)
        score, path = choice[:score], choice[:highlighted_path]

        color =
          case score
          when 0          ; return
          when 0   ..0.25 ; :red
          when 0.25..0.75 ; :yellow
          when 0.75..1    ; :green
          end

        if choice == @pick
          window.color = Color[color, :white]
        else
          window.color = Color[color]
        end

        window.puts " %d) %-#{window.width}s" % [score * 100, path]
      end

      def update_choices
        input = buffer[0..-1]
        format = "[%.2f] %s"

        @choices = @finder.find(input).sort_by{|m| [-m[:score], m[:path]] }
      rescue Object => ex
        VER.error(ex)
        @choices = []
      ensure
        @pick = nil
      end

      def pick
        if found = (@pick || @choices.first)
          found[:path]
        end
      end

      def select_above
        if idx = @choices.index(@pick)
          @pick = @choices[idx - 1]
        end

        @pick ||= @choices[0]
      end

      def select_below
        if idx = @choices.index(@pick)
          @pick = @choices[idx + 1]
        end

        @pick ||= @choices[0]
      end
    end
  end
end
