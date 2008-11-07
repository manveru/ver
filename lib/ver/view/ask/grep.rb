module VER
  class View
    class AskGrep < AskLarge
      module Methods
        def pick
          if choice = view.pick
            view.close
            file = View[:file]
            file.buffer = choice[:file]
            file.cursor = choice[:cursor]
            file.cursor.buffer = file.buffer
            file.open
          end
        end
      end

      DEFAULT = {
        :interactive => true,
        :mode => :ask_grep,
      }

      def initialize(name = :ask_grep, options = {})
        super

        @buffer = MemoryBuffer.new(:ask_grep)
        @prompt = 'Grep [glob] pattern:'
        self.input = '*'
        update_choices
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
        input = buffer.to_s

        @pick = nil
        @choices = []

        input, query = input.split(/ /, 2)
        input, query = nil, input unless query
        input ||= '*'

        return if query.size < 3 # protect a little

        regex = /#{Regexp.escape(query)}/

        files = Dir[input].select{|f| ::File.file?(f) }

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
    end
  end
end
