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
        :width => 0, :height => 0, :top => 0, :left => 0
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
        @prompt, @completer = "Complete #{what}:", "complete_#{what}"
        @mode = @completer.to_sym

        update_choices
        @pick = @choices.first
        self.input = @pick ? @pick.dup[:string] : ''
        cursor.pos = self.input.size

        draw # make sure the size is correct
        super()
        draw # draw for real
      end

      def close
        View[:file].mode = :insert
        super
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

      def cast_box(want_height, want_width)
        win = @view.window

        left = @view.cursor.to_x
        top  = ((@view.cursor.to_y + 1) - @view.top)

        possible_height = (@view.window.height - top) - 3
        height = [possible_height, want_height].min + 3

        possible_width = (@view.window.width - left)
        width = [possible_width, want_width].min

        confines = { :left => left, :width => width, :top => top, :height => height }
        return confines
      end

      def draw
        @choices ||= []

        max = @choices.sort_by{|k,v| -k[:string].size }[0]
        max_choice = max ? max[:string].size : 0
        input_width = @prompt.size + max_choice + 4

        want_width = [input_width, max_choice].max
        want_height = @choices.size

        confines = cast_box(want_height, want_width)
        window.resize_with(confines)

        super
      end

      def pick
        @pick || @choices[1..-1].first
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
        window.puts "  #{choice[:string]}"
      end

      def draw_selected_choice(choice)
        window.color = Color[:blue]
        window.puts "  #{choice[:string]}"
      end
    end
  end
end
