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

    ## Maintenance
    def style
      style = cget(:style)
      style.flatten.first if style
    end

    def quit(event = nil)
      VER.exit
    end

    def message(string)
      self.value = string
    end

    def error(string)
      self.value = string
    end

    def insert(*args)
      super
      Tk::Event.generate(self, '<<Inserted>>')
      Tk::Event.generate(self, '<<Modified>>')
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

    ## Insert

    def insert_string(event)
      insert(cursor, event.unicode)
    end

    # Insert X selection at cursor position
    def insert_selection(event)
      insert(cursor, Tk::Selection.get)
    end

    # Insert a literal tab character at cursor position
    def insert_tab(event)
      insert(cursor, "\t")
    end

    def transpose_chars(event)
      char = get[cursor]
      delete(cursor)
      insert(cursor - 1, char)
    end

    ## Delete

    def delete_motion(motion)
      delete(*virtual_movement(motion))
    end

    def kill_motion(motion)
      kill(*virtual_movement(motion))
    end

    def kill_prev_char(event)
      kill_motion :prev_char
    end

    def kill_next_char(event)
      kill_motion :next_char
    end

    def kill_prev_word(event)
      kill_motion :prev_word
    end

    def kill_next_word(event)
      kill_motion :next_word
    end

    def kill_end_of_line(event)
      kill_motion :end_of_line
    end

    ## Movement

    # Move to the start of the current line.
    def start_of_line(event)
      self.cursor = 0
    end

    # Move to the end of the entry line.
    def end_of_line(event)
      self.cursor = :end
    end

    # Move forward a character.
    def next_char(event)
      self.cursor += 1
    end

    # Move back a character.
    def prev_char(event)
      self.cursor -= 1
    end

    # Move forward to the end of the next word.
    # Words are composed of alphanumeric characters (letters and digits).
    def next_word(event)
      return unless md = get.match(FORWARD_WORD, cursor)
      self.cursor = md.offset(0).last
    end

    # Move back to the start of the current or previous word.
    # Words are composed of alphanumeric characters (letters and digits).
    def prev_word(event)
      line = get.reverse
      pos = get.size - cursor

      return unless md = line.match(BACKWARD_WORD, pos)
      self.cursor = (line.size - md.offset(0).last)
    end

    ## History

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

    ## Asking questions

    # Accept the line regardless of where the cursor is.
    # If this line is non-empty, it will be added to the history list.
    # If the line is a modified history line, the history line is restored to
    # its original state.
    def accept_line(event)
      line = get
      Tk::Event.generate(self, '<<AcceptLine>>')
      delete(0, :end)
    end

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
