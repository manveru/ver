require 'strscan'

module VER
  module Methods
    module Snippet
      class << self
        def dwim(text)
          jump(text) or complete(text) && jump(text)
        end

        def jump(text)
          jump_marks_and_tags(text) || jump_home(text)
        end

        def jump_home(text)
          if text.mark_names.include?(:ver_snippet_0)
            text.mark_set(:insert, :ver_snippet_0)
            text.mark_unset(:ver_snippet_0)
            true
          else
            cancel(text)
            false
          end
        end

        def jump_marks_and_tags(text)
          (marks(text) + tags(text)).
            sort_by{|_, name, _|
              name =~ /_0$/ ? 'zero' : name
            }.each do |idx, name, type|
            case type
            when :tag
              return jump_tag(text, name)
            when :mark
              return jump_mark(text, name)
            end
          end

          false
        end

        def marks(text)
          text.mark_names.map{|mark|
            next unless mark =~ /^ver_snippet_(\d+)$/
            [$1.to_i, mark, :mark]
          }.compact
        end

        def tags(text)
          text.tag_names.map{|tag|
            next unless tag =~ /^ver\.snippet\.(\d+)$/
            [$1.to_i, tag, :tag]
          }.compact
        end

        def jump_tag(text, name)
          text.mode = :snippet
          from, to = text.tag_ranges(name).first
          return unless from

          text.mark_set(:insert, from)
          true
        end

        def jump_mark(text, name)
          text.mark_set('insert', name)
          if name =~ /_0$/
            cancel(text, :insert)
          else
            text.mark_unset(name)
          end

          true
        end

        def cancel(text, into_mode = :control)
          marks(text).each{|_, mark, _| text.mark_unset(mark) }
          tags(text).each{|_, tag, _| text.tag_delete(tag) }
          text.mode = into_mode if text.mode == :snippet
        end

        def insert_string(text, string)
          tag = text.tag_names(:insert).find{|tag| tag =~ /^ver\.snippet\.(\d+)$/ }

          if tag
            from, to = text.tag_ranges(tag).first
            text.tag_delete(tag, from, to)
            text.replace(from, to, string)
          else
            text.insert(:insert, string)
          end
        end

        def complete(text)
          head = text.get('insert linestart', 'insert')
          name = head[/\S+$/]
          from = text.index("insert - #{name.size} chars")
          to = text.index("insert")

          return unless snippet = text.snippets[name]
          insert(text, from, to, snippet)
          true
        end

        def insert(text, from, to, snippet_source)
          text.delete(from, to)
          text.mark_set(:insert, from)
          snippet = VER::Snippet.new(snippet_source[:content])
          snippet.apply_on(text)
        end
      end
    end
  end

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

    def apply_on(widget)
      parse(@snippet, out = [])
      apply_out_on(widget, out)
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

    def apply_out_on(widget, out)
      indent = ' ' * widget.options.shiftwidth
      initial_indent = widget.get('insert linestart', 'insert lineend')[/^\s+/]

      VER::Methods::Undo.record widget do |record|
        out.each do |atom|
          case atom
          when String
            atom = atom.
              gsub(/\t/, indent).
              gsub(/\n/, "\n#{initial_indent}")
            record.insert(:insert, atom)
          when Numeric
            mark = "ver_snippet_#{atom}"
            widget.mark_set(mark, 'insert')
            widget.mark_gravity(mark, 'left')
          when Array
            number, content = atom
            tag = "ver.snippet.#{number}"
            widget.tag_configure(tag, underline: true)
            record.insert(:insert, content, tag)
          end
        end
      end
    end
  end
end
