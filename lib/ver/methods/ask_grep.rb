module VER
  module Methods
    module AskGrep
      include Insert

      def insert_character(char)
        super
        view.update_choices
      end

      def insert_delete
        super
        view.update_choices
      end

      def insert_backspace
        super
        view.update_choices
      end

      def stop
        view.close
        View[:file].open
      end

      # TODO: Make highlight instead of selection
      def pick
        if found = view.pick
          view.close

          file_view = View[:file]
          file_view.buffer = found[:file]
          file_view.cursor = found[:cursor].clone
          file_view.selection = found[:cursor].clone
          file_view.open
        end
      end

      def up
        view.select_above
      end

      def down
        view.select_below
      end

      def left
        cursor.left
      end

      def right
        cursor.right
      end
    end
  end
end
