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

      class Char < Selection
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
