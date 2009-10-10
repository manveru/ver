module VER
  # A custom widget for easier integration
  class Entry < Tk::Tile::Entry
    def quit
      Tk.exit
    end

    def value=(string)
      super
      Tk.event_generate(self, '<Modified>')
    end

    def delete(*args)
      super
      Tk.event_generate(self, '<Modified>')
    end

    def insert(*args)
      super
      Tk.event_generate(self, '<Modified>')
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

    def delete_char_left
      delete(cursor - 1)
    end

    def delete_char_right
      delete(cursor)
    end

    def go_char_left
      self.cursor = cursor - 1
    end

    def go_char_right
      self.cursor = cursor + 1
    end

    def go_word_left
      if index = value.rindex(/.\b\s/, cursor - 1)
        self.cursor = index
      else
        self.cursor = 0
      end
    end

    def go_word_right
      if match = value.match(/\s\b/, cursor)
        offset_from, offset_to = match.offset(0)
        self.cursor = offset_to
      else
        self.cursor = :end
      end
    end
  end
end