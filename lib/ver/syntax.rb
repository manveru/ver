module VER
  class Syntax
    autoload :Detector, 'ver/syntax/detector'
    autoload :Processor, 'ver/syntax/processor'

    def self.list
      VER.loadpath.map{|path| Dir[(path/'syntax/*.rb').to_s] }.flatten
    end

    def self.from_filename(filename)
      if syntax_name = Detector.detect(filename)
        return new(syntax_name)
      else
        new(VER.options.filetype)
      end
    end

    def self.find(syntax_name)
      VER.find_in_loadpath("syntax/#{syntax_name}.rb")
    end

    def self.load(file)
      raise(ArgumentError, "No path to syntax file given") unless file
      Textpow::SyntaxNode.load(file)
    end

    def self.find_and_load(syntax_name)
      load(find(syntax_name))
    end

    attr_accessor :parser, :name
    attr_reader :theme

    def initialize(name, theme = nil)
      @name = name
      @first_highlight = true
      @old_theme = nil

      @parser = self.class.find_and_load(name)
      @theme  = theme || Theme.find_and_load(VER.options[:theme])
    end

    def highlight(widget, lineno, from, to)
      check_for_theme_change(widget)

      processor = Processor.new(widget, @theme, lineno)
      @theme.remove_tags_on(widget, from, to)
      code = widget.get(from, to)
      parser.parse(code, processor)
    end

    def check_for_theme_change(widget)
      if @old_theme
        @old_theme.delete_tags_on(widget)
        @old_theme = nil
      end

      if @first_highlight
        @theme.create_tags_on(widget)
        @theme.apply_default_on(widget)
        @first_highlight = false
      end
    end

    def theme=(theme)
      @old_theme = @theme
      @theme = theme
      @first_highlight = true
    end
  end
end
