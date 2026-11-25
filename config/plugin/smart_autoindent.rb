module VER
  module Methods
    module SmartAutoindent
      private

      def first_line_indent(start)
        leading_indent(buffer.get(start, start.lineend))
      end

      def newline_indentation(start, prefix, indent, placement)
        increase, decrease = indent_patterns
        return super unless increase || decrease

        step = ' ' * buffer.options.shiftwidth
        if placement == :split && decrease&.match?(prefix) && !indent.empty? && !step.empty?
          indent = closing_indent(start, indent, increase, step)
        end
        [indent, following_indent(prefix, indent, increase, step)]
      end

      def following_indent(line, base, increase, step)
        increase&.match?(line) ? base + step : base
      end

      def closing_indent(start, indent, increase, step)
        match = buffer.rsearch(/[^ \t\r\n\f\v]/, start, '1.0', :elide).first
        return indent unless match

        previous = buffer.get("#{match} linestart", "#{match} lineend")
        tabstop = buffer.options.tabstop
        columns = indent_columns(indent, tabstop)
        expected = following_indent(previous, leading_indent(previous), increase, step)
        # A closer left of the expected body indent is already aligned.
        return indent if columns.last < indent_columns(expected, tabstop).last

        width = [columns.last - step.size, 0].max
        keep = columns.bsearch_index { |column| column > width } - 1
        indent[0, keep] + ' ' * (width - columns[keep])
      end

      def indent_columns(indent, tabstop)
        columns = [0]
        indent.each_char do |char|
          column = columns.last
          columns << column + (char == "\t" ? tabstop - column % tabstop : 1)
        end
        columns
      end

      def indent_patterns
        return [nil, nil] unless buffer.load_preferences

        increase = decrease = nil
        buffer.preferences.each do |preference|
          settings = preference.fetch(:settings)
          increase ||= settings[:increaseIndentPattern]
          decrease ||= settings[:decreaseIndentPattern]
        end
        [increase, decrease].map { |pattern| Regexp.new(pattern) if pattern }
      end
    end
  end

  Text::Mark.prepend(Methods::SmartAutoindent) if options.keymap == 'vim'
end
