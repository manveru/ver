module VER
  module Methods
    module Clipboard
      def copy(text)
        if text.respond_to?(:to_str)
          copy_string(text)
        elsif text.respond_to?(:to_ary)
          copy_array(text)
        else
          copy_fallback(text)
        end
      end

      def copy_string(text)
        clipboard_set(text = text.to_str, type: 'STRING')

        copy_message text.count("\n"), text.size
      end

      def copy_array(text)
        array = text.to_ary
        string = array.map(&:to_tcl).join(' ')
        clipboard_set(string, type: 'ARRAY')

        copy_message text.size, text.reduce(0){|s,v| s + v.size }
      end

      def copy_fallback(text)
        clipboard_set(text)

        message "Copied unkown entity of class %p" % [text.class]
      end

      def copy_message(lines, chars)
        lines_desc = lines == 1 ? 'line' : 'lines'
        chars_desc = chars == 1 ? 'character' : 'characters'

        msg = "copied %d %s of %d %s" % [lines, lines_desc, chars, chars_desc]
        message msg
      end

      def paste_continous(text)
        if text =~ /\A([^\n]*)\n\Z/
          mark_set :insert, 'insert lineend'
          insert :insert, "\n#{$1}"
        elsif text =~ /\n/
          mark_set :insert, 'insert lineend'
          insert :insert, "\n"
          text.each_line{|line| insert(:insert, line) }
        else
          insert :insert, text
        end
      end

      def paste_tk_array(chunks)
        insert_y, insert_x = index(:insert).split

        chunks.each_with_index do |chunk, idx|
          y = insert_y + idx
          insert "#{y}.#{insert_x}", chunk
        end
      end

        def copy_line
          copy get('insert linestart', 'insert lineend + 1 chars')
        end

        def copy_right_word
          copy get('insert', 'insert wordend')
        end

        def copy_left_word
          copy get('insert', 'insert wordstart')
        end

        # FIXME: nasty hack or neccesary?
        def paste
          text = clipboard_get
          paste_continous text

        rescue RuntimeError => ex
          if ex.message =~ /form "STRING" not defined/
            array = clipboard_get('ARRAY')
            paste_tk_array array.to_a
          else
            Kernel.raise ex
          end
        end
      end
    end
  end
end
