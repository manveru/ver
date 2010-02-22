module VER
  class Text
    # Mostly a Mark, but has to generate Movement event and sometimes change
    # modes.
    class Insert < Mark
      def initialize(buffer)
        super(buffer, :insert)
      end

      def set(index)
        buffer.mark_set(self, index)
        Tk::Event.generate(buffer, '<<Movement>>')
      end
      alias index= set

      def end_of_line(count_or_mode = nil)
        case count_or_mode
        when Symbol
          set("#{self} display lineend")
          buffer.minor_mode(:control, count_or_mode)
        when nil
          set("#{self} lineend")
        else
          set("#{self} display lineend")
        end
      end

      # Same as {Mark.forward_jump}, but generate <<Movement>> event.
      def forward_jump(count)
        super
        Tk::Event.generate(buffer, '<<Movement>>')
      end

      # Same as {Mark.backward_jump}, but generate <<Movement>> event.
      def backward_jump(count)
        super
        Tk::Event.generate(buffer, '<<Movement>>')
      end

      # Go to previous line, maintaining the display char position.
      # Only on Insert, as {Buffer.up_down_line} tracks the position.
      def prev_line(count = buffer.prefix_count)
        up_down_line(-count.abs)
      end

      # Go to next line, maintaining the display char position.
      # Only on Insert, as {Buffer.up_down_line} tracks the position.
      def next_line(count = buffer.prefix_count)
        up_down_line(count.abs)
      end

      # Only on Insert, as {Buffer.up_down_line} tracks the position.
      def up_down_line(count)
        set(buffer.up_down_line(count))
      end

      def insert_newline_below
        return insert_indented_newline_below if buffer.options.autoindent
        super
        buffer.minor_mode(:control, :insert)
      end

      def insert_indented_newline_below
        super
        buffer.minor_mode(:control, :insert)
      end

      def insert_indented_newline_below
        super
        buffer.minor_mode(:control, :insert)
      end

      def insert_newline_above
        super
        buffer.minor_mode(:control, :insert)
      end
    end
  end
end
