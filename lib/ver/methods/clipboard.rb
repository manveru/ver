module VER
  module Methods
    module Clipboard
      module_function

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
        return unless content = VER::Clipboard.dwim

        if content.respond_to?(:to_str)
          paste_continous(text, content.to_str)
        elsif content.respond_to?(:to_ary)
          paste_array(text, content.to_ary)
        else
          raise "Don't know how to handle %p" % [content]
        end
      end

      def paste_above(text)
        text.mark_set(:insert, 'insert - 1 line lineend')
        paste(text)
      end

      def copy(text, content)
        if content.respond_to?(:to_str)
          VER::Clipboard.string = string = content.to_str
          copy_message(text, string.count("\n") + 1, string.size)
        elsif content.respond_to?(:to_ary)
          VER::Clipboard.marshal = array = content.to_ary
          copy_message(text, array.size, array.reduce(0){|s,v| s + v.size })
        else
          VER::Clipboard.dwim = content
          text.message "Copied unkown entity of class %p" % [content.class]
        end
      end

      def copy_message(text, lines, chars)
        lines_desc = lines == 1 ? 'line' : 'lines'
        chars_desc = chars == 1 ? 'character' : 'characters'

        msg = "copied %d %s of %d %s" % [lines, lines_desc, chars, chars_desc]
        text.message(msg)
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

      def paste_array(text, array)
        insert_y, insert_x = *text.index(:insert)

        Undo.record text do |record|
          array.each_with_index do |line, index|
            record.insert("#{insert_y + index}.#{insert_x}", line)
          end
        end
      end
    end
  end
end
