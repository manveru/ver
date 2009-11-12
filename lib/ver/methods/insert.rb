module VER
  module Methods
    module Insert
      def insert_selection
        insert :insert, Tk::Selection.get
      end

      def insert_tab
        insert :insert, "\t"
      end

      def insert_indented_newline_below
        line = get('insert linestart', 'insert lineend')

        indent = line.empty? ? "" : (line[/^\s+/] || '')
        mark_set :insert, 'insert lineend'
        insert :insert, "\n#{indent}"

        clean_previous_line
        start_insert_mode
      end

      def insert_indented_newline_above
        if index(:insert).y > 1
          go_line_up
          insert_indented_newline_below
        else
          insert('insert linestart', "\n")
          mark_set(:insert, 'insert - 1 line')
        end

        clean_previous_line
        start_insert_mode
      end

      def insert_newline
        insert :insert, "\n"
      end

      def insert_indented_newline
        if @syntax
          parser = @syntax.parser
          line = get('insert linestart', 'insert lineend')

          if parser.foldingStartMarker =~ line
            indent = line[/^\s+/] || ''
            insert(:insert, "\n")
            insert(:insert, indent + '  ')
          elsif parser.foldingStopMarker =~ line
            indent = line[/^\s+/] || ''
            replace('insert linestart', "insert linestart + #{indent.size} chars", '')
            insert(:insert, "\n")
            insert(:insert, indent.sub(/  /, ''))
          else
            fallback_insert_indented_newline
          end
        else
          fallback_insert_indented_newline
        end

        clean_previous_line
      end

      def fallback_insert_indented_newline
        line1 = get('insert linestart', 'insert lineend')
        indentation1 = line1[/^\s+/] || ''
        insert :insert, "\n"

        line2 = get('insert linestart', 'insert lineend')
        indentation2 = line2[/^\s+/] || ''

        replace(
          'insert linestart',
          "insert linestart + #{indentation2.size} chars",
          indentation1
        )
      end

      # Most of the input will be in US-ASCII, but an encoding can be set per view for the input.
      # For just about all purposes, UTF-8 should be what you want to input, and it's what Tk
      # can handle best.
      def insert_string(string)
        return if string.empty?

        if !string.frozen? && string.encoding == Encoding::ASCII_8BIT
          begin
            string.encode!(@encoding)
          rescue Encoding::UndefinedConversionError
            string.force_encoding(@encoding)
          end
        end

        # puts "Insert %p in mode %p" % [string, keymap.mode]
        insert :insert, string
      end

      def auto_indent_line
        if @syntax
          syntax_indent_line
        end
      end

      def indent_settings
        return {} unless @syntax
        name = @syntax.name
        file = File.open("config/preferences/#{name}.json")
        pref = JSON.load(File.read(file))

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

        index('1.0').upto(index('end')) do |pos|
          pos_lineend = pos.lineend
          line = get(pos, pos_lineend).strip

          if increase && decrease && line =~ increase && line =~ decrease
            indent -= 1
            replace(pos, pos_lineend, ('  ' * indent) << line)
            indent += 1
          elsif decrease && line =~ decrease
            indent -= 1
            replace(pos, pos_lineend, ('  ' * indent) << line)
          elsif increase && line =~ increase
            replace(pos, pos_lineend, ('  ' * indent) << line)
            indent += 1
          elsif line =~ empty_line
          else
            replace(pos, pos_lineend, ('  ' * indent) << line)
          end
        end
      end
    end
  end
end
