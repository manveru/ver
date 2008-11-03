module VER
  class View
    class AskGrep < AskLarge
      Methods = AskFile::Methods

      DEFAULT = {
        :interactive => true,
        :mode => :ask_grep,
      }

      def initialize(name = :ask_grep, options = {})
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
    end
  end
end
