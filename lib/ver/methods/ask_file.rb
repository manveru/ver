module VER
  module Methods
    module AskFile
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

      def pick
        if file = view.pick
          view.close
          View[:file].buffer = file
          View[:file].open
        end
      end

      def up
        view.select_above
      end

      def down
        view.select_below
      end

      def completion
        view.expand_input
      end
    end
  end
end
