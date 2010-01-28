module VER::Methods
  module Indent
    class << self
      def insert_newline(text, record = text)
        settings = indent_settings(text)
        increase, decrease = settings.values_at(:increase, :decrease)
        unless increase || decrease
          record.insert :insert, "\n"
          return
        end

        ref_line = text.get(
          "insert - 1 lines linestart",
          "insert - 1 lines lineend"
        )
        ref = ref_line[/^\s*/].size / 2
        ref_inc = increase ? ref_line.scan(increase).size : 0
        ref_dec = decrease ? ref_line.scan(decrease).size : 0

        cur_line = text.get(
          "insert linestart",
          "insert lineend"
        )
        cur_inc = increase ? cur_line.scan(increase).size : 0
        cur_dec = decrease ? cur_line.scan(decrease).size : 0

        # we strip whitespace from previous empty lines, but it's still added to
        # the current one, so we use it as reference.
        if ref_line.empty?
          ref = cur_line[/^\s*/].size / 2
        end

        pattern = [
          if ref_inc != 0 && ref_dec != 0; '='
          elsif ref_inc != 0; '+'
          elsif ref_dec != 0; '-'
          else; '?'
          end,
          if cur_inc != 0 && cur_dec != 0; '='
          elsif cur_inc != 0; '+'
          elsif cur_dec != 0; '-'
          else; '?'
          end
        ].join

        cur_indent, next_indent =
          case pattern
          when '++'; [ref + 1, ref + 2]
          when '+-'; [ref,     ref]
          when '+='; [ref,     ref]
          when '+?'; [ref + 1, ref + 1]
          when '-+'; [ref,     ref]
          when '--'; [ref - 1, ref - 2]
          when '-='; [ref,     ref]
          when '-?'; [ref,     ref]
          when '=+'; [ref + 1, ref + 1]
          when '=-'; [ref,     ref]
          when '=='; [ref,     ref]
          when '=?'; [ref + 1, ref + 1]
          when '?+'; [ref,     ref + 1]
          when '?-'; [ref - 1, ref - 2]
          when '?='; [ref - 1, ref]
          when '??'; [ref,     ref]
          end

        if text.index('insert - 1 line') == text.index('insert')
          # first line, replace is futile
          next_indent -= 1
        elsif cur_line =~ /\S/
          cur_indent = [0, cur_indent].max
          record.replace(
            'insert linestart',
            'insert lineend',
            (' ' * (cur_indent * 2)) << cur_line.lstrip
          )
        else # that was an empty line
          record.replace('insert linestart', 'insert lineend', '')
        end

        next_indent = [0, next_indent].max

        record.insert('insert lineend', "\n#{' ' * (next_indent * 2)}")
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
