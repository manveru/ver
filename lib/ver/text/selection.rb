module VER
  class Text
    class Selection < Tag
      def self.enter(buffer, old_mode, new_mode)
        buffer.at_sel.enter(old_mode, new_mode)
      end

      def self.leave(buffer, old_mode, new_mode)
        buffer.at_sel.leave(old_mode, new_mode)
      end

      attr_accessor :mode

      def initialize(buffer, refresh = true, mode = :select_char)
        super(buffer, :sel)
        @mode = mode
        @anchor = buffer.mark(:sel_anchor)
        refresh() if @refresh = refresh
      end

      def enter(old_mode, new_mode)
        reset unless old_mode.name =~ /^select_/
        new_mode_name = new_mode.name

        buffer.at_sel = sel =
          case new_mode_name
          when /^select_char/;  Char.new(buffer)
          when /^select_line/;  Line.new(buffer)
          when /^select_block/; Block.new(buffer)
          else; raise ArgumentError, "Unknown mode: %p"
          end

        sel.mode = new_mode_name.to_sym
      end

      def leave(old_mode, new_mode)
        return if new_mode.name =~ /^select/
        @refresh = false
        clear
        @anchor.unset
      end

      def each_line
        return Enumerator.new(self, :each_line) unless block_given?

        each_range do |range|
          fy, fx, ty, tx = *range.first, *range.last
          fy.upto(ty) do |y|
            yield y, fx, tx
          end
        end
      end

      def reset
        clear
        @anchor.index = :insert
      end

      def clear
        tag_remove('1.0', 'end')
      end

      def finish
        buffer.minor_mode(mode, :control)
      end

      # Convert all characters within the selection to lower-case using
      # String#downcase.
      # Usually only works for alphabetic ASCII characters.
      def lower_case
        buffer.undo_record do |record|
          each_range do |range|
            record.replace(*range, range.get.chomp.downcase)
          end
        end
      end
      alias downcase! lower_case

      # Convert all characters within the selection to upper-case using
      # String#upcase.
      # Usually only works for alphabetic ASCII characters.
      def upper_case
        buffer.undo_record do |record|
          each_range do |range|
            record.replace(*range, range.get.chomp.upcase)
          end
        end
      end
      alias upcase! upper_case

      # Toggle case within the selection.
      # This only works for alphabetic ASCII characters, no other encodings.
      def toggle_case
        buffer.undo_record do |record|
          each_range do |range|
            record.replace(*range, range.get.chomp.tr('a-zA-Z', 'A-Za-z'))
          end
        end
      end

      # Using delete, since the sel tag cannot be deleted anyway.
      def delete
        buffer.undo_record do |record|
          ranges = []
          each_range{|range| ranges.push(*range) }
          record.delete(*ranges)
        end

        finish
      end

      def kill
        super
        finish
      end

      def wrap
        super
        finish
      end

      def indent
        indent_size = buffer.options.shiftwidth
        indent = ' ' * indent_size

        buffer.undo_record do |record|
          each_line do |y, fx, tx|
            tx = fx + indent_size
            next if buffer.get("#{y}.#{fx}", "#{y}.#{tx}").empty?
            record.insert("#{y}.#{fx}", indent)
          end
        end

        refresh
      end

      def unindent
        indent_size = buffer.options.shiftwidth
        indent = ' ' * indent_size
        queue = []

        each_line do |y, fx, tx|
          tx = fx + indent_size
          left, right = "#{y}.#{fx}", "#{y}.#{tx}"
          next unless buffer.get(left, right) == indent
          queue << left << right
        end

        buffer.delete(*queue)
        refresh
      end

      class Char < Selection
        # For every chunk selected, this yields the corresponding coordinates as
        # [from_y, from_x, to_y, to_x].
        # It takes into account the current selection mode.
        # In many cases from_y and to_y are identical, but don't rely on this.
        #
        # @see each_line
        def each
          return Enumerator.new(self, :each) unless block_given?

          each_range do |range|
            (fy, fx), (ty, tx) = *range.first, *range.last

            if fy == ty
              yield fy, fx, ty, tx
            elsif (ty - fy) == 1
              efy, efx = text.index("#{fy}.#{fx} lineend").split
              sty, stx = text.index("#{ty}.#{tx} linestart").split
              yield fy, fx, efy, efx
              yield sty, stx, ty, tx
            else
              efy, efx = text.index("#{fy}.#{fx} lineend").split
              yield fy, fx, efy, efx

              ((fy + 1)...ty).each do |y|
                sy, sx = text.index("#{y}.0 linestart").split
                ey, ex = text.index("#{y}.0 lineend").split
                yield sy, sx, ey, ex
              end

              sty, stx = text.index("#{ty}.#{tx} linestart").split
              yield sty, stx, ty, tx
            end
          end
        end

        def refresh
          return unless @refresh
          start = buffer.index("sel_anchor")
          insert = buffer.at_insert
          clear

          if insert > start
            add(start, insert + '1 chars')
          else
            add(insert, start + '1 chars')
          end
        end
      end

      class Line < Selection
        def each
          return Enumerator.new(self, :each) unless block_given?

          each_range do |range|
            (fy, fx), (ty, tx) = *range.first, *range.last

            fy.upto(ty) do |y|
              sy, sx = text.index("#{y}.0 linestart").split
              ey, ex = text.index("#{y}.0 lineend").split
              yield sy, sx, ey, ex
            end
          end
        end

        def refresh
          return unless @refresh
          start = buffer.index("sel_anchor")
          insert = buffer.at_insert
          clear

          if insert > start
            add(start.linestart, insert.lineend)
          else
            add(insert.linestart, start.lineend)
          end
        end
      end

      class Block < Selection
        def each
          return Enumerator.new(self, :each) unless block_given?

          each_range do |range|
            (fy, fx), (ty, tx) = *range.first, *range.last
            yield fy, fx, ty, tx
          end
        end

        def refresh
          return unless @refresh
          start = buffer.index(:sel_anchor)
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
      end
    end
  end
end
