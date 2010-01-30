module VER
  class Buffer
    # This sucks, should we go method_missing?
    class Entry < VER::Entry
      include Keymapped

      attr_accessor :list_buffer

      def pick_first
        list_buffer.pick_first
      end

      def pick_selection
        list_buffer.pick_selection
      end

      def cancel
        list_buffer.cancel
      end

      def line_up
        list_buffer.line_up
      end

      def line_down
        list_buffer.line_down
      end

      def completion
        list_buffer.completion
      end
    end
  end
end
