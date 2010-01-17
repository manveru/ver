module VER::Methods
  module Readline
    class << self
      def accept_line(widget) widget.accept_line end
      def beginning_of_history(widget) widget.beginning_of_history end
      def end_of_history(widget) widget.end_of_history end
      def end_of_line(widget) widget.end_of_line end
      def insert_selection(widget) widget.insert_selection end
      def insert_tab(widget) widget.insert_tab end
      def next_char(widget) widget.next_char end
      def next_history(widget) widget.next_history end
      def next_word(widget) widget.next_word end
      def prev_char(widget) widget.prev_char end
      def prev_history(widget) widget.prev_history end
      def prev_word(widget) widget.prev_word end
      def start_of_line(widget) widget.start_of_line end
      def transpose_chars(widget) widget.transpose_chars end
      def kill_motion(motion, widget) widget.kill_motion(motion) end
      def insert_string(widget, string) widget.insert_string(string) end
    end
  end
end
