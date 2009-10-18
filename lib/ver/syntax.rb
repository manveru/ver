module VER
  class Syntax
    autoload :Detector,      'ver/syntax/detector'
    autoload :Processor,     'ver/syntax/processor'
    autoload :Engine,        'ver/syntax/engine'
    autoload :Pattern,       'ver/syntax/pattern'
    autoload :Specification, 'ver/syntax/specification'

    def self.list
      VER.loadpath.map{|path| Dir[(path/'syntax/*.json').to_s] }.flatten
    end

    def self.from_filename(filename)
      if syntax_name = Detector.detect(filename)
        return new(syntax_name)
      else
        new 'Plain text'
      end
    end

    def self.find(syntax_name)
      VER.find_in_loadpath("syntax/#{syntax_name}.json")
    end

    def self.load(file)
      raise(ArgumentError, "No path to syntax file given") unless file
      Engine.load(file)
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

      parser.parse(code, pr)
    end

    def theme=(theme)
      @old_theme = @theme
      @theme = theme
      @first_highlight = true
    end
  end
end