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
    space = /[^[:alnum:]]+/
    word = /[[:alnum:]]/
    FORWARD_WORD = /#{space}+#{word}|#{word}+#{space}+#{word}/
    BACKWARD_WORD = /#{word}+/

    def events
      major_mode.event_history
    end

    def event
      major_mode.event_history.last
    end

    ## Maintenance
    def style
      style = cget(:style)
      style.flatten.first if style
    end

    def message(*args)
      VER.message(*args)
    end

    def error(*args)
      VER.warn(*args)
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

    def kill(*args)
      Clipboard.dwim = get(*args)
      delete(*args)
    end

    def cursor=(pos)
      selection_clear
      super
      Tk::Event.generate(self, '<<Movement>>')
    end

    ## Insert

    def insert_string(event = self.event)
      insert(cursor, event.unicode)
    end

    # Insert X selection at cursor position
    def insert_selection
      insert(cursor, Tk::Selection.get(type: 'UTF8_STRING'))
    end

    # Insert a literal tab character at cursor position
    def insert_tab
      insert(cursor, "\t")
    end

    def paste
      return unless content = VER::Clipboard.get
      insert(cursor, content)
    end

    def transpose_chars
      char = get[cursor]
      delete(cursor)
      insert(cursor - 1, char)
    end

    ## Delete

    def deleting(motion)
      delete(*virtual_movement(motion))
    end

    def killing(motion)
      kill(*virtual_movement(motion))
    end

    def delete_prev_char
      deleting :prev_char
    end

    def delete_next_char
      deleting :next_char
    end

    def delete_prev_word
      deleting :prev_word
    end

    def delete_next_word
      deleting :next_word
    end

    def kill_end_of_line
      killing :end_of_line
    end

    ## Selection

    def sel_prev_char
      # bind TEntry <Shift-Key-Left> 		{ ttk::entry::Extend %W prevchar }
      Tk.execute_only('ttk::entry::Extend', self, :prevchar)
    end

    def sel_next_char
      # bind TEntry <Shift-Key-Right>		{ ttk::entry::Extend %W nextchar }
      Tk.execute_only('ttk::entry::Extend', self, :nextchar)
    end

    def sel_prev_word
      # bind TEntry <Shift-Control-Key-Left>	{ ttk::entry::Extend %W prevword }
      Tk.excute_only('ttk::entry::Extend', self, :prevword)
    end

    def sel_next_word
      # bind TEntry <Shift-Control-Key-Right>	{ ttk::entry::Extend %W nextword }
      Tk.execute_only('ttk::entry::Extend', self, :nextword)
    end

    def sel_start_of_line
      # bind TEntry <Shift-Key-Home>		{ ttk::entry::Extend %W home }
      Tk.execute_only('ttk::entry::Extend', self, :home)
    end

    def sel_end_of_line
      # bind TEntry <Shift-Key-End>		{ ttk::entry::Extend %W end }
      Tk.execute_only('ttk::entry::Extend', self, :end)
    end

    ## Movement

    # Move to the start of the current line.
    def start_of_line
      self.cursor = 0
    end

    # Move to the end of the entry line.
    def end_of_line
      self.cursor = :end
    end

    # Move forward a character.
    def next_char
      self.cursor += 1
    end

    # Move back a character.
    def prev_char
      self.cursor -= 1
    end

    # Move forward to the end of the next word.
    # Words are composed of alphanumeric characters (letters and digits).
    def next_word
      return unless md = get.match(FORWARD_WORD, cursor)
      self.cursor = md.offset(0).last
    end

    # Move back to the start of the current or previous word.
    # Words are composed of alphanumeric characters (letters and digits).
    def prev_word
      line = get.reverse
      pos = get.size - cursor

      return unless md = line.match(BACKWARD_WORD, pos)
      self.cursor = (line.size - md.offset(0).last)
    end

    ## History

    # Fetch the previous command from the history list, moving back in the list.
    def previous_history
      history_size = @history.size

      @history_index = if @history_index && @history_index < history_size
                         [@history_index + 1, history_size - 1].min
                       else
                         0
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

    # Accept the line regardless of where the cursor is.
    # If this line is non-empty, it will be added to the history list.
    # If the line is a modified history line, the history line is restored to
    # its original state.
    def accept_line
      line = get
      Tk::Event.generate(self, '<<AcceptLine>>')
      delete(0, :end)
    end

    def virtual_movement(name, *args)
      pos = cursor
      __send__(name, *args)
      mark = cursor
      self.cursor = pos
      return [pos, mark].sort
    rescue StandardError => ex
      VER.error(ex)
    end
  end
end
