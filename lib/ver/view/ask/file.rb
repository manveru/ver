module VER
  class View
    class AskFile < AskLarge
      module Methods
        def pick
          if choice = view.pick
            view.close
            View[:file].buffer = choice[:path]
            View[:file].open
          end
        end
      end

      DEFAULT = {
        :interactive => true,
        :mode => :ask_file,
      }

      def initialize(name = :ask_file, options = {})
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

        glob = ::File.expand_path(input)
        is_dir = ::File.directory?(glob)

        if is_dir and input[-1,1] == '/'
          glob = "#{glob}/*"
        elsif is_dir
          glob = "{#{glob},#{glob}/}*"
        else
          glob = "#{glob}*"
        end

        Dir[glob].each do |path|
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

      def expand_input
        if found = @pick
          self.input = found[:path]
          draw
        elsif @choices.size == 1
          self.input = @choices.first[:path]
          draw
        elsif @choices.size > 1
          choices = @choices.map{|c| c[:path]}
          self.input = choices.abbrev.keys.sort_by{|k| k.size }[0][0..-2]
        end
      end
    end
  end
end
