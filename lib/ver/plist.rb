require 'nokogiri'

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
        key = nil

        array.children.each do |child|
          child_name = child.name
          next if child_name == 'text'

          out.push(
            case child_name
            when 'key'
              raise 'No key allows in array'
            when 'array';           handle_array(child)
            when 'dict';            handle_dict(child)
            when 'false';           false
            when 'integer', 'real'; child.inner_text.to_i
            when 'string';          child.inner_text
            when 'true';            true
            else
              # $unhandled[child_name] << child
              raise "%p: %p is not handled" % [child_name, child]
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
          when 'key'; key = child.inner_text
          when 'text' # ignore
          else
            raise 'No key given' unless key

            out[key] =
              case child_name
              when 'array';           handle_array(child)
              when 'dict';            handle_dict(child)
              when 'false';           false
              when 'integer', 'real'; child.inner_text.to_i
              when 'string';          child.inner_text
              when 'true';            true
              else
                # $unhandled[child_name] << child
                raise "%p: %p is not handled" % [child_name, child]
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
    end

    module_function

    def parse_xml(filename)
      XML.new(File.read(filename)).parse
    end
  end
end
