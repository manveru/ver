module VER::Methods
  module Clipboard
    class << self
      def copy_line(text)
        content = text.get('insert linestart', 'insert lineend + 1 chars')
        copy(text, content)
      end

      def copy_motion(text, motion, count = 1)
        movement = Move.virtual(text, motion, count)
        copy(text, text.get(*movement))
      end

      # FIXME: nasty hack or neccesary?
      def paste(text)
        content = clipboard_get(text, 'STRING'){
          array = clipboard_get(text, 'ARRAY')
          return paste_array(text, array) if array
        }

        paste_continous(text, content.to_s) if content
      end

      def paste_above(text)
        text.mark_set(:insert, 'insert - 1 line lineend')
        paste(text)
      end

      def copy(text, content)
        if content.respond_to?(:to_str)
          copy_string(content.to_str)
        elsif content.respond_to?(:to_ary)
          copy_array(content.to_ary)
        else
          copy_fallback(content)
        end
      end

      def copy_string(content)
        Tk::Clipboard.set(content, type: 'STRING')

        copy_message(content.count("\n") + 1, content.size)
      end

      def copy_array(content)
        marshal = [Marshal.dump(content)].pack('m')
        Tk::Clipboard.set(marshal, type: 'ARRAY')

        copy_message content.size, content.reduce(0){|s,v| s + v.size }
      end

      def copy_fallback(content)
        Tk::Clipboard.set(content)

        VER.message "Copied unkown entity of class %p" % [content.class]
      end

      def copy_message(lines, chars)
        lines_desc = lines == 1 ? 'line' : 'lines'
        chars_desc = chars == 1 ? 'character' : 'characters'

        msg = "copied %d %s of %d %s" % [lines, lines_desc, chars, chars_desc]
        VER.message(msg)
      end

      def paste_continous(text, content)
        if content =~ /\A([^\n]*)\n\Z/
          text.mark_set :insert, 'insert lineend'
          text.insert :insert, "\n#{$1}"
        elsif content =~ /\n/
          text.mark_set :insert, 'insert lineend'
          text.insert :insert, "\n"
          content.each_line{|line| text.insert(:insert, line) }
        else
          text.insert :insert, content
        end
      end

      def paste_array(text, marshal_array)
        array = Marshal.load(marshal_array.unpack('m').first)
        insert_y, insert_x = text.index(:insert).split

        Undo.record text do |record|
          array.each_with_index do |line, index|
            record.insert("#{insert_y + index}.#{insert_x}", line)
          end
        end
      end

      def clipboard_get(text, type = 'STRING')
        Tk::Clipboard.get(text, type)
      rescue RuntimeError => ex
        if ex.message =~ /form "#{type}" not defined/
          yield if block_given?
        else
          VER.error(ex)
        end
      end
    end
  end
end
