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

      # Kill contents of the line at position, switch from control to
      # insert mode.
      # Always leaves an empty line and sets the insert mark inside that.
      def change_line(count = buffer.prefix_count)
        from, to = "insert linestart", "insert + #{count - 1} lines lineend"
        range = buffer.range(buffer.index(from), buffer.index(to))
        range.kill
        buffer.minor_mode(:control, :insert)
      end

      def change(count = buffer.prefix_count)
        from, to = "insert", "insert + #{count} displaychars"
        range = buffer.range(buffer.index(from), buffer.index(to))
        range.kill
        buffer.minor_mode(:control, :insert)
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

      def insert_char_above
        index = buffer.index("#{self} - 1 lines")

        if index.line < line && index.char == char
          char = index.get
          buffer.insert(self, char) unless char == "\n"
        end
      end

      def insert_char_below
        index = buffer.index("#{self} + 1 lines")

        if index.line > line && index.char == char
          char = index.get
          buffer.insert(self, char) unless char == "\n"
        end
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

      def insert_digraph
        buffer.major_mode.read 2 do |*events|
          require 'ver/digraphs'
          first, last = events.first.unicode, events.last.unicode
          if found = DIGRAPHS["#{first}#{last}"]
          elsif found = DIGRAPHS["#{last}#{first}"]
          else
            # some kinda error?
          end

          buffer.insert(self, found) if found
        end
      end

      # Set insert mark to a position in the previous page in buffer.
      # Also sets the insert mark to the position it used to be on the old view.
      #
      # @param [Integer] count
      #   Number of pages to scroll
      def prev_page(count = buffer.prefix_count)
        set(buffer.tk_prev_page_pos(count))
      end

      # Scroll down the view of buffer by +count+ number of pages.
      # Also sets the insert mark to the position it used to be on the old view.
      #
      # @param [Integer] count
      #   Number of pages to scroll
      def next_page(count = buffer.prefix_count)
        set(buffer.tk_next_page_pos(count))
      end

      def toggle_case!
        super
      end
    end
  end
end
