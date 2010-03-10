module VER
  # This is used to represent events.
  # It also represents the minimum required properties for events.
  #
  # The reason we don't use the default Tk::Event::Data is to compensate for
  # differences of platforms and to have correct values for the event even if
  # we generate them in specs.
  class Event < Struct.new(:pattern, :keysym, :unicode)
    PATTERN = {}
    UNICODE  = Hash.new{|h,k| h[k] = Set.new }
    KEYSYM   = Hash.new{|h,k| h[k] = Set.new }

    def self.each(&block)
      PATTERN.values.each(&block)
    end

    def self.pattern(pattern, keysym, unicode)
      event = new(pattern, keysym, unicode)
      PATTERN[event.pattern] = event
      UNICODE[event.unicode] << event
      KEYSYM[event.keysym] << event
      event
    end

    def self.fake(alias_pattern, keysym, unicode = '')
      event = pattern("<#{alias_pattern}>", keysym, unicode)
      MODIFIERS.each{|mod| pattern("<#{mod}-#{alias_pattern}>", keysym, unicode) }
      event
    end

    # given a <pattern>, this returns the event for this pattern.
    # given a unicode char, returns the event with shortest pattern.
    def self.[](string)
      if string =~ /^<(.*)>$/
        PATTERN.fetch(string)
      elsif string.size == 1
        UNICODE.fetch(string).min_by{|event| event.pattern.size }
      else # it may be keysym, but let's try to make it pattern instead
        PATTERN.fetch("<#{string}>")
      end
    rescue KeyError => ex
      capture(string)
    end

    def self.key?(string)
      if string =~ /^<(.*)>$/
        PATTERN.fetch(string)
      elsif string.size == 1
        UNICODE.fetch(string).min_by{|event| event.pattern.size }
      else # it may be keysym, but let's try to make it pattern instead
        PATTERN.fetch("<#{string}>")
      end

      true
    rescue KeyError
      false
    end

    def self.capture(pattern)
      @entry ||=
        begin
          @toplevel = Tk::Toplevel.new
          @counter = 5
          label = Tk::Tile::Label.new(
            @toplevel, text: 'Synchronizing keymap to events...')
          label.pack
          entry = Tk::Entry.new(@toplevel)
          entry.pack
          entry.bind('<Map>'){ entry.focus }
          countdown = lambda{
            label.configure(text: "Synchronizing keymap to events... #@counter")
            if @counter <= 0
              persist!
              @toplevel.destroy
              @toplevel = @entry = nil
            else
              @counter -= 1
              Tk::After.ms(1000, &countdown)
            end
          }
          Tk::After.ms(500, &countdown)
          entry
        end

      @entry.bind(pattern){|event|
        pattern(event.pattern, event.keysym, event.unicode)
        Tk.callback_break
      }

      until self.key?(pattern)
        @counter = 3
        Tk.update
        Tk::Event.generate(@entry, pattern, when: :now)
        Tk.update
      end

      self[pattern]
    end

    def self.persist!
      path = Pathname('~/.config/ver/.events').expand_path
      path.open('w+:BINARY'){|io| io.write(Marshal.dump(PATTERN)) }
    end

    def self.load!
      path = Pathname('~/.config/ver/.events').expand_path
      path.open('r:BINARY'){|io|
        pattern = Marshal.load(io.read)
        pattern.each{|sym, event|
          PATTERN[event.pattern] = event
          UNICODE[event.unicode] << event
          KEYSYM[event.keysym] << event
        }
      }
    rescue => ex
      l ex
    end

    def initialize(pattern, keysym, unicode)
      self.pattern = convert_pattern(pattern)
      self.keysym  = convert_keysym(keysym)
      self.unicode = convert_unicode(unicode)
    end

    # Adjust
    def convert_pattern(pattern)
      pattern
    end

    def convert_keysym(keysym)
      keysym
    end

    def convert_unicode(unicode)
      unicode
    end

    ('a'..'z').each{|chr| pattern(chr, chr, chr) }
    ('A'..'Z').each{|chr| pattern(chr, chr, chr) }
  end
end
