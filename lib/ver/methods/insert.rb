module VER
  Buffer.def_delegator(:@at_insert, :tab, :insert_tab)
  Buffer.def_delegator(:@at_insert, :newline, :insert_newline)
  Buffer.def_delegator(:@at_insert, :selection, :insert_selection)

  module Methods
    module Insert
      module_function

      def tab(buffer)     buffer.insert_tab end
      def newline(buffer) buffer.insert_newline end
      def selection(buffer) buffer.insert_selection end

      def file_contents(filename)
        content = read_file(filename)
        insert :insert, content
      rescue Errno::ENOENT => ex
        VER.error(ex)
      end

      def newline_below(text)
        Undo.record text do |record|
          if text.options.autoindent
            line = text.get('insert linestart', 'insert lineend')

            indent = line[/^\s*/]
            text.insert = 'insert lineend'
            record.insert(:insert, "\n#{indent}")
          else
            text.insert = 'insert lineend'
            record.insert(:insert, "\n")
          end

          Control.clean_line(text, 'insert - 1 line', record)
        end

        text.minor_mode(:control, :insert)
      end

      def newline_above(text)
        Undo.record text do |record|
          if text.index(:insert).y > 1
            Move.prev_line(text)
            newline_below(text)
          else
            record.insert('insert linestart', "\n")
            text.mark_set(:insert, 'insert - 1 line')
            Control.clean_line(text, 'insert - 1 line', record)
            text.minor_mode(:control, :insert)
          end
        end
      end

      def indented_newline(text)
        Undo.record text do |record|
          line1 = text.get('insert linestart', 'insert lineend')
          indentation1 = line1[/^\s+/] || ''
          record.insert(:insert, "\n")

          line2 = text.get('insert linestart', 'insert lineend')
          indentation2 = line2[/^\s+/] || ''

          record.replace(
            'insert linestart',
            "insert linestart + #{indentation2.size} chars",
            indentation1
          )

          Control.clean_line(text, 'insert - 1 line', record)
        end
      end

      # Most of the input will be in US-ASCII, but an encoding can be set per
      # buffer for the input.
      # For just about all purposes, UTF-8 should be what you want to input, and
      # it's what Tk can handle best.
      def string(text)
        common_string(text, text.event.unicode)
      end

      def enter_replace(buffer, old_mode, new_mode)
        # store count argument for later repetition
        buffer.store(self, :replace_count, buffer.prefix_count(0))
        buffer.store(self, :replace_chars, '')
      end

      def leave_replace(buffer, old_mode, new_mode)
        # repeat replacment
        count = buffer.store(self, :replace_count)
        chars = buffer.store(self, :replace_chars).dup

        buffer.undo_record do |record|
          count.times do
            common_string(buffer, chars, record)
          end
        end
      end

      def replace_string(buffer, replacement = buffer.event.unicode)
        buffer.undo_record do |record|
          record.delete(:insert, 'insert + 1 chars')
          buffer.store(self, :replace_chars) << replacement
          common_string(buffer, replacement, record)
        end
      end

      def replace_char(buffer, replacement = buffer.event.unicode, count = buffer.prefix_count)
        buffer.undo_record do |record|
          count.times do
            record.delete(:insert, 'insert + 1 chars')
            common_string(buffer, replacement, record)
          end
        end
        buffer.skip_prefix_count_once = replacement =~ /^\d+$/
        buffer.mark_set(:insert, 'insert - 1 chars')
        buffer.minor_mode(:replace_char, :control)
      end

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
