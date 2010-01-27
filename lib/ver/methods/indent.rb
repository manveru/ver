module VER::Methods
  module Indent
    class << self
      def insert_newline(text, record = text)
        settings = indent_settings(text)
        increase, decrease = settings.values_at(:increase, :decrease)

        reference_line = text.get(
          "insert - 1 lines linestart",
          "insert - 1 lines lineend"
        )
        reference = reference_line[/^\s*/].size / 2
        reference_increase = increase =~ reference_line
        reference_decrease = decrease =~ reference_line

        current_line = text.get(
          "insert linestart",
          "insert lineend"
        )
        current_increase = increase =~ current_line
        current_decrease = decrease =~ current_line

        # we strip whitespace from previous empty lines, but it's still added to
        # the current one, so we use it as reference.
        if reference_line.empty?
          reference = current_line[/^\s*/].size / 2
        end

        pattern = [
          if reference_increase && reference_decrease; '='
          elsif reference_increase; '+'
          elsif reference_decrease; '-'
          else; '?'
          end,
          if current_increase && current_decrease; '='
          elsif current_increase; '+'
          elsif current_decrease; '-'
          else; '?'
          end
        ].join

        current_indent, next_indent =
          case pattern
          when '++'; [reference + 1, reference + 2]
          when '+-'; [reference, reference]
          when '+='; [reference, reference]
          when '+?'; [reference + 1, reference + 1]
          when '-+'; [reference, reference]
          when '--'; [reference - 1, reference - 2]
          when '-='; [reference, reference]
          when '-?'; [reference, reference]
          when '=+'; [reference + 1, reference + 1]
          when '=-'; [reference, reference]
          when '=='; [reference, reference]
          when '=?'; [reference + 1, reference + 1]
          when '?+'; [reference, reference + 1]
          when '?-'; [reference - 1, reference - 2]
          when '?='; [reference - 1, reference]
          when '??'; [reference, reference]
          end

        if text.index('insert - 1 line') == text.index('insert')
          # first line, replace is futile
          next_indent -= 1
        elsif current_line =~ /\S/
          current_indent = [0, current_indent].max
          record.replace(
            'insert linestart',
            'insert lineend',
            (' ' * (current_indent * 2)) << current_line.lstrip
          )
        else # that was an empty line
          record.replace('insert linestart', 'insert lineend', '')
        end

        next_indent = [0, next_indent].max

        p pattern if $DEBUG
        p reference: reference, current: current_indent, next: next_indent if $DEBUG

        record.insert(:insert, "\n#{' ' * (next_indent * 2)}")
      end

      def indent_settings(text)
        return {} unless text.load_preferences

        indent_settings = {}

        text.preferences.each do |pref|
          settings = pref[:settings]
          indent_settings[:increase]    ||= settings[:increaseIndentPattern]
          indent_settings[:decrease]    ||= settings[:decreaseIndentPattern]
          indent_settings[:indent_next] ||= settings[:indentNextLinePattern]
          indent_settings[:unindented]  ||= settings[:unIndentedLinePattern]
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
    end
  end
end
