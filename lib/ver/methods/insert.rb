module VER::Methods
  module Insert
    class << self
      def insert_file_contents(filename)
        content = read_file(filename)
        insert :insert, content
      rescue Errno::ENOENT => ex
        VER.error(ex)
      end

      def insert_selection(text)
        text.insert(:insert, Tk::Selection.get)
      end

      def insert_tab(text)
        text.insert(:insert, "\t")
      end

      def insert_indented_newline_below(text)
        Undo.record text do |record|
          if text.options.autoindent
            line = text.get('insert linestart', 'insert lineend')

            indent = line.empty? ? "" : (line[/^\s+/] || '')
            text.mark_set(:insert, 'insert lineend')
            record.insert(:insert, "\n#{indent}")
          else
            text.mark_set(:insert, 'insert lineend')
            record.insert(:insert, "\n")
          end

          Control.clean_line(text, 'insert - 1 line', record)
          text.mode = :insert
        end
      end

      def insert_indented_newline_above(text)
        Undo.record text do |record|
          if text.index(:insert).y > 1
            Move.prev_line(text)
            insert_indented_newline_below(text)
          else
            record.insert('insert linestart', "\n")
            text.mark_set(:insert, 'insert - 1 line')
            Control.clean_line(text, 'insert - 1 line', record)
            text.mode = :insert
          end
        end
      end

      def insert_indented_newline(text)
        if text.options.autoindent
          fallback_insert_indented_newline(text)
        else
          text.insert(:insert, "\n")
        end
      end

      def fallback_insert_indented_newline(text)
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

      # Most of the input will be in US-ASCII, but an encoding can be set per view for the input.
      # For just about all purposes, UTF-8 should be what you want to input, and it's what Tk
      # can handle best.
      def insert_string(text, string, record = text)
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

      def replace_string(text, string)
        return if string.empty?

        Undo.record text do |record|
          record.delete(:insert, 'insert + 1 chars')
          insert_string(string, record)
        end
      end
    end
  end
end

__END__

      def insert_auto_indented_newline(text)
        text.insert('insert lineend', "\n")
        indent_fix_at('insert', indent_fix('insert - 1 line', indent_after('insert - 2 line')))
      rescue Errno::ENOENT, TypeError
        fallback_insert_indented_newline
      end

      def indent_of(index)
        index = index(index)
        return 0 if index.y < 1

        line = get(index.linestart, index.lineend)

        if line =~ /^\s*$/
          return indent_of(index.prev)
        else
          indent_size = line[/^\s*/].size
          return 0 if indent_size == 0
          return indent_size / 2
        end
      end

      def indent_after(index, indent = nil)
        settings = indent_settings.values_at(:increase, :decrease, :indent_next, :unindented)

        return unless settings.any?
        increase, decrease, indent_next, unindented = settings

        index = index(index)
        indent ||= (index.y > 1 ? indent_after(index.prev) : 0)

        linestart, lineend  = index.linestart, index.lineend
        line = get(linestart, lineend).strip

        if increase && decrease && line =~ increase && line =~ decrease
          indent -= 1
          indent += 1
        elsif decrease && line =~ decrease
          indent -= 1
        elsif increase && line =~ increase
          indent += 1
        elsif line =~ /^\s*$/
        else
        end

        return indent
      end

      def indent_fix_at(index, indent)
        settings = indent_settings.values_at(:increase, :decrease, :indent_next, :unindented)

        return unless settings.any?
        increase, decrease, indent_next, unindented = settings

        index = index(index)

        linestart, lineend  = index.linestart, index.lineend
        line = get(linestart, lineend).strip

        if increase && decrease && line =~ increase && line =~ decrease
          indent -= 1
          replace(linestart, lineend, ('  ' * indent) << line)
          indent += 1
        elsif decrease && line =~ decrease
          replace(linestart, lineend, ('  ' * indent) << line)
          indent -= 1
        elsif increase && line =~ increase
          replace(linestart, lineend, ('  ' * indent) << line)
          indent += 1
        elsif line =~ /^\s*$/
          replace(linestart, lineend, ('  ' * indent) << line)
        else
          replace(linestart, lineend, ('  ' * indent) << line)
        end

        return indent
      end

      def auto_indent_line
        if @syntax
          syntax_indent_line
        end
      end

      def indent_settings
        return {} unless @syntax
        name = @syntax.name
        file = VER.find_in_loadpath("preferences/#{name}.rb")
        pref = eval(file.read)

        indent_settings = {}

        pref.each do |key, value|
          settings = value['settings']
          indent_settings[:increase]    ||= settings['increaseIndentPattern']
          indent_settings[:decrease]    ||= settings['decreaseIndentPattern']
          indent_settings[:indent_next] ||= settings['indentNextLinePattern']
          indent_settings[:unindented]  ||= settings['unIndentedLinePattern']
        end


        [:increase, :decrease, :indent_next, :unindented].each do |key|
          if value = indent_settings[key]
            indent_settings[key] = Regexp.new(value)
          else
            indent_settings.delete(key)
          end
        end

        return indent_settings
      end

      def syntax_indent_file
        settings = indent_settings.values_at(:increase, :decrease, :indent_next, :unindented)

        return unless settings.any?
        increase, decrease, indent_next, unindented = settings

        empty_line = /^\s*$/
        indent = 0
        indent_token = ' ' * options.shiftwidth

        undo_record do |record|
          index('1.0').upto(index('end')) do |pos|
            pos_lineend = pos.lineend
            line = get(pos, pos_lineend).strip

            if increase && decrease && line =~ increase && line =~ decrease
              indent -= 1
              record.replace(pos, pos_lineend, (indent_token * indent) << line)
              indent += 1
            elsif decrease && line =~ decrease
              indent -= 1
              record.replace(pos, pos_lineend, (indent_token * indent) << line)
            elsif increase && line =~ increase
              record.replace(pos, pos_lineend, (indent_token * indent) << line)
              indent += 1
            elsif line =~ empty_line
            else
              record.replace(pos, pos_lineend, (indent_token * indent) << line)
            end
          end
        end
      end
    end
  end
end
