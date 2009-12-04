module VER
  module Methods
    module Delete
      def change_motion(motion, count = 1)
        delete_motion(motion, count)
        start_insert_mode
      end

      # Given a +motion+, this method will execute a virtual movement with the
      # +count+ argument and [delete] the corresponding indices.
      #
      # @param [Symbol String] motion name of a method acceptable for [virtual_movement]
      # @param [#to_i] count
      #
      # @see delete
      # @see VER::Move#virtual_movement
      def delete_motion(motion, count = 1)
        delete(*virtual_movement(motion, count))
      end

      # Given a +motion+, this method will execute a virtual movement with the
      # +count+ argument and [kill] the corresponding indices.
      #
      # @param [Symbol String] motion name of a method acceptable for [virtual_movement]
      # @param [#to_i] count
      #
      # @see kill
      # @see VER::Move#virtual_movement
      def kill_motion(motion, count = 1)
        kill(*virtual_movement(motion, count))
      end

      # Delete current line and upto +count+ subsequent lines.
      #
      # @param [#to_i] count Number of lines to delete
      #
      # @see delete
      # @see kill_line
      def delete_line(count = 1)
        from = index('insert linestart')
        count = count.abs - 1
        to = index("#{from.y + count}.#{from.x} lineend + 1 char")
        delete(from, to)
      end

      # Copy current line and upto +count+ subsequent lines and delete them.
      #
      # @param [#to_i] count Number of lines to kill
      #
      # @see kill
      # @see delete_line
      def kill_line(count = 1)
        from = index('insert linestart')
        count = count.abs - 1
        to = index("#{from.y + count.to_i}.#{from.x} lineend + 1 char")
        kill(from, to)
      end

      # Wrapper for [kill_line] that starts insert mode after killing +count+
      # lines.
      #
      # @param [#to_i] count Number of lines to kill
      #
      # @see kill_line
      # @see start_insert_mode
      def change_line(count = 1)
        kill_line(count)
        start_insert_mode
      end

      # Tag and delete all trailing whitespace in the current buffer.
      def delete_trailing_whitespace
        tag_all_trailing_whitespace
        execute :delete, *tag_ranges('invalid.trailing-whitespace').flatten
      end

      # Delete text between +indices+
      def delete(*indices)
        indices_size = indices.size
        return if indices_size == 0

        undo_record do |record|
          if indices_size == 1
            record.delete(indices.first)
          else
            indices.each_slice(2) do |from, to|
              next if from == to
              record.delete(from, to)
            end
          end
        end
      end

      # Copy text between +indices+ and delete it.
      #
      # @param [Array<Text::Index, String, Symbol>] indices
      #   one or more indices within the buffer, must be an even number of
      #   indices if more than one.
      def kill(*indices)
        if indices.size > 2
          deleted = indices.each_slice(2).map{|left, right| get(left, right) }
        else
          deleted = get(*indices)
        end

        copy(deleted)
        delete(*indices)
      end
    end
  end
end
