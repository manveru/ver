module VER
  module Syntax
    autoload :LIST, 'ver/syntax_list'

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

      ext = File.extname(base).downcase

      LIST.each do |name, exts|
        return Common.new(name) if exts.include?(ext)
      end

      return nil
    end

    register 'Ruby', /\.rb$/, /^rakefile(\.rb)?$/i
    register 'Haml', /\.haml$/
    register 'Markdown', /\.mk?d/, /\.markdown/i
    register 'xhtml_1.0', /\.xhtml/

    class Common
      attr_reader :syntax, :name

      def initialize(name)
        @name = name
        file = ::File.expand_path("../syntax/#{name}.json", __FILE__)
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

          if tag_name = theme.get(name)
            textarea.tag_raise(tag_name) rescue nil
          end
        end

        def close_tag(name, mark)
          sname, pos = stack.pop

          if name == sname
            if tag_name = theme.get(name)
              textarea.tag_add(tag_name, "#{lineno}.#{pos}", "#{lineno}.#{mark}")
            else
              textarea.tag_add(name, "#{lineno}.#{pos}", "#{lineno}.#{mark}")
            end
          else
            warn("Nesting mismatch: %p != %p" % [name, sname])
          end
        end
      end

      def highlight(textarea, code)
        theme_name = File.expand_path("../theme/Espresso Libre.json", __FILE__)
        theme = Theme.load(theme_name)
        theme.apply_default_on(textarea)

        theme.colors.each do |name, options|
          name = name.to_s
          textarea.tag_delete(name)
          TktNamedTag.new(textarea, name, options)
        end

        pr = Processor.new(textarea, theme)

        syntax.parse(code, pr)
      end
    end
  end
end
