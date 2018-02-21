# ver: sw=2

require 'nokogiri'
require 'pp'
require_relative 'vendor/better_pp_hash'

# Define some magic constants that aren't available but may be returned from
# Regexp#options so we can make sure that roundtrip via PP works.
#
# 1.9.2 actually defines Regexp::FIXEDENCODING, but there's no release yet, so
# we simply assume the values from the Ruby C source (which means this might not
# work on any other implementation).
# Hopefully nobody tries to convert textmate bundles unless they are on MRI 1.9.1 ;)
class Regexp
  NO_ENCODING = //n.options

  alias original_inspect inspect

  # Take into account //n option
  def inspect
    if options & NO_ENCODING == 0
      original_inspect
    else
      original_inspect << 'n'
    end
  end
end

module VER
  module Plist
    class XML
      def initialize(xml)
        @doc = Nokogiri(xml)
        @plist = {}
        @parsed = nil
        @exceptions = []
      end

      def parse
        @parsed || parse!
      end

      def parse!
        dict = @doc.at('/plist/dict')

        if dict
          @parsed = handle_dict(dict)
        else
          raise ArgumentError, 'This is no XML plist'
        end

        raise "#{@exceptions.size} errors encountered" if @exceptions.any?
        @parsed
      end

      def handle_array(array)
        out = []

        array.children.each do |child|
          child_name = child.name
          next if child_name == 'text'

          out.push(
            case child_name
            when 'key'
              raise 'No key allows in array'
            when 'array'
              handle_array(child)
            when 'dict'
              handle_dict(child)
            when 'false'
              false
            when 'integer', 'real'
              child.inner_text.to_i
            when 'string'
              child.inner_text
            when 'true'
              true
            else
              raise format('unhandled %p: %p', child_name, child)
            end
          )
        end

        out
      end

      def handle_dict(dict)
        out = {}
        key = nil

        dict.children.each do |child|
          child_name = child.name

          case child_name
          when 'key'
            key = case key = child.inner_text
                  when /^\d+$/
                    key.to_i
                  else
                    key.to_sym
                  end
          when 'text'
            # ignore
          else
            raise 'No key given' unless key

            out[key] =
              case child_name
              when 'array'
                handle_array(child)
              when 'dict'
                handle_dict(child)
              when 'integer', 'real'
                child.inner_text.to_i
              when 'true'
                true
              when 'false'
                false
              when 'string'
                value = child.inner_text
                case key
                when :begin, :match, :foldingStartMarker, :foldingStopMarker
                  sanitize_regexp(value)
                else
                  value
                end
              else
                raise format('unhandled %p: %p', child_name, child)
              end

            key = nil
          end
        end

        out
      end

      def to_yaml
        parse.to_yaml
      end

      def to_json
        parse.to_json
      end

      def to_hash
        parse
      end

      private

      SANITIZE_REGEXP = {}
      r = lambda { |string, replacement|
        pattern =
          if string.is_a? Regexp
            string
          else
            Regexp.new(Regexp.escape(string))
          end
        replacement.force_encoding Encoding::BINARY
        SANITIZE_REGEXP[pattern] = replacement
      }

      # found in newLisp.tmbundle
      r['(?<!(?:\{|\"|]))(?:[\s\n]*)?(;+.*?)$', '(?<!(?:\{|"|\]))(?:\s*)(;+.*)$']

      # found in Movable Type.tmbundle
      r['(<)(\$[mM][tT]:?(?:\w+)?:?\w+)(.*?)(\$)?(>)', '(<)(\$[mM][tT]:?(?:\w*):?\w+)(.*?)(\$)?(>)']
      r['(</?)([mM][tT]:?(?:\w+)?:?\w+)(.*?)>', '(</?)([mM][tT]:?(?:\w*):?\w+)(.*?)>']
      r['\b([a-zA-Z-_:]+)', '\b([a-zA-Z_:-]+)']

      # found in OCaml.tmbundle
      r['(?=(\[<)(?![^\[]+?[^>]]))(.*?)(>])', '(?=(\[<)(?![^\[]+?[^>\]]))(.*?)(>\])']
      r['(\')(.*?)(;)(?=\s*\')|(?=\s*>])', '(\')(.*?)(;)(?=\s*\')|(?=\s*>\])']
      r['(\[)(?!\||<|>)(.*?)(?<!\||>)(])', '(\[)(?!\||<|>)(.*?)(?<!\||>)(\])']
      r['(\[)(\^?)(.*?)(])(?!\\\')', '(\[)(\^?)(.*?)(\])(?!\\\')']
      r['(\[<)(?=.*?>])(.*?)(?=>])', '(\[<)(?=.*?>\])(.*?)(?=>\])']
      r['(\[\|)(.*?)(\|])', '(\[\|)(.*?)(\|\])']
      r['\[<|>]', '\[<|>\]']

      # found in Txt2tags.tmbundle
      r['|[^]]+', '|[^\]]+']

      # found in Perl Template Toolkit.tmbundle
      r['\b([a-zA-Z-_:]+)\s*(=)', '\b([a-zA-Z_:-]+)\s*(=)']

      # found in Property List.tmbundle
      r['<!\[CDATA\[(.*?)]]>', '<!\[CDATA\[(.*?)\]\]>']
      r['(<!\[CDATA\[)(.*?)(]]>)', '(<!\[CDATA\[)(.*?)(\]\]>)']

      # found in SWeave.tmbundle and a few others
      # warning: nested repeat operator ? and * was replaced with '*'
      r[/\.\?\*/, '.*']

      # Found in Textile.tmbundle
      r[/\\\[\[\^\]\]/, '\[[^\]]']

      # found in Twiki.tmbundle
      r['(\[)([^]]*)(\]) *(\[)(.*?)(\])', '(\[)([^\]]*)(\]) *(\[)(.*?)(\])']

      # found in XML.tmbundle
      r['<!\[CDATA\[(.*?)]]>', '<!\[CDATA\[(.*?)\]\]>']

      # '\b\u\w+\u\w+' => '\b\\u\w+\\u\w+'
      r[/\\(u)/i, '\\\\\1']

      # found in MEL.tmbundle/Syntaxes/MEL.plist
      r['(\$)[a-zA-Z_\x{7f}-\x{ff}][a-zA-Z0-9_\x{7f}-\x{ff}]*?\b', '(\$)\w\w*?\b']

      # "[\x{7f}-\x{ff}]" => "[\x7f-\xff]"
      r[/\\x\{(\h+)\}/, '\\\\x\1']

      # remove lots of tabs at line start
      r[/^\t+/, "\t"]

      # Escape #@ #$ #{ because they have special meaning in ruby literal regexps
      r[/([^\\]|$)#([$@{])/, '\1\#\2']

      # '(?=#)' => '(?=\#)'
      r['(?=#)', '(?=\#)']

      # found in Nemerle
      r['(\{|(|<\[)', '(\{|\(|<\[)']
      r['(\}|)|]>)',  '(\}|\)|\]>)']

      # found in HTML (Active4D)
      r['\b([a-zA-Z-:]+)', '\b([a-zA-Z:-]+)']
      r['\[CDATA\[(.*?)]](?=>)', '\[CDATA\[(.*?)\]\](?=>)']

      # found in Bulletin Board.tmbundle
      r['[\[]]+', '[\[\]]+']

      # found in C.tmbundle
      r['\bdelete\b(\s*\[\])?|\bnew\b(?!])', '\bdelete\b(\s*\[\])?|\bnew\b(?!\])']

      # found in reStructuredText.tmbundle
      r['(\.\.)\s[A-z][A-z0-9-_]+(::)\s*$', '(\.\.)\s[A-z][A-z0-9_-]+(::)\s*$']
      r['^(\.\.)\s+((\[)(((#?)[^]]*?)|\*)(\]))\s+(.*)', '^(\.\.)\s+((\[)(((#?)[^\]]*?)|\*)(\]))\s+(.*)']

      # Fix invalid regular expressions so we can write them out as Ruby code.
      #
      # NOTE:
      #   Yeah, it's weird to fix regular expressions with regular expressions.
      #   But it seems like the people writing syntax files slept all through
      #   regexp class and textmate must be working _very_ hard to allow all
      #   this without giving any warnings (maybe error messages are just not
      #   hip in osx).
      #   Also, there seems to be a lot of copy&pasting between syntax files, as
      #   soon as someone comes up with a horrible way to match things,
      #   everybody else is eager to use it in their files as well.
      #   </rant>
      def sanitize_regexp(value)
        original = value.dup

        SANITIZE_REGEXP.each do |pattern, replacement|
          value.gsub!(pattern, replacement)
        end

        value2 = ''
        group_index = 0
        value.scan(/((?:[^\\(]+|\\[^\d])+)|(\\\d+)|(\(\??)/m) do |content, backref, capture|
          value2 << if capture == '('
                      "(?<_#{group_index += 1}>"
                    elsif backref
                      "\\k<_#{backref[/\d+/]}>"
                    else
                      (content || capture)
                    end
        end

        Regexp.new(value2)
      rescue RegexpError => ex
        if ex.message =~ /^invalid multibyte escape:/
          begin
            /#{value2.force_encoding(Encoding::BINARY)}/n
          rescue RegexpError => ex
            error(ex, original, value2)
          end
        else
          error(ex, original, value2)
        end
      end

      def error(exception, original, modified)
        puts ' [ exception ] '.center(80, '-')
        puts exception, *exception.backtrace
        puts ' [ original regexp ] '.center(80, '-')
        p original
        puts original
        puts ' [ modified regexp ] '.center(80, '-')
        p modified
        puts modified
        puts '-' * 80
        @exceptions << exception
      end
    end

    module_function

    def parse_xml(filename)
      XML.new(File.read(filename)).parse
    end
  end
end
