module Textpow
  class Processor
    def start_parsing(name)
    end

    def end_parsing(name)
    end

    def new_line(line)
    end

    def open_tag(name, pos)
    end

    def close_tag(name, mark)
    end
  end

  class SyntaxProxy
    def initialize proxy, syntax
      @proxy, @syntax = proxy, syntax
    end

    def method_missing(method, *args, &block)
      if @proxy
        @proxy_value = proxy unless @proxy_value

        if @proxy_value
          @proxy_value.send(method, *args, &block)
        else
          warn "Failed proxying #{@proxy}.#{method}(#{args.join(', ')})"
        end
      else
        super
      end
    end

    def proxy
      case @proxy
      when /^#(?<proxy>.+)/
        return unless @syntax.repository
        @syntax.repository[$~[:proxy]]
      when "$self", "$base"
        @syntax
      else
        @syntax.syntaxes[@proxy]
      end
    end
  end

  class SyntaxNode
    OPTIONS = {} #:options => Oniguruma::OPTION_CAPTURE_GROUP}

    @@syntaxes = {}

    attr_accessor :processor, :syntax, :firstLineMatch, :foldingStartMarker,
      :foldingStopMarker, :match, :begin, :content, :fileTypes, :name,
      :contentName, :end, :scopeName, :keyEquivalent, :captures,
      :beginCaptures, :endCaptures, :repository, :patterns

    def self.load(filename, name_space = :default)
      table =
        case filename
        when /(\.tmSyntax|\.plist)$/
          Plist::parse_xml(filename)
        when /\.json$/i
          JSON.load(File.read(filename))
        when /\.ya?ml$/i
          YAML.load_file(filename)
        else
          raise ArgumentError, "Unknown filename extension"
        end

      SyntaxNode.new(table, nil, name_space) if table
    end

    def initialize(hash, syntax = nil, name_space = :default)
      @name_space = name_space

      prepare_scope_name(hash['scopeName'])

      @syntax = syntax || self

      hash.each do |key, value|
        case key
        when "firstLineMatch", "foldingStartMarker", "foldingStopMarker", "match", "begin"
          begin
            send("#{key}=", Regexp.new(value))
          rescue ArgumentError => exception
            raise ParsingError, "Parsing error in #{value}: #{exception}"
          end
        when "content", "fileTypes", "name", "contentName", "end", "scopeName", "keyEquivalent"
          send("#{key}=", value)
        when "captures", "beginCaptures", "endCaptures"
          send("#{key}=", value.sort)
        when "repository"
          parse_repository value
        when "patterns"
          create_children value
        else
          STDERR.puts "Ignoring: #{key} => #{value.gsub("\n", "\n>>")}" if $DEBUG
        end
      end
    end

    def prepare_scope_name(scopeName)
      @@syntaxes[@name_space] ||= {}

      return unless scopeName

      @@syntaxes[@name_space][scopeName] = self
    end

    def syntaxes
      @@syntaxes[@name_space]
    end

    def parse(string, processor = Processor.new)
      processor.start_parsing scopeName

      stack = [[self, nil]]
      string.each_line do |line|
        parse_line(stack, line, processor)
      end

      processor.end_parsing self.scopeName
      processor
    end

    def parse_repository(repository)
      @repository = {}

      repository.each do |key, value|
        if include = value["include"]
          @repository[key] = SyntaxProxy.new(include, self.syntax)
        else
          @repository[key] = SyntaxNode.new(value, self.syntax, @name_space)
        end
      end
    end

    def create_children(patterns)
      @patterns = []
      syntax = self.syntax

      patterns.each do |pattern|
        if include = pattern["include"]
          @patterns << SyntaxProxy.new(include, syntax)
        else
          @patterns << SyntaxNode.new(pattern, syntax, @name_space)
        end
      end
    end

    def parse_captures(name, pattern, match, processor)
      all_starts = []
      all_ends = []

      pattern.match_captures(name, match).each do |group, range, name|
        range_first = range.first
        next unless range_first

        range_last = range.last
        next if range_first == range_last

        all_starts << [range_first, group, name]
        all_ends   << [range_last, -group, name]
      end

      starts = all_starts.sort.reverse
      ends = all_ends.sort.reverse

      until starts.empty? && ends.empty?
        if starts.empty?
          pos, key, name = ends.pop
          processor.close_tag name, pos
        elsif ends.empty?
          pos, key, name = starts.pop
          processor.open_tag name, pos
        elsif ends.last[1].abs < starts.last[1]
          pos, key, name = ends.pop
          processor.close_tag name, pos
        else
          pos, key, name = starts.pop
          processor.open_tag name, pos
        end
      end
    end

    def match_captures(name, match)
      matches = []

      if captures = send(name)
        captures.each do |key, value|
          if key =~ /^\d*$/
            key = key.to_i
            matches << [key, match.offset(key), value["name"]] if key < match.size
          else
            key = key.to_sym
            match_to_key = match.to_index(key)
            matches << [match_to_key, match.offset(key), value["name"]] if match_to_key
          end
        end
      end

      matches
    end

    def match_first(string, position)
      if self.match
        if match = self.match.match(string, position)
          return [self, match]
        end
      elsif self_begin = self.begin
        if match = self_begin.match(string, position)
          return [self, match]
        end
      elsif self.end
      else
        return match_first_son(string, position)
      end

      nil
    end

    def match_end(string, match, position)
      regstring = self.end.clone
      regstring.gsub!(/\\([1-9])/){ match[$1.to_i] }
      regstring.gsub!(/\\k<(.*?)>/){ match[$1.to_sym] }
      Regexp.new(regstring).match(string, position)
    end

    def match_first_son(string, position)
      match = nil

      if patterns
        patterns.each do |pattern|
          tmatch = pattern.match_first(string, position)
          next unless tmatch
          if !match || match[1].offset(0).first > tmatch[1].offset(0).first
            match = tmatch
          end
        end
      end

      match
    end

    def parse_line(stack, line, processor)
      processor.new_line(line)
      top, match = stack.last
      position = 0

      while true
        if top.patterns
          pattern, pattern_match = top.match_first_son(line, position)
        else
          pattern, pattern_match = nil
        end

        end_match = nil

        if top.end
          end_match = top.match_end( line, match, position)
        end

        if end_match && ( !pattern_match || pattern_match.offset(0).first >= end_match.offset(0).first )
          pattern_match = end_match
          pattern_match_first_offset = pattern_match.offset(0)
          start_pos = pattern_match_first_offset.first
          end_pos = pattern_match_first_offset.last

          if processor
            top_contentName = top.contentName
            processor.close_tag top_contentName, start_pos if top_contentName

            parse_captures "captures", top, pattern_match, processor
            parse_captures "endCaptures", top, pattern_match, processor

            top_name = top.name
            processor.close_tag top_name, end_pos if top_name
          end

          stack.pop
          top, match = stack.last
        else
          break unless pattern

          start_pos = pattern_match.offset(0).first
          end_pos = pattern_match.offset(0).last
          pattern_name = pattern.name

          if pattern.begin
            if processor
              processor.open_tag pattern_name, start_pos if pattern_name
              parse_captures "captures", pattern, pattern_match, processor
              parse_captures "beginCaptures", pattern, pattern_match, processor

              pattern_contentName = pattern.contentName
              processor.open_tag pattern_contentName, end_pos if pattern_contentName
            end

            top = pattern
            match = pattern_match
            stack << [top, match]
          elsif pattern.match and processor
            processor.open_tag pattern_name, start_pos if pattern_name
            parse_captures "captures", pattern, pattern_match, processor
            processor.close_tag pattern_name, end_pos if pattern_name
          end
        end

        position = end_pos
      end
    end
  end
end
