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

    def highlight(textarea, code, lineno = nil, from = '1.0', to = 'end')
      multi_lineno = 0
      single_lineno = lineno

      if @old_theme
        @old_theme.delete_tags_on(textarea)
        @old_theme = nil
      end

      if @first_highlight
        @theme.create_tags_on(textarea)
        @theme.apply_default_on(textarea)
        @first_highlight = false
      else
        outer_tags = textarea.tag_names(from) | textarea.tag_names(to)

        if outer_tags.empty?
          @theme.remove_tags_on(textarea, from, to)
        else
          outer_tags.each do |tag|
            range = textarea.tag_prevrange(tag, from)
            range = textarea.tag_nextrange(tag, from) if range.empty?
            prev_from, prev_to = range.map{|t| Text::Index.new(textarea, t) }
            from = prev_from if !from || from > prev_from
            to = prev_to if !to || to < prev_to
          end
          from = textarea.index("#{from} - 1 chars")
          to = textarea.index("#{to} + 1 chars")

          single_lineno = nil
          multi_lineno = from.y - 1
          code = textarea.get(from, to)
        end
      end

      pr = Processor.new(textarea, @theme, single_lineno || multi_lineno)

      if single_lineno
        pr.start_parsing(parser.scopeName)
        stack = [[parser, nil]]
        parser.parse_line(stack, code, pr)
        pr.end_parsing(parser.scopeName)
      else
        @theme.remove_tags_on(textarea, from, to)
        parser.parse(code, pr)
      end
    end

    def theme=(theme)
      @old_theme = @theme
      @theme = theme
      @first_highlight = true
    end
  end
end
