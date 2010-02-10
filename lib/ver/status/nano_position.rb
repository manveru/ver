module VER
  class Status
    class NanoPosition < Label
      def triggers
        ['<<Position>>']
      end

      def style=(config)
        configure(config)
      end

      def to_s
        line_now     = text.count(1.0, :insert, :lines) + 1
        line_total   = text.count(1.0, :end, :lines)
        line_percent = ((100.0 / line_total) * line_now)
        line_percent = 0 if line_percent.nan?

        col_now     = text.count('insert linestart', :insert, :chars) + 1
        col_total   = text.count('insert linestart', 'insert lineend', :chars) + 1
        col_percent = ((100.0 / col_total) * col_now)
        col_percent = 0 if col_percent.nan?

        char_now   = text.count(1.0, :insert, :chars)
        char_total = text.count(1.0, :end, :chars) - 1
        char_percent = ((100.0 / char_total) * char_now)
        char_percent = 0 if char_percent.nan?

        inner = "%d/%d (%d%%), %d/%d (%d%%), %d/%d (%d%%)" % [
          line_now, line_total, line_percent.round,
          col_now,  col_total,  col_percent.round,
          char_now, char_total, char_percent.round,
        ]

        "[ #{inner} ]"
      end
    end
  end
end
