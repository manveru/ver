module VER
  class Status
    class Percent < Position
      def to_s
        here = text.count(1.0, :insert, :lines)
        total = text.count(1.0, :end, :lines)
        percent = ((100.0 / total) * here).round

        case percent
        when 100, 99; 'Bot'
        when 0      ; 'Top'
        else        ; '%2d%%' % percent
        end
      end
    end
  end
end
