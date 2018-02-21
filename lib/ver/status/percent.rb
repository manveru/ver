module VER
  class Status
    class Percent < Position
      def to_s
        here = buffer.count(1.0, :insert, :lines)
        total = buffer.count(1.0, :end, :lines)
        percent = ((100.0 / total) * here).round

        case percent
        when 100, 99 then 'Bot'
        when 0 then 'Top'
        else
          '%2d%%' % [percent]
        end
      end
    end
  end
end
