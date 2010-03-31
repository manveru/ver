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

      # Insert characters literally, or enter decimal byte value (3 digits).
      # This means we try to get up to 3 digits, but possibly don't get any.
      #
      # This code is less than elegant, but so is the behaviour we try to
      # achieve.
      #
      # (none)		decimal		   3		255
      # o or O		octal		   3		377	 (255)
      # x or X		hexadecimal	   2		ff	 (255)
      # u		hexadecimal	   4		ffff	 (65535)
      # U		hexadecimal	   8		7fffffff (2147483647)
      def literal(buffer)
        reader = ->(string = ''){
          buffer.major_mode.read(1) do |event|
            if unicode = event.unicode
              string += unicode # copy
              buffer.message string.inspect

              case result = literal_handle(buffer, string)
              when nil
                reader.call(string)
              when String
                literal_insert(buffer, result)
              end
            else
              return # Unverrichteter Dinge
            end
          end
        }

        reader.call
      end

      # returning nil means read next char
      # returning a String means you're done and want the result inserted.
      # returning anything else means you're giving up.
      def literal_handle(buffer, string)
        case string
        when /^\d{,3}$/
          return if string.size < 3
          [string.to_i].pack('U')
        when /^o([0-7]{,3})$/i
          return if $1.size < 3
          [Integer("0#$1")].pack('U')
        when /^x(\h{,2})$/i
          return if $1.size < 2
          [Integer("0x#$1")].pack('U')
        when /^u(\h{,4})$/
          return if $1.size < 4
          [Integer("0x#$1")].pack('U')
        when /^U(\h{,8})$/
          return if $1.size < 8
          [Integer("0x#$1")].pack('U')
        end
      end

      def literal_insert(buffer, char)
        buffer.at_insert.insert(char)
      end
    end
  end
end
