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
    STYLE_NAME_REGISTER = []
    STYLE_NAME_POOL = []

    def self.obtain_style_name
      unless style_name = STYLE_NAME_POOL.shift
        begin
          id = SecureRandom.hex
          style_name = "#{id}.#{self}.TEntry"
        end while STYLE_NAME_REGISTER.include?(style_name)
        STYLE_NAME_REGISTER << style_name
      end

      style_name
    end

    def self.return_style_name(style_name)
      STYLE_NAME_POOL << style_name
    end

    def style
      style = cget(:style)
      style.flatten.first if style
    end

    def quit
      VER.exit
    end

    def value=(string)
      delete(0, :end)
      insert(0, string)
      Tk::Event.generate(self, '<<Modified>>')
    end

    def delete(*args)
      super
      Tk::Event.generate(self, '<<Modified>>')
    end

    def insert(*args)
      super
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