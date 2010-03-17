require 'strscan'

module VER
  module Methods
    module Snippet
      module_function

      def dwim(buffer)
        jump(buffer) or complete(buffer) && jump(buffer)
      end

      def jump(buffer)
        jump_marks_and_tags(buffer) || jump_home(buffer)
      end

      def jump_home(buffer)
        if buffer.mark_names.include?(:ver_snippet_0)
          buffer.mark_set(:insert, :ver_snippet_0)
          buffer.mark_unset(:ver_snippet_0)
          true
        else
          cancel(buffer)
          false
        end
      end

      def jump_marks_and_tags(buffer)
        (marks(buffer) + tags(buffer)).
          sort_by{|_, name, _|
            name =~ /_0$/ ? 'zero' : name
          }.each do |idx, name, type|

          case type
          when :tag
            return jump_tag(buffer, name)
          when :mark
            return jump_mark(buffer, name)
          end
        end

        false
      end

      def marks(buffer)
        buffer.mark_names.map{|mark|
          next unless mark =~ /^ver_snippet_(\d+)$/
          [$1.to_i, mark, :mark]
        }.compact
      end

      def tags(buffer)
        buffer.tag_names.map{|tag|
          next unless tag =~ /^ver\.snippet\.(\d+)$/
          [$1.to_i, tag, :tag]
        }.compact
      end

      def jump_tag(buffer, name)
        buffer.minor_mode(:insert, :snippet)
        from, to = *buffer.tag_ranges(name).first
        return unless from

        buffer.mark_set(:insert, from)
        true
      end

      def jump_mark(buffer, name)
        buffer.mark_set('insert', name)
        if name =~ /_0$/
          cancel(buffer, :insert)
        else
          buffer.mark_unset(name)
        end

        true
      end

      def cancel(buffer, into_mode = :control)
        marks(buffer).each{|_, mark, _| buffer.mark_unset(mark) }
        tags(buffer).each{|_, tag, _| buffer.tag_delete(tag) }
        buffer.minor_mode(:snippet, into_mode) if buffer.minor_mode?(:snippet)
      end

      def on_insert(buffer, string = buffer.event.unicode)
        tag = buffer.tag_names(:insert).find{|name| name =~ /^ver\.snippet\.(\d+)$/ }

        if tag
          from, to = *buffer.tag_ranges(tag).first
          buffer.tag_delete(tag, from, to)
          buffer.replace(from, to, string)
        else
          buffer.insert(:insert, string)
        end
      end

      class Scope < Struct.new(:tags)
        def include?(scope)
          tags.include?(scope)
        end
      end

      def complete(buffer)
        sofar = buffer.get('insert linestart', 'insert')
        l sofar: sofar

        scope = Scope.new(buffer.tag_names(:insert))

        buffer.snippets.each do |snippet|
          next unless tab_trigger = snippet[:tabTrigger]
          next unless sofar.end_with?(tab_trigger)
          next unless scope.include?(snippet[:scope])
          from = buffer.index("insert - #{tab_trigger.size} displaychars")
          to = buffer.at_insert
          return insert(buffer, from, to, snippet)
        end

        return

        head = buffer.get('insert linestart', 'insert')
        name = head[/\S+$/]
        from = buffer.index("insert - #{name.size} chars")
        to = buffer.index("insert")

        l buffer.snippets

        return unless snippet = buffer.snippets[name]
        insert(buffer, from, to, snippet)
        true
      end

      def insert(buffer, from, to, snippet_source)
        buffer.delete(from, to)
        buffer.mark_set(:insert, from)
        snippet = VER::Snippet.new(snippet_source[:content])
        snippet.apply_on(buffer)
      end
    end # Snippet
  end # Methods

  # TODO: transformations
  class Snippet
    LITERAL_BACKTICK  = /\\`/
    LITERAL_DOLLAR    = /\\\$/
    LITERAL_BACKSLASH = /\\/
    PLAIN_TEXT = /[^\\`$]+/
    TAB_STOP = /\$(\d+)/
    NESTED_TAB_STOP = /^\$\{(?<id>\d+):(?<nested>((?<pg>\$\{(?:\\\$\{|\\\}|[^\\}$]|\g<pg>)*\})|(?:\\\}|\\\$\{|[^$}]))+)\}/

    variable = /[A-Z_]+/
    regexp = /(?:\\\/|[^\/\\]+)*/
    format = /(?:\\\/|[^\/\\]+)*/
    options = /[g]*/
    SUBSTITUTE_VARIABLE = /\$(#{variable})/
    SUBSTITUTE_VARIABLE_WITH_DEFAULT = /\$\{(#{variable}):([^}]+)\}/
    SUBSTITUTE_VARIABLE_WITH_REGEXP = /\$\{(#{variable})\/(#{regexp})\/(#{format})\/(#{options})\}/
    SUBSTITUTE_SHELL_CODE = /`((?:\\`|[^`\\]+)*)`/

    attr_accessor :env

    def initialize(snippet, env = {})
      @snippet = snippet
      @env = env
    end

    def to_s
      parse(@snippet, out = [])
      out.join
    end

    def result
      parse(@snippet, out = [])
      out
    end

    def apply_on(buffer)
      parse(@snippet, out = [])
      apply_out_on(buffer, out)
    end

    private

    def parse(string, out)
      scanner = StringScanner.new(string)
      spos = nil

      until scanner.eos?
        spos = scanner.pos

        step(scanner, out)

        if spos == scanner.pos
          raise scanner.inspect
        end
      end
    end

    def step(s, out)
      if s.scan LITERAL_BACKTICK
        out << '`'
      elsif s.scan LITERAL_DOLLAR
        out << '$'
      elsif s.scan LITERAL_BACKSLASH
        out << '\\'
      elsif s.scan SUBSTITUTE_VARIABLE
        out << @env[s[1]]
      elsif s.scan SUBSTITUTE_VARIABLE_WITH_DEFAULT
        key = s[1]
        if @env.key?(key)
          out << @env[key]
        else
          out << sub(s[2])
        end
      elsif s.scan SUBSTITUTE_VARIABLE_WITH_REGEXP
        variable, regexp, format, options = s[1], s[2], s[3], s[4]
        regexp = Regexp.new(regexp)
        format.gsub!(/\$(\d+)/, '\\\\\1')

        if env.key?(variable)
          value = env[variable]
          out << value.gsub(regexp, format)
        end
      elsif s.scan SUBSTITUTE_SHELL_CODE
        code = s[1]
        code.gsub!(/\\`/, '`')
        out << `#{code}`.chomp
      elsif s.scan TAB_STOP
        number = s[1].to_i
        out << number
      elsif s.scan NESTED_TAB_STOP
        number = s[1].to_i
        out << [number, *sub(s[2])]
      elsif s.scan PLAIN_TEXT
        out << s[0]
      end
    end

    def sub(s)
      out = []
      parse(s, out)
      out
    end

    def apply_out_on(buffer, out)
      indent = ' ' * buffer.options.shiftwidth
      initial_indent = buffer.get('insert linestart', 'insert lineend')[/^\s+/]

      buffer.undo_record do |record|
        out.each do |atom|
          case atom
          when String
            atom = atom.
              gsub(/\t/, indent).
              gsub(/\n/, "\n#{initial_indent}")
            record.insert(:insert, atom)
          when Numeric
            mark = "ver_snippet_#{atom}"
            buffer.mark_set(mark, 'insert')
            buffer.mark_gravity(mark, 'left')
          when Array
            number, content = atom
            tag = "ver.snippet.#{number}"
            buffer.tag_configure(tag, underline: true)
            record.insert(:insert, content, tag)
          end
        end
      end
    end
  end # Snippet
end # VER
