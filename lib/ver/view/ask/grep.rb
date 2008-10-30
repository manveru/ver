module VER
  class View
    class AskGrep < AskLarge
      DEFAULT = {
        :interactive => true,
        :methods => [Methods::Ask, Methods::AskGrep],
        :mode => :ask_grep
      }

      def initialize(*args)
        super

        @buffer = MemoryBuffer.new(:ask_grep)
        @prompt = 'Grep [glob] pattern:'
        self.glob = '*'
        update_choices
      end

      def glob=(string)
        buffer[0..-1] = string
        buffer.cursor.pos = buffer.size
      end

      # TODO: natural scrolling
      def draw
        window.move 1, 1
        window.puts "#{@prompt} #{buffer}"
        window.color = Color[:white]

        current = @choices.index(@pick) || 0
        from = 0
        to = from + window.height
        delta = current - (window.height - 6)

        if delta > 1
          from += delta
          to += delta
        end

        @choices[from...to].each do |choice|
          if choice == @pick
            draw_selected_choice(choice)
          else
            draw_choice(choice)
          end
        end

        draw_padding
        window.move 1, (cursor.pos + @prompt.size + 2)
        window.color = Color[:white]
        window.box ?|, ?-
      end

      def draw_choice(choice)
        window.puts " #{choice[:file]}(#{choice[:cursor].to_range}) : #{choice[:line]}"
      end

      def draw_selected_choice(choice)
        window.color = Color[:white, :blue]
        window.puts " #{choice[:file]}(#{choice[:cursor].to_range}) : #{choice[:line]}"
        window.color = Color[:white]
      end

      # TODO: make this more performant
      def update_choices
        Log.debug :update
        input = buffer.to_s

        @pick = nil
        @choices = []

        glob, query = input.split(/ /, 2)
        glob, query = nil, glob unless query
        glob ||= '*'

        return if query.size < 3 # protect a little

        regex = /#{Regexp.escape(query)}/

        files = Dir[glob].select{|f| ::File.file?(f) }

        files.each do |file|
          buffer = FileBuffer.new(:temp, file)
          buffer.grep_cursors(regex).each do |cursor|
            line = buffer[cursor.bol...cursor.eol]
            @choices << {:file => file, :cursor => cursor, :line => line}
          end
        end
      end

      def pick
        @pick || @choices.first
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
