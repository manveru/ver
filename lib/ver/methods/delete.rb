module VER
  class Buffer
    # Tag and delete all trailing whitespace in the {Buffer}.
    def delete_trailing_whitespace
      @invalid_trailing_whitespace.each_range do |range|
        range.delete
      end
    end
  end

  module Methods
    module Delete
      module_function

      # Given a +motion+, this method will execute a virtual movement and
      # the corresponding indices on given +buffer+.
      #
      # @param [Symbol String] motion name of a method acceptable for {virtual}
      #
      # @see Buffer::Insert.virtual
      # @see Buffer::Range.delete
      # @see Keymapped.minor_mode
      def changing(buffer, motion)
        buffer.at_insert.virtual(&motion).delete
        buffer.minor_mode(:control, :insert)
      end

      # Given a +motion+, this method will execute a virtual movement with the
      # +count+ argument and [delete] the corresponding indices.
      #
      # @param [Symbol String] motion name of a method acceptable for [virtual_movement]
      # @param [#to_i] count
      #
      # @see Buffer::Range.delete
      # @see Buffer::Insert.virtual
      def deleting(buffer, motion)
        buffer.at_insert.virtual(&motion).delete
      end

      # Given a +motion+, this method will execute a virtual movement with the
      # +count+ argument and [kill] the corresponding indices.
      #
      # @param [Symbol String] motion name of a method acceptable for [virtual_movement]
      # @param [#to_i] count
      #
      # @see kill
      # @see VER::Move#virtual_movement
      def killing(buffer, motion)
        buffer.at_insert.virtual(&motion).kill
      end

      # [word_right_end] goes to the last character, that is, the insert mark is
      # between the second to last and last character.
      # This means that the range to delete is off by one, account for it here.
      def change_word_right_end(buffer, count = buffer.prefix_count)
        range = buffer.at_insert.virtual(&:word_right_end)
        range.last += '1 chars'
        range.delete
        buffer.minor_mode(:control, :insert)
      end

      # Delete current line and upto +count+ subsequent lines.
      #
      # @param [#to_i] count Number of lines to delete
      #
      # @see delete
      # @see kill_line
      def delete_line(buffer, count = buffer.prefix_count)
        from = "insert linestart"
        to = "insert + #{count.abs - 1} lines lineend + 1 chars"
        buffer.range(from, to).delete
      end

      # Copy current line and upto +count+ subsequent lines and delete them.
      #
      # @param [#to_i] count Number of lines to kill
      #
      # @see kill
      # @see delete_line
      def kill_line(buffer, count = buffer.prefix_count)
        from = "insert linestart"
        to = "insert + #{count.abs - 1} lines lineend + 1 chars"
        buffer.range(from, to).kill
      end

      # Wrapper for [kill_line] that starts insert mode after killing +count+
      # lines. It also doesn't delete the newline.
      #
      # @param [#to_i] count Number of lines to kill
      #
      # @see kill_line
      def change_line(buffer, count = buffer.prefix_count)
        kill_line(buffer, count)
        buffer.minor_mode(:control, :insert)
      end

    end
  end
end
