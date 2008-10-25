module VER
  class View
    class AskFile < View
      LAYOUT = {
        :width => lambda{|w| w },
        :height => lambda{|h| h * 0.8 },
        :top => 0,
        :left => 0
      }

      DEFAULT = {
        :interactive => true,
        :methods => [Methods::Ask, Methods::AskFile],
        :mode => :ask_file
      }

      def initialize(*args)
        super

        @buffer = MemoryBuffer.new(:ask_file)
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
        bg = :white if choice == @pick
        fg = choice[:type] == :dir ? :blue : :green

        window.color = Color[fg, bg]

        window.puts " #{choice[:path]}"
        window.color = Color[:white]
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
        if found = @pick || @choices.first
          if found[:type] == :file
            return found[:path]
          end
        end

        return nil
      end

      def expand_input
        if found = @pick || @choices.first
          buffer[0..-1] = found[:path]
          buffer.cursor.pos = buffer.size
          update_choices
          draw
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
