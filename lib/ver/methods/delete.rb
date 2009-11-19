module VER
  module Methods
    module Delete
      def change_motion(motion, count = 1)
        delete_motion(motion, count)
        start_insert_mode
      end

      def delete_motion(motion, count = 1)
        delete(*virtual_movement(motion, count))
      end

      def delete_line(count = 1)
        count.times do
          delete 'insert linestart', 'insert lineend + 1 char'
        end
      end

      def change_line(count = 1)
        delete_line(count)
        start_insert_mode
      end

      def delete_trailing_whitespace
        tag_all_trailing_whitespace
        execute :delete, *tag_ranges('invalid.trailing-whitespace').flatten
      end
    end
  end
end
