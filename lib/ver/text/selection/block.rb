module VER
  class Text
    class Selection
      class Block < Selection
        def each
          return Enumerator.new(self, :each) unless block_given?

          each_range do |range|
            fy, fx, ty, tx = *range.first, *range.last
            yield fy, fx, ty, tx
          end
        end

        def mode_name
          :select_block
        end

        def refresh
          return unless @refresh
          start  = anchor.index
          insert = buffer.at_insert
          clear

          ly, lx, ry, rx =
            if insert > start
              [*insert, *start]
            else
              [*start, *insert]
            end

          from_y, to_y = [ly, ry].sort
          from_x, to_x = [lx, rx].sort

          ranges = []
          from_y.upto to_y do |y|
            ranges << "#{y}.#{from_x}" << "#{y}.#{to_x + 1}"
          end

          add(*ranges)
        end

        # Ask for string, then replace each line the selection spans with it.
        def replace_string_eol
          buffer.ask 'Replace selection with: ', do |answer, action|
            case action
            when :attempt
              if answer.size > 0
                replace_string_eol!(answer)
                :abort
              else
                buffer.warn "replacement required"
              end
            end
          end
        end

        def replace_string_eol!(string)
          buffer.undo_record do |record|
            each do |from_line, from_char, to_line, to_char|
              from_line.upto to_line do |line|
                buffer.replace("#{line}.#{from_char}", "#{line}.0 lineend", string)
              end
            end
          end
        end
      end # Block
    end # Selection
  end # Text
end # VER
