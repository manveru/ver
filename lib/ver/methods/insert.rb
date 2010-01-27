module VER::Methods
  module Insert
    class << self
      def file_contents(filename)
        content = read_file(filename)
        insert :insert, content
      rescue Errno::ENOENT => ex
        VER.error(ex)
      end

      def selection(text)
        text.insert(:insert, Tk::Selection.get)
      end

      def tab(text)
        text.insert(:insert, "\t")
      end

      def newline(text)
        text.insert(:insert, "\n")
      end

      def indented_newline_below(text)
        Undo.record text do |record|
          if text.options.autoindent
            text.mark_set('insert', 'insert lineend')
            Indent.insert_newline(text, record)
          else
            text.mark_set(:insert, 'insert lineend')
            record.insert(:insert, "\n")
            Control.clean_line(text, 'insert - 1 line', record)
          end
        end

        text.minor_mode(:control, :insert)
      end

      def indented_newline_above(text)
        Undo.record text do |record|
          if text.index(:insert).y > 1
            Move.prev_line(text)
            indented_newline_below(text)
          else
            record.insert('insert linestart', "\n")
            text.mark_set(:insert, 'insert - 1 line')
            Control.clean_line(text, 'insert - 1 line', record)
            text.minor_mode(:control, :insert)
          end
        end
      end

      def indented_newline(text)
        if text.options.autoindent
          Indent.insert_newline(text)
        else
          text.insert(:insert, "\n")
        end
      end

      # Most of the input will be in US-ASCII, but an encoding can be set per view for the input.
      # For just about all purposes, UTF-8 should be what you want to input, and it's what Tk
      # can handle best.
      def string(text)
        common_string(text, text.event.unicode)
      end

      def replace_string(text, replacement = text.event.unicode)
        Undo.record text do |record|
          record.delete(:insert, 'insert + 1 chars')
          common_string(text, replacement, record)
        end
      end

      def replace_char(text, replacement = text.event.unicode)
        Undo.record text do |record|
          record.delete(:insert, 'insert + 1 chars')
          common_string(text, replacement, record)
        end
        text.mark_set(:insert, 'insert - 1 chars')
        text.minor_mode(:replace_char, :control)
      end

      private

      def common_string(text, string, record = text)
        return if string.empty?

        if !string.frozen? && string.encoding == Encoding::ASCII_8BIT
          begin
            string.encode!(text.encoding)
          rescue Encoding::UndefinedConversionError
            string.force_encoding(string.encoding)
          end
        end

        # puts "Insert %p in mode %p" % [string, keymap.mode]
        record.insert(:insert, string)
      end
    end
  end
end
