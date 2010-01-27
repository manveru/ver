module VER::Methods
  module Delete
    class << self
      def change_motion(text, motion, count = text.prefix_count)
        delete_motion(text, motion, count)
        text.minor_mode(:control, :insert)
      end

      # Given a +motion+, this method will execute a virtual movement with the
      # +count+ argument and [delete] the corresponding indices.
      #
      # @param [Symbol String] motion name of a method acceptable for [virtual_movement]
      # @param [#to_i] count
      #
      # @see delete
      # @see VER::Move::virtual_movement
      def delete_motion(text, motion, count = text.prefix_count)
        movement = Move.virtual(text, motion, count)
        delete(text, *movement)
      end

      # Given a +motion+, this method will execute a virtual movement with the
      # +count+ argument and [kill] the corresponding indices.
      #
      # @param [Symbol String] motion name of a method acceptable for [virtual_movement]
      # @param [#to_i] count
      #
      # @see kill
      # @see VER::Move#virtual_movement
      def kill_motion(text, motion, count = text.prefix_count)
        movement = Move.virtual(text, motion, count)
        kill(text, *movement)
      end

      # [word_right_end] goes to the last character, that is, the insert mark is
      # between the second to last and last character.
      # This means that the range to delete is off by one, account for it here.
      def change_word_right_end(text, count = text.prefix_count)
        index = Move.index_at_word_right_end(text, count)
        delete(text, :insert, index + 1)
        text.minor_mode(:control, :insert)
      end

      # Delete current line and upto +count+ subsequent lines.
      #
      # @param [#to_i] count Number of lines to delete
      #
      # @see delete
      # @see kill_line
      def delete_line(text, count = text.prefix_count)
        count = count.abs - 1
        from = text.index('insert linestart')
        to = "#{from.y + count}.#{from.x} lineend + 1 char"
        delete(text, from, text.index(to))
      end

      # Copy current line and upto +count+ subsequent lines and delete them.
      #
      # @param [#to_i] count Number of lines to kill
      #
      # @see kill
      # @see delete_line
      def kill_line(text, count = text.prefix_count)
        count = count.abs - 1
        from = text.index('insert linestart')
        to = "#{from.y + count.to_i}.#{from.x} lineend + 1 char"
        kill(text, from, text.index(to))
      end

      # Wrapper for [kill_line] that starts insert mode after killing +count+
      # lines. It also doesn't delete the newline.
      #
      # @param [#to_i] count Number of lines to kill
      #
      # @see kill_line
      def change_line(text, count = text.prefix_count)
        count = count.abs - 1
        from = text.index('insert linestart')
        to = "#{from.y + count}.#{from.x} lineend"
        kill(text, from, text.index(to))
        text.minor_mode(:control, :insert)
      end

      # Tag and delete all trailing whitespace in the current buffer.
      def delete_trailing_whitespace(text)
        ranges = text.tag_ranges('invalid.trailing-whitespace').flatten
        text.execute(:delete, *ranges) unless ranges.empty?
      end

      # Delete text between +indices+
      def delete(text, *indices)
        indices_size = indices.size
        return if indices_size == 0

        Undo.record text do |record|
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
      def kill(text, *indices)
        if indices.size > 2
          deleted = indices.each_slice(2).map{|left, right|
            text.get(left, right) }
        else
          deleted = text.get(*indices)
        end

        Clipboard.copy(text, deleted)
        delete(text, *indices)
      end
    end
  end
end
