module VER
  # A custom widget for easier integration
  #
  # The style related things are needed for Tk versions around 8.5.7, which is
  # what everybody is using currently.
  # It doesn't GC styles of widgets that are no longer used, so if we simply keep
  # using new style names, we would eventually run out of memory.
  # A small leak, but better we cover this now than tracking it down later.
  # Tk should get some user states, called like 'user1', 'user2', 'user3', that
  # would allow some flexibility, but still won't be able to represent every mode.
  class Entry < Tk::Tile::Entry
    space, word = /[^[:alnum:]]+/, /[[:alnum:]]/
    FORWARD_WORD = /#{space}+#{word}|#{word}+#{space}+#{word}/
    BACKWARD_WORD = /#{word}+/

    def style
      style = cget(:style)
      style.flatten.first if style
    end

    def quit
      VER.exit
    end

    def value=(string)
      execute_only(:delete, 0, :end)
      execute_only(:insert, 0, string)
      Tk::Event.generate(self, '<<Replaced>>')
      Tk::Event.generate(self, '<<Modified>>')
    end

    def delete(*args)
      super
      Tk::Event.generate(self, '<<Deleted>>')
      Tk::Event.generate(self, '<<Modified>>')
    end
    alias kill delete # nobody wants to copy that way, right? ;)

    def insert(*args)
      super
      Tk::Event.generate(self, '<<Inserted>>')
      Tk::Event.generate(self, '<<Modified>>')
    end

    def message(string)
      self.value = string
    end

    def error(string)
      self.value = string
    end

    def insert_string(string)
      insert cursor, string
    end

    def noop(*args)
    end

    # Move to the start of the current line.
    def beginning_of_line
      self.cursor = 0
    end

    # Move to the end of the line.
    def end_of_line
      self.cursor = :end
    end

    # Move forward a character.
    def forward_char(count = 1)
      self.cursor += count
    end

    # Move back a character.
    def backward_char(count = 1)
      self.cursor -= count
    end

    # Move forward to the end of the next word.
    # Words are composed of alphanumeric characters (letters and digits).
    def forward_word(count = 1)
      count.times do
        return unless md = get.match(FORWARD_WORD, cursor)
        self.cursor = md.offset(0).last
      end
    end

    # Move back to the start of the current or previous word.
    # Words are composed of alphanumeric characters (letters and digits).
    def backward_word(count = 1)
      line = get.reverse
      count.times do
        pos = get.size - cursor

        return unless md = line.match(BACKWARD_WORD, pos)
        self.cursor = (line.size - md.offset(0).last)
      end
    end

    # Accept the line regardless of where the cursor is.
    # If this line is non-empty, it will be added to the history list.
    # If the line is a modified history line, the history line is restored to
    # its original state.
    def accept_line
      line = get
      @history.unshift(line) unless line.empty?
      @history_index = nil
      Event.generate(self, '<<AcceptLine>>')
      delete 0, :end
    end

    # Fetch the previous command from the history list, moving back in the list.
    def previous_history
      history_size = @history.size

      if @history_index && @history_index < history_size
        @history_index = [@history_index + 1, history_size - 1].min
      else
        @history_index = 0
      end

      self.value = @history[@history_index]
    end

    # Fetch the next command from the history list, moving forward in the list.
    def next_history
      if @history_index && @history_index > 0
        @history_index -= 1
      else
        @history_index = @history.size - 1
      end

      self.value = @history[@history_index]
    end

    def beginning_of_history
      @history_index = @history.size - 1
      self.value = @history[@history_index]
    end

    def end_of_history
      @history_index = 0
      self.value = @history[@history_index]
    end

    def delete_char
      delete(cursor)
    end

    def backward_delete_char(yank = nil)
      return if cursor == 0

      if yank
        @killring.unshift get[cursor - 2]
      end

      delete(cursor - 1)
    end

    # Delete the character under the cursor, unless the cursor is at the end of
    # the line, in which case the character behind the cursor is deleted.
    def forward_backward_delete_char
      pos = cursor

      if index(:end) == pos
        delete(cursor - 1)
      else
        delete(cursor)
      end
    end

    def transpose_chars
      char = get[cursor]
      delete(cursor)
      insert(cursor - 1, char)
    end

    def delete_motion(motion, count = 1)
      delete(*virtual_movement(motion, count))
    end

    def kill_motion(motion, count = 1)
      kill(*virtual_movement(motion, count))
    end

    # Accept the line regardless of where the cursor is.
    # If this line is non-empty, it will be added to the history list.
    # If the line is a modified history line, the history line is restored to
    # its original state.
    def accept_line
      line = get
      Event.generate(self, '<<AcceptLine>>')
      delete(0, :end)
    end

    # Move to end of the entry line
    def end_of_line
      self.cursor = :end
    end

    # Insert X selection at cursor position
    def insert_selection
      insert(cursor, Tk::Selection.get)
    end

    # Insert a literal tab character at cursor position
    def insert_tab
      insert(cursor, "\t")
    end

    # Move forward a character.
    def next_char(count = 1)
      self.cursor += count
    end

    # Move forward to the end of the next word.
    # Words are composed of alphanumeric characters (letters and digits).
    def next_word(count = 1)
      count.times do
        return unless md = get.match(FORWARD_WORD, cursor)
        self.cursor = md.offset(0).last
      end
    end

    # Move backward to the previous character.
    def prev_char(count = 1)
      self.cursor -= count
    end

    # Move back to the start of the current or previous word.
    # Words are composed of alphanumeric characters (letters and digits).
    def prev_word(count = 1)
      line = get.reverse
      count.times do
        pos = get.size - cursor

        return unless md = line.match(BACKWARD_WORD, pos)
        self.cursor = (line.size - md.offset(0).last)
      end
    end

    # Move to the start of the current line.
    def start_of_line
      self.cursor = 0
    end

    def transpose_chars
      char = get[entry.cursor]
      delete(cursor)
      insert(cursor - 1, char)
    end

    def kill_motion(motion, count = 1)
      kill(*virtual_movement(motion, count))
    end

    def insert_string(string)
      insert(cursor, string)
    end

    def ask_abort
      self.question = ''
      self.value = self.backup_value
      text.focus
    end

    def ask_submit
      answer = self.value
      # history = HISTORY[@question]
      # history.uniq!
      # history << answer
      self.question = ''

      case result = callback.call(answer)
      when String
        message(result)
      when Symbol
        result
      else
        message(result.inspect)
      end
    end

    private

    def virtual_movement(name, count = 1)
      pos = cursor
      __send__(name, count)
      mark = cursor
      self.cursor = pos
      return [pos, mark].sort
    rescue => ex
      VER.error(ex)
    end
  end
end
