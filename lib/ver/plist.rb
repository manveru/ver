# ver: sw=2

require 'nokogiri'
require 'pp'

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


class PP
  module PPMethods
    # make hashes prettier
    def pp_hash(obj)
      group(1, '{', '}') do
        seplist(obj, nil, :each_pair) do |k, v|
          group do
            if k.is_a?(Symbol) && k =~ /^\w+$/
              text k.to_s
              text ': '
            else
              pp k
              text ' => '
            end

            group(1) do
              breakable ''
              pp v
            end
          end
        end
      end
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
              raise "unhandled %p: %p" % [child_name, child]
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
            case key = child.inner_text
            when /^\d+$/
              key = key.to_i
            else
              key = key.to_sym
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
                when :begin, :match, :foldingStartMarker, :foldingStopMarker, :keyEquivalent
                  sanitize_regexp(value)
                else
                  value
                end
              else
                raise "unhandled %p: %p" % [child_name, child]
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

=begin
Parsing /home/manveru/prog/projects/textmate/Bundles/Markdown.tmbundle/Syntaxes/Markdown.plist
Exception `RegexpError' at /home/manveru/github/manveru/ver/lib/ver/plist.rb:116 - invalid backref number/name: /(?x)^

Parsing /home/manveru/prog/projects/textmate/Bundles/Markdown.tmbundle/Syntaxes/Markdown.plist
Exception `RegexpError' at /home/manveru/github/manveru/ver/lib/ver/plist.rb:239 - invalid backref number/name: /(?x)^
	(?=	[ ]{,3}>.
	|	([ ]{4}|\t)(?!$)
	|	[#]{1,6}\s*+
	|	[ ]{,3}(?<marker>[-*_])([ ]{,2}\k<marker>){2,}[ \t]*+$
	)(.*?)(?x)^
	(?!	[ ]{,3}>.
	|	([ ]{4}|\t)
	|	[#]{1,6}\s*+
	|	[ ]{,3}(?<marker>[-*_])([ ]{,2}\k<marker>){2,}[ \t]*+$
	)/

Parsing /home/manveru/prog/projects/textmate/Bundles/PHP.tmbundle/Syntaxes/PHP.plist
Exception `RegexpError' at /home/manveru/github/manveru/ver/lib/ver/plist.rb:281 - invalid multibyte escape: /[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*/
Exception `RegexpError' at /home/manveru/github/manveru/ver/lib/ver/plist.rb:281 - invalid multibyte escape: /(?i)\b(new)\s+(?:(\$[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)|(\w+))|(\w+)(?=::)/
Exception `RegexpError' at /home/manveru/github/manveru/ver/lib/ver/plist.rb:281 - invalid multibyte escape: /(?x)
	((\$\{)(?<name>[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)(\}))
	/
Exception `RegexpError' at /home/manveru/github/manveru/ver/lib/ver/plist.rb:281 - invalid multibyte escape: /(?x)
	((\$)(?<name>[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*))
	(?:
	(->)
	(?:
	(\g<name>)
	|
	(\$\g<name>)
	)
	|
	(\[)
	(?:(\d+)|((\$)\g<name>)|(\w+)|(.*?))
	(\])
	)?
	/

=end

      SANITIZE_REGEXP = {}
      r = lambda{|string, replacement|
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
      r['\b([a-zA-Z-:]+)','\b([a-zA-Z:-]+)']
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

        Regexp.new(value)
      rescue RegexpError => ex
        puts ' [ exception ] '.center(80, '-')
        puts ex, *ex.backtrace
        puts ' [ original regexp ] '.center(80, '-')
        p original
        puts original
        puts ' [ modified regexp ] '.center(80, '-')
        p value
        puts value
        puts '-' * 80
        /#{value.force_encoding(Encoding::BINARY)}/n
      end
    end

    module_function

    def parse_xml(filename)
      XML.new(File.read(filename)).parse
    end
  end
end
