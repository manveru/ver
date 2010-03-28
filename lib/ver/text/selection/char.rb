module VER
  class Text
    class Selection
      class Char < Selection
        def mode_name
          :select_char
        end

        # Using delete, since the sel tag cannot be deleted anyway.
        def delete
          buffer.delete("sel.first", "sel.last")
          finish
        end


        # For every chunk selected, this yields the corresponding coordinates as
        # [from_y, from_x, to_y, to_x].
        # It takes into account the current selection mode.
        # In many cases from_y and to_y are identical, but don't rely on this.
        #
        # @see each_line
        def each
          return Enumerator.new(self, :each) unless block_given?

          each_range do |range|
            fy, fx, ty, tx = *range.first, *range.last
            p [fy, fx, ty, tx]

            if fy == ty
              yield fy, fx, ty, tx
            elsif (ty - fy) == 1
              efy, efx = *buffer.index("#{fy}.#{fx} lineend")
              sty, stx = *buffer.index("#{ty}.#{tx} linestart")
              yield fy, fx, efy, efx
              yield sty, stx, ty, tx
            else
              efy, efx = *buffer.index("#{fy}.#{fx} lineend")
              yield fy, fx, efy, efx

              ((fy + 1)...ty).each do |y|
                sy, sx = *buffer.index("#{y}.0 linestart")
                ey, ex = *buffer.index("#{y}.0 lineend")
                yield sy, sx, ey, ex
              end

              sty, stx = *buffer.index("#{ty}.#{tx} linestart")
              yield sty, stx, ty, tx
            end
          end
        end

        def refresh
          return unless @refresh
          start  = anchor.index
          insert = buffer.at_insert
          clear

          if insert > start
            add(start, insert + '1 chars')
          else
            add(insert, start + '1 chars')
          end
        end

        # we assume char selection is always continuous, so no need to check the
        # ranges.
        def replace_with_clipboard
          return unless content = Clipboard.dwim

          start = buffer.index('sel.first')

          case content
          when Array
            replace(content.join("\n"))
          when String
            replace(content)
          else
            raise "Unknown kind of clipboard content: %p" % [content]
          end

          finish
          buffer.insert = start
        end

        def replace_with_string(string, expand)
          insert = buffer.index(:insert)
          anchor = self.anchor.index

          from, to = buffer.index('sel.first'), buffer.index('sel.last')

          buffer.undo_record do |record|
            if expand
              length = buffer.count(from, to, :displaychars)
              record.replace(from, to, string * length)
            else
              record.replace(from, to, string)
            end
          end

          self.anchor.index = anchor
          refresh
        end

        # assume that the selection is continuous... :)
        # TODO: add this for all other selections
        def join(separator = ' ')
          buffer.undo_record do |record|
            each_range do |range|
              # go backwards to avoid line number shifting
              range.last.line.pred.downto range.first.line do |line|
                buffer.insert = "#{line}.0 lineend"
                record.replace('insert', 'insert + 1 chars', separator)
              end
            end
          end

          clear
          finish
        end
      end
    end
  end
end
