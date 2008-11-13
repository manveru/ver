module VER
  class View
    class Complete < AskLarge
      module Methods
        def pick
          if choice = view.pick
            view.close
            View[:file].buffer[choice[:range]] = choice[:string]
            View[:file].cursor.pos = choice[:range].end
            View[:file].open
          end
        end
      end

      LAYOUT = {
        :width => lambda{|w| w },
        :height => 20,
        :top => 0,
        :left => 0
      }

      DEFAULT = {
        :interactive => true,
        :mode        => :complete
      }

      attr_reader :prompt, :valid, :choices, :block, :history
      attr_accessor :history_pick

      def initialize(*args)
        super
        @buffer = MemoryBuffer.new(:complete)
      end

      def open(prompt, completer, view)
        @prompt, @completer, @view = prompt, completer, view
        @pick = nil
        @buffer.clear

        window.top = (@view.cursor.to_y + 1)
        window.left = @view.cursor.to_x
        window.resize

        update_choices
        self.input = @choices.first[:string]

        super()

        draw
      end

      def pick
        @pick || @choices[1..-1].first
      end

      def update_choices
        @choices = []
        pos = @view.cursor.pos

        chunk, choices = @view.methods.send(@completer)
        chunk_size = chunk.size

        choices.each do |choice|
          range = ((pos - chunk_size)...pos)
          @choices << {:string => choice, :range => range}
        end
      end

      def draw_choice(choice)
        window.color = Color[:white]
        window.puts " #{choice[:string]}"
      end

      def draw_selected_choice(choice)
        window.color = Color[:blue]
        window.puts " #{choice[:string]}"
      end
    end
  end
end
