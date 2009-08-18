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

      class Processor < Struct.new(:textarea, :theme, :lineno, :stack)
        def start_parsing(name)
          self.lineno = 0
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
          sname, pos = stack.pop

          if name == sname
            if tag_name = theme.get(name)
              textarea.tag_add(tag_name, "#{lineno}.#{pos}", "#{lineno}.#{mark}")
            else
              p name
            end
          else
            warn("Nesting mismatch: #{name} != #{sname}")
          end
        end
      end

      def highlight(textarea, code)
        theme = Theme::Murphy
        theme.apply_config(textarea)

        theme.colors.each do |name, options|
          textarea.tag_delete name.to_s
          TktNamedTag.new(textarea, name.to_s, options)
        end

        pr = Processor.new(textarea, theme)

        syntax.parse(code, pr)
      end
    end
  end
end
