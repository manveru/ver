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
      case string
      when /^<(.*)>$/
        PATTERN.fetch(string)
      when ' ' # exception of the single-char rule
        PATTERN.fetch(string = '<space>')
      when '<' # exception of the single-char rule
        PATTERN.fetch(string = '<less>')
      when '%' # weird behaviour...
        PATTERN.fetch(string = '<percent>')
      when /^\d$/ # numbers may collide with mouse buttons
        PATTERN.fetch(string = "<Key-#{string}>")
      when /^.$/ # single unicode char
        UNICODE.fetch(string).min_by{|event| event.pattern.size }
      else # it may be keysym, but let's try to make it pattern instead
        PATTERN.fetch(string = "<#{string}>")
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

    def self.capture(capture_pattern)
      @entry ||= setup_capture
      @pending += 1

      capture_pattern = capture_pattern.gsub(/\bAlt\b/, 'M1')

      @entry.bind(capture_pattern){|event|
        pattern, keysym, unicode = event.pattern, event.keysym, event.unicode

        if pattern =~ /^<(.*)>$/
          pattern(pattern, keysym, unicode)
        elsif pattern.size == 1
          pattern("<#{keysym}>", keysym, unicode)
        else
          raise "Don't know how to handle: %p" % [event]
        end

        Tk.callback_break
      }

      @entry.value = ""

      counter = 0
      until self.key?(capture_pattern)
        Tk.update
        Tk::Event.generate(@entry, capture_pattern, when: :now)
        Tk.update
        counter += 1

        # just try a couple of times before annoying the user.
        if counter == 10
          @entry.value = "Please press %p" % [capture_pattern]
          @entry.focus
        end
      end

      @progress.step
      @pending -= 1
      self[capture_pattern]
    end

    def self.setup_capture
      @toplevel = Tk::Toplevel.new
      @label = Tk::Tile::Label.new(
        @toplevel,
        text: "Detected updates to keymap, this may take a few seconds..."
      )
      @entry = Tk::Entry.new(@toplevel)
      @progress = Tk::Tile::Progressbar.new(
        @toplevel,
        orient: :horizontal,
        mode: :indeterminate
      )

      @pending = 0
      @label.pack fill: :x
      @progress.pack fill: :x
      @entry.pack fill: :x
      @entry.bind('<Map>'){ @entry.focus }
      @entry
    end

    def self.done_yet?
      return if !@toplevel || @pending > 0
      persist!
      @toplevel.destroy
      @toplevel = @entry = @label = @progress = nil
    end

    def self.persist_location
      VER.options.home_conf_dir/'.events'
    end

    def self.persist!
      persist_location.open 'wb+' do |io|
        io.write(Marshal.dump(PATTERN))
      end
    end

    def self.load!
      persist_location.open 'rb' do |io|
        pattern = Marshal.load(io.read)
        pattern.each do |sym, event|
          PATTERN[event.pattern] = event
          UNICODE[event.unicode] << event
          KEYSYM[event.keysym] << event
        end
      end
    rescue Errno::ENOENT
      # Harmless, the .events file isn't created yet.
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
