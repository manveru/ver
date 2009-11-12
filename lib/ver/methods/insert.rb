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
    end
  end
end
