module VER
  module Syntax
    EXT_NAME = {}

    def self.register(name, *extensions)
      extensions.each{|ext| EXT_NAME[ext] = name }
    end

    def self.from_filename(filename)
      return unless filename.respond_to?(:to_str)

      base = File.basename(filename.to_str)

      EXT_NAME.each do |ext, name|
        return Common.new(name) if base =~ ext
      end

      return nil
    end

    register :ruby, /\.rb$/, /^rakefile(\.rb)?$/i
    register :haml, /\.haml$/
    register :markdown, /\.mk?d/, /\.markdown/i

    class Common
      attr_reader :syntax, :name

      def initialize(name)
        @name = name
        file = ::File.expand_path("../syntax/#{name}.syntax", __FILE__)
        @syntax = Textpow::SyntaxNode.load(file)
      end

      class Processor < Struct.new(:window, :buffer, :theme, :lineno, :stack)
        def initialize(window, buffer, theme)
          self.buffer, self.window, self.theme =
            buffer, window, theme
        end

        def color(name)
          theme[name]
        end

        def start_parsing(name)
          self.lineno = -1
          self.stack = []
        end

        def end_parsing(name)
          stack.clear
        end

        def new_line(line)
          self.lineno += 1
        end

        def open_tag(name, pos)
          stack << [name, pos]
        end

        def close_tag(name, mark)
          if color(name) != Color[:white]
            # VER.warn [color(name), lineno - 1, @pos, mark]
          end

          sname, pos = stack.pop

          if name == sname
            window.highlight_line(color(name), lineno, pos, mark - pos)
          else
            VER.warn("Nesting mismatch: #{name} != #{sname}")
          end
        end
      end

      def highlight(view, top, bottom)
        require 'ver/theme/murphy'
        theme = Theme::Murphy
        pr = Processor.new(view.window, view.buffer, theme)
        code = view.buffer[top..bottom]

        syntax.parse(code, pr)
      end
    end
  end
end
