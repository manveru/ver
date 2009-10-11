module VER
  module Syntax
    autoload :LIST, 'ver/syntax_list'

    EXT_NAME = {}

    def self.list
      VER.loadpath.map{|path| Dir[(path/'syntax/*.json').to_s] }.flatten
    end

    def self.register(name, *extensions)
      extensions.each{|ext| EXT_NAME[ext] = name }
    end

    def self.from_filename(filename)
      base = filename.basename

      EXT_NAME.each do |ext, name|
        return Highlighter.new(name) if base =~ ext
      end

      ext = filename.extname.downcase

      LIST.each do |name, exts|
        return Highlighter.new(name) if exts.include?(ext)
      end

      Highlighter.new('Plain text')
    end

    def self.find(syntax_name)
      VER.find_in_loadpath("syntax/#{syntax_name}.json")
    end

    def self.load(file)
      raise(ArgumentError, "No path to syntax file given") unless file
      Textpow::SyntaxNode.load(file)
    end

    def self.find_and_load(syntax_name)
      load(find(syntax_name))
    end

    register 'Ruby', /\.rb$/, /^rakefile(\.rb)?$/i
    register 'Haml', /\.haml$/i
    register 'Markdown', /\.mk?d/, /\.markdown/i
    register 'xhtml_1.0', /\.xhtml$/i
    register 'JavaScript', /\.json$/i, /\.js$/i

    class Highlighter
      attr_accessor :syntax, :name
      attr_reader :theme

      def initialize(name, theme = nil)
        @name = name
        @first_highlight = true
        @old_theme = nil

        @syntax = Syntax.find_and_load(name)
        @theme  = theme || Theme.find_and_load(VER.options[:theme])
      end

      def highlight(textarea, code, lineno = 0)
        if @old_theme
          @old_theme.delete_tags_on(textarea)
          @old_theme = nil
        end

        if @first_highlight
          @theme.create_tags_on(textarea)
          @theme.apply_default_on(textarea)
          @first_highlight = false
        else
          @theme.remove_tags_on(textarea)
        end

        pr = Processor.new(textarea, @theme, lineno)

        syntax.parse(code, pr)
      end

      def theme=(theme)
        @old_theme = @theme
        @theme = theme
        @first_highlight = true
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
            if stack.size > 1
              below = theme.get(stack[-2][0])
              textarea.tag_raise(tag_name, below) rescue nil
            end
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
        rescue RuntimeError => exception
          # if you modify near the end of the textarea, sometimes the last tag
          # cannot be closed because the contents of the textarea changed since
          # the last highlight was issued.
          # this will cause Tk to raise an error that doesn't have a message and
          #  is of no major consequences.
          # We swallow that exception to avoid confusion.
          raise exception unless exception.message.empty?
        end
      end
    end
  end
end