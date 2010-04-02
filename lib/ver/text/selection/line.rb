module VER
  class Text
    class Selection
      class Line < Selection
        def kill
          indices = []
          chunks = each_range.map do |range|
            indices << range.first << (range.last + '1 chars')
            buffer.get(*indices.last(2))
          end

          buffer.with_register do |register|
            register.value = chunks.at(1) ? chunks : chunks.first
          end

          buffer.delete(*indices)
          clear
          finish
        end

        def copy
          buffer.with_register do |register|
            register.value = buffer.get("#{self}.first", "#{self}.last + 1 chars")
          end

          buffer.insert = "#{self}.first"
          clear
          finish
        end

        def each
          return Enumerator.new(self, :each) unless block_given?

          each_range do |range|
            fy, fx, ty, tx = *range.first, *range.last

            fy.upto(ty) do |y|
              sy, sx = *buffer.index("#{y}.0 linestart")
              ey, ex = *buffer.index("#{y}.0 lineend")
              yield sy, sx, ey, ex
            end
          end
        end

        def mode_name
          :select_line
        end

        def refresh
          return unless @refresh
          start = anchor.index
          insert = buffer.at_insert
          clear

          if insert > start
            add(start.linestart, insert.lineend)
          else
            add(insert.linestart, start.lineend)
          end
        end
      end # Line
    end # Selection
  end # Text
end # VER
