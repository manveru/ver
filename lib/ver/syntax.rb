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
        return Highlighter.new(name) if base =~ ext
      end

      ext = File.extname(base).downcase

      LIST.each do |name, exts|
        return Highlighter.new(name) if exts.include?(ext)
      end

      Highlighter.new('Plain text')
    end

    register 'Ruby', /\.rb$/, /^rakefile(\.rb)?$/i
    register 'Haml', /\.haml$/
    register 'Markdown', /\.mk?d/, /\.markdown/i
    register 'xhtml_1.0', /\.xhtml/

    class Highlighter
      attr_reader :syntax, :name, :theme

      def initialize(name)
        @name = name
        @first_highlight = true

        syntax = ::File.expand_path("../syntax/#{name}.json", __FILE__)
        @syntax = Textpow::SyntaxNode.load(syntax)

        theme = File.expand_path("../theme/Espresso Libre.json", __FILE__)
        @theme = Theme.load(theme)
      end

      def highlight(textarea, code, lineno = 0)
        if @first_highlight
          create_tags(textarea)
          @theme.apply_default_on(textarea)
        else
          remove_tags(textarea)
        end

        pr = Processor.new(textarea, @theme, lineno)

        syntax.parse(code, pr)
      end

      def create_tags(textarea)
        @theme.colors.each do |name, options|
          TktNamedTag.new(textarea, name.to_s, options)
        end

        @first_highlight = false
      end

      def remove_tags(textarea)
        @theme.colors.each do |name, options|
          textarea.tag_remove(name.to_s, '0.0', 'end')
        end
      end

      class Processor < Struct.new(:textarea, :theme, :lineno, :stack)
        def start_parsing(name)
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
    end
  end
end
