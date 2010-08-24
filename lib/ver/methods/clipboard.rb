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

      def responding_to?(method)
        lambda{|object| object.respond_to?(method) }
      end

      def paste_after(buffer, count = buffer.prefix_count)
        buffer.with_register do |register|
          case content = register.value
          when responding_to?(:to_str)
            paste_string_after(buffer, count, content.to_str)
          when responding_to?(:to_ary)
            paste_array_after(buffer, count, content.to_ary)
          else
            buffer.warn "Don't know how to paste: %p" % [content]
          end
        end
      end

      def paste_after_go_after(buffer, count = buffer.prefix_count)
        buffer.with_register do |register|
          case content = register.value
          when responding_to?(:to_str)
            paste_string_after_go_after(buffer, count, content.to_str)
          when responding_to?(:to_ary)
            paste_array_after(buffer, count, content.to_ary)
          else
            buffer.warn "Don't know how to paste: %p" % [content]
          end
        end
      end

      def paste_after_adjust(buffer, count = buffer.prefix_count)
        buffer.with_register do |register|
          case content = register.value
          when responding_to?(:to_str)
            indent = buffer.at_insert.get('linestart', 'lineend')[/^[ \t]*/]
            string = content.to_str.gsub(/^\s*/, indent)
            paste_string_after(buffer, count, string)
          when responding_to?(:to_ary)
            paste_array_after(buffer, count, content.to_ary)
          else
            buffer.warn "Don't know how to paste: %p" % [content]
          end
        end
      end

      # on "foo", it's simple char selection, insert at insert mark.
      # on "foo\nb", it was a char selection, insert at insert mark.
      # on "foo\nbar\n":
      #   we assume it's linewise, insert newline at eol, then insert the string
      #   starting at the new line.
      def paste_string_after(buffer, count, string)
        buffer.undo_record do |record|
          if string =~ /\n\Z/ # ends with newline
            string = "\n#{string}".chomp * count # # put newline in front
            buffer.insert = buffer.at_insert.lineend
            record.insert(:insert, string)
            buffer.insert = buffer.at_insert.linestart
          else
            pastie_string_after!(record, count, string)
          end
        end
      end

      def paste_string_after_go_after(buffer, count, string)
        buffer.undo_record do |record|
          if string =~ /\n\Z/ # ends with newline
            string = "\n#{string}".chomp * count # # put newline in front
            buffer.insert = buffer.at_insert.lineend
            record.insert(:insert, string)
          else
            pastie_string_after!(record, count, string)
          end
        end
      end

      def pastie_string_after!(buffer, count, string)
        add = buffer.at_eol? ? '0' : '1'
        buffer.insert = buffer.at_insert + (add + ' displaychars')
        buffer.insert(:insert, string * count)
      end

      # the vim and the ver, the vim and the ver,
      # one's a genius, the other's insane.
      #
      # I have a faint idea how vim knows the difference, it involves the y_type
      # of a register struct, but we won't go into that.
      # It's enough to know that vim can only handle block pasting when it was
      # yanked from vim, we shall behave the same.
      def paste_array_after(buffer, count, array)
        insert_line, insert_char = *buffer.index(:insert)

        buffer.undo_record do |record|
          array.each_with_index do |line, index|
            record.insert("#{insert_line + index}.#{insert_char}", line)
          end
        end
      end

      def paste_before_go_after(buffer, count = buffer.prefix_count)
        buffer.with_register do |register|
          case content = register.value
          when responding_to?(:to_str)
            paste_string_before_go_after(buffer, count, content.to_str)
          when responding_to?(:to_ary)
            paste_array_before(buffer, count, content.to_ary)
          else
            buffer.warn "Don't know how to paste: %p" % [content]
          end
        end
      end

      def paste_before_adjust(buffer, count = buffer.prefix_count)
        buffer.with_register do |register|
          case content = register.value
          when responding_to?(:to_str)
            indent = buffer.at_insert.get('linestart', 'lineend')[/^[ \t]*/]
            string = content.to_str.gsub(/^\s*/, indent)
            paste_string_before(buffer, count, string)
          when responding_to?(:to_ary)
            paste_array_before(buffer, count, content.to_ary)
          else
            buffer.warn "Don't know how to paste: %p" % [content]
          end
        end
      end

      def paste_before(buffer, count = buffer.prefix_count)
        buffer.with_register do |register|
          case content = register.value
          when responding_to?(:to_str)
            paste_string_before(buffer, count, content.to_str)
          when responding_to?(:to_ary)
            paste_array_before(buffer, count, content.to_ary)
          else
            buffer.warn "Don't know how to paste: %p" % [content]
          end
        end
      end

      def paste_string_before(buffer, count, string)
        buffer.undo_record do |record|
          if string =~ /\n\Z/ # ends with newline
            string = string.chomp # get rid of that
            count.times do
              # insert newline at sol, insert string just before that
              buffer.insert = buffer.at_insert.linestart
              record.insert(:insert, "\n")
              record.insert(buffer.at_insert - '1 lines', string)
              buffer.insert = (buffer.at_insert - '1 lines').linestart
            end
          else
            buffer.insert = buffer.at_insert - '1 displaychars'
            record.insert(:insert, string * count)
          end
        end
      end

      def paste_string_before_go_after(buffer, count, string)
        buffer.undo_record do |record|
          if string =~ /\n\Z/ # ends with newline
            string = string.chomp # get rid of that
            count.times do
              # insert newline at sol, insert string just before that
              buffer.insert = buffer.at_insert.linestart
              record.insert(:insert, "\n")
              record.insert(buffer.at_insert - '1 lines', string)
              buffer.insert = (buffer.at_insert - '1 lines').linestart
            end
          else
            buffer.insert = buffer.at_insert - '1 displaychars'
            record.insert(:insert, string * count)
          end
        end
      end

      def paste_array_before(buffer, count, array)
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

        # FIXME: messages should be:
        # block of N lines yanked
        # N lines yanked
        # no message for a couple of chars

        msg = "copied %d %s of %d %s" % [lines, lines_desc, chars, chars_desc]
        text.message(msg)
      end

      def paste_continous(buffer, content)
        if content =~ /\A([^\n]*)\n\Z/
          buffer.mark_set :insert, 'insert lineend'
          buffer.insert :insert, "\n#{$1}"
        elsif content =~ /\n/
          buffer.mark_set :insert, 'insert lineend'
          buffer.insert :insert, "\n"
          content.each_line{|line| buffer.insert(:insert, line) }
        else
          buffer.insert :insert, content
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
