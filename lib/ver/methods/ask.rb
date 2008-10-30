module VER
  module Methods
    module Ask
      include Switch, Buffer, Insert

      def up
      end

      def down
      end

      def left
        cursor.left
      end

      def right
        cursor.right
      end

      def stop
        view.close
        View[:file].open
      end

      def completion
        view.update_choices
        view.try_completion
      end

      def pick
        view.update_choices
        if answer = view.answer
          view.block.call(answer)
          view.close
          View[:file].open
        end
      end
    end
  end
end
