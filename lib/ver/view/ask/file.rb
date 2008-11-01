module VER
  class View
    class AskFile < AskLarge
      DEFAULT = {
        :interactive => true,
        :methods => [Methods::Ask, Methods::AskFile],
        :mode => :ask_file
      }

      def initialize(*args)
        super

        @prompt = 'File:'
        self.input = ''
        update_choices
      end

      def draw_selected_choice(choice)
        window.color = Color[:black, :white]
        window.puts " #{choice[:path]}"
      end

      def draw_choice(choice)
        fg = choice[:type] == :dir ? :blue : :green

        window.color = Color[fg]

        window.puts " #{choice[:path]}"
      end

      def update_choices
        input = buffer[0..-1]

        @pick = nil
        @choices = []

        input = ::File.expand_path(input)
        input << '/' if ::File.directory?(input)
        input.squeeze!('/')

        Dir["#{input}*"].each do |path|
          stat = ::File.stat(path)

          path.gsub!(::File.expand_path('~'), '~')
          this = {:path => path}

          if stat.directory?
            this[:type] = :dir
            path << '/'
          elsif stat.file?
            this[:type] = :file
          end

          @choices << this
        end
      end

      def pick
        @pick || @choices.first
      end

      # FIXME: only expand as much as reasonable
      def expand_input
        if found = @pick
          buffer[0..-1] = found[:path]
          buffer.cursor.pos = buffer.size
          update_choices
          draw
        end
      end
    end
  end
end
