# (The MIT License)
#
# Copyright (c) 2007 Dizan Vasquez
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# 'Software'), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Copyright (c) 2009 Michael Fellinger
#
# Textpow is the underlying library for the UltraViolet syntax-highlighting engine.
# It appears to be under MIT license, at least that is the only license I could find.
#
# So I simply included it into VER and modified it to:
#  * Work faster and more efficient
#  * Use the builtin Nokogiri capabilities of Ruby 1.9
#  * Parse Plists with Nokogiri.
#
# There is no dependency on Nokogiri in VER itself, as we ship the converted
# files as JSON, which is in Ruby stdlib and suited very well for transporting
# and processing Plists compared to XML or YAML.

module Textpow
  class Processor
    def start_parsing(name); end

    def end_parsing(name); end

    def new_line(line); end

    def open_tag(name, pos); end

    def close_tag(name, mark); end
  end

  ParsingError = Class.new(RuntimeError)

  class SyntaxProxy
    def initialize(proxy, syntax)
      @proxy = proxy
      @syntax = syntax
      @proxy_value = nil
    end

    def method_missing(method, *args, &block)
      if @proxy
        @proxy_value ||= proxy

        if @proxy_value
          @proxy_value.send(method, *args, &block)
        else
          # warn "Failed proxying #{@proxy}.#{method}(#{args.join(', ')})"
        end
      else
        super
      end
    end

    def proxy
      case @proxy
      when /^#(.+)/
        return unless @syntax.repository
        @syntax.repository[Regexp.last_match(1).to_sym]
      when '$self', '$base'
        @syntax
      else
        @syntax.syntaxes[@proxy]
      end
    end
  end

  class SyntaxNode
    @@syntaxes = {}

    def self.load(filename, name_space = :default)
      filename = filename.to_s

      table =
        case filename
        when /(\.tmSyntax|\.plist)$/
          Plist.parse_xml(filename)
        when /\.json$/i
          JSON.load(File.read(filename))
        when /\.ya?ml$/i
          YAML.load_file(filename)
        when /\.rb$/i
          eval(File.read(filename))
        else
          raise ArgumentError, 'Unknown filename extension'
        end

      SyntaxNode.new(table, nil, name_space) if table
    end

    LITERAL_KEYS = %i[firstLineMatch foldingStartMarker foldingStopMarker
                      match begin content fileTypes name contentName
                      end scopeName keyEquivalent]

    attr_accessor :processor, :syntax, :firstLineMatch, :foldingStartMarker,
                  :foldingStopMarker, :match, :begin, :content, :fileTypes, :name,
                  :contentName, :end, :scopeName, :keyEquivalent, :captures,
                  :beginCaptures, :endCaptures, :repository, :patterns

    def initialize(hash, syntax = nil, name_space = :default)
      @name_space = name_space

      prepare_scope_name(hash[:scopeName])

      @syntax = syntax || self

      hash.each do |key, value|
        case key
        when :captures, :beginCaptures, :endCaptures
          send("#{key}=", value.sort)
        when :repository
          parse_repository value
        when :patterns
          create_children value
        when *LITERAL_KEYS
          send("#{key}=", value)
        else
          # $stderr.puts "Ignoring: #{key} => #{value.to_s.gsub("\n", "\n>>")}" if $DEBUG
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

      processor.end_parsing scopeName
      processor
    end

    def parse_repository(repository)
      @repository = {}

      repository.each do |key, value|
        @repository[key] = if include = value[:include]
                             SyntaxProxy.new(include, syntax)
                           else
                             SyntaxNode.new(value, syntax, @name_space)
                           end
      end
    end

    def create_children(patterns)
      @patterns = []
      syntax = self.syntax

      patterns.each do |pattern|
        @patterns << if include = pattern[:include]
                       SyntaxProxy.new(include, syntax)
                     else
                       SyntaxNode.new(pattern, syntax, @name_space)
                     end
      end
    end

    def parse_captures(name, pattern, match, processor)
      all_starts = []
      all_ends = []

      pattern.match_captures(name, match).each do |group, range, match_name|
        range_first = range.first
        next unless range_first

        range_last = range.last
        next if range_first == range_last

        all_starts << [range_first, group, match_name]
        all_ends   << [range_last, -group, match_name]
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
          if Symbol === key
            key = key.to_sym
            match_to_key = match.to_index(key)
            matches << [match_to_key, match.offset(key), value[:name]] if match_to_key
          else
            key = key.to_i
            matches << [key, match.offset(key), value[:name]] if key < match.size
          end
        end
      end

      matches
    end

    def match_first(string, position)
      if match
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

      regstring.gsub!(/\\([1-9])/) { match[Regexp.last_match(1).to_i] }
      regstring.gsub!(/\\k<(.*?)>/) { match[Regexp.last_match(1).to_sym] }
      regstring = '\\\\' if regstring == '\\'

      Regexp.new(regstring).match(string, position)
    end

    def match_first_son(string, position)
      return unless patterns
      match = nil

      patterns.each do |pattern|
        tmatch = pattern.match_first(string, position)

        next unless tmatch

        if !match || match[1].offset(0).first > tmatch[1].offset(0).first
          match = tmatch
        end
      end

      match
    end

    def parse_line(stack, line, processor)
      processor.new_line(line)
      top, match = stack.last
      position = 0

      loop do
        if top.patterns
          pattern, pattern_match = top.match_first_son(line, position)
        else
          pattern, pattern_match = nil
        end

        end_match = nil

        end_match = top.match_end(line, match, position) if top.end

        if end_match && (!pattern_match || pattern_match.offset(0).first >= end_match.offset(0).first)
          pattern_match = end_match
          pattern_match_first_offset = pattern_match.offset(0)
          start_pos = pattern_match_first_offset.first
          end_pos = pattern_match_first_offset.last

          top_contentName = top.contentName
          processor.close_tag top_contentName, start_pos if top_contentName

          parse_captures :captures, top, pattern_match, processor
          parse_captures :endCaptures, top, pattern_match, processor

          top_name = top.name
          processor.close_tag top_name, end_pos if top_name

          stack.pop
          top, match = stack.last
        else
          break unless pattern

          start_pos = pattern_match.offset(0).first
          end_pos = pattern_match.offset(0).last
          pattern_name = pattern.name

          if pattern.begin
            processor.open_tag pattern_name, start_pos if pattern_name
            parse_captures :captures, pattern, pattern_match, processor
            parse_captures :beginCaptures, pattern, pattern_match, processor

            pattern_contentName = pattern.contentName
            processor.open_tag pattern_contentName, end_pos if pattern_contentName

            top = pattern
            match = pattern_match
            stack << [top, match]
          elsif pattern.match
            processor.open_tag pattern_name, start_pos if pattern_name
            parse_captures :captures, pattern, pattern_match, processor
            processor.close_tag pattern_name, end_pos if pattern_name
          end
        end

        if position >= end_pos
          # raise "Parser didn't move forward on line: %p" % [line]
          return
        else
          position = end_pos
        end
      end
    end
  end
end
