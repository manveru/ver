module VER
  class View
    class Complete < AskLarge
      module Methods
        def select_below
          view.select_below
          view.input = view.pick[:string]
        end

        def select_above
          view.select_above
          view.input = view.pick[:string]
        end

        def pick
          if choice = view.pick
            view.close

            range, string = choice[:range], choice[:string]

            View[:file].buffer[range] = string
            View[:file].cursor.pos = (range.begin + string.size)
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

      attr_reader :prompt, :valid, :choices, :block, :history, :what
      attr_accessor :history_pick

      def initialize(*args)
        super
        @buffer = MemoryBuffer.new(:complete)
      end

      def open(what, view)
        @what, @view = what, view
        @prompt, @completer = "Complete #{what}: ", "complete_#{what}"
        @mode = @completer.to_sym
        @pick = nil

        update_choices
        self.input = @chunk
        cursor.pos = @view.cursor.to_x

        window.top = (@view.cursor.to_y + 1)
        window.left = @view.cursor.to_x

        super()

        draw
      end

      # FIXME: this shouldn't be necessary
      def press(key)
        case key
        when 'tab', 'return', 'C-x', 'C-f', 'C-w', 'C-o', 'C-s', 'C-l'
        else
          @view.press(key)
        end

        super
      end

      def draw
        win = @view.window

        @choices ||= []
        want_height = @choices.size

        max = @choices.sort_by{|k,v| -k[:string].size }[0]
        max_choice = max ? max[:string].size : 0

        want_width = @prompt.size + max_choice + 4

        max_height = (win.height - @view.cursor.to_y)
        max_width = win.width - 10

        window.height = [max_height, [want_height, 10].max].min
        window.width  = [max_width,  [want_width,  20].max].min
        window.resize

        super
      end

      def pick
        @pick || @choices[1..-1].first
      end

      def complete_line
      end

      def complete_word
      end

      def complete_omni
      end

      def update_choices
        @choices = []

        pos = @view.cursor.pos

        @chunk, choices, skip = @view.methods.send(@completer)

        if skip
          @choices = choices
        else
          chunk_size = @chunk.size

          choices.each do |choice|
            range = ((pos - chunk_size)...pos)
            @choices << {:string => choice, :range => range}
          end
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
