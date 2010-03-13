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
      # l string: string
      case string
      when /^<(.*)>$/ # an actual or virtual pattern
        PATTERN.fetch(pattern = string)
      when /^[^-]{2,}$/ # keysym
        pattern = "<#{string}>"
        KEYSYM.fetch(string)
      when /^.$/ # single unicode char
        pattern = "<#{string}>"
        UNICODE.fetch(string).min_by{|event| event.pattern.size }
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
      l "capturing %p" % [pattern]
      @entry ||= setup_capture
      @pending += 1

      @entry.bind(pattern){|event|
        keysym, unicode = event.keysym, event.unicode
        l "Received: %p" % [[pattern, keysym, unicode]]

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

      send_pattern = pattern.gsub(/\bAlt\b/, 'M1')
      counter = 0
      until self.key?(pattern)
        Tk::Event.generate(@entry, send_pattern, when: :now)
        Tk.update
        counter += 1

        # just try a couple of times before annoying the user.
        if counter == 10
          @entry.value = "Please press %p" % [pattern]
          @entry.focus
        end
      end

      @progress.step
      @pending -= 1
      self[pattern]
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
      path = persist_location
      l "Persisting event patterns to #{path}"
      path.open 'wb+' do |io|
        io.write(Marshal.dump(PATTERN))
      end
    end

    def self.load!
      path = persist_location
      l "Attempt to load event patterns from #{path}"

      path.open 'rb' do |io|
        pattern = Marshal.load(io.read)
        pattern.each do |sym, event|
          PATTERN[event.pattern] = event
          UNICODE[event.unicode] << event
          KEYSYM[event.keysym] << event
        end
      end

      l "Event patterns loaded"
    rescue Errno::ENOENT
      # Mostly harmless, the .events file isn't created yet.
      l "Attempt to load event patterns failed"

      # To make creation easier, we define well-known patterns for ASCII here.
      # The rest is still to be defined by actual events.
      ('0'..'9').each{|chr| pattern("<Key-#{chr}>", chr, chr) }
      ('A'..'Z').each{|chr| pattern(chr, chr, chr) }
      ('a'..'z').each{|chr| pattern(chr, chr, chr) }
      { 'space'        => ' ',
        'exclam'       => '!',
        'quotedbl'     => '"',
        'numbersign'   => '#',
        'dollar'       => '$',
        'percent'      => '%',
        'ampersand'    => '&',
        'apostrophe'   => "'",
        'parenleft'    => '(',
        'parenright'   => ')',
        'asterisk'     => '*',
        'plus'         => '+',
        'comma'        => ',',
        'minus'        => '-',
        'period'       => '.',
        'slash'        => '/',
        'colon'        => ':',
        'semicolon'    => ';',
        'less'         => '<',
        'equal'        => '=',
        'greater'      => '>',
        'question'     => '?',
        'at'           => '@',
        'bracketleft'  => '[',
        'backslash'    => '\\',
        'bracketright' => ']',
        'asciicircum'  => '^',
        'underscore'   => '_',
        'grave'        => '`',
        'braceleft'    => '{',
        'bar'          => '|',
        'braceright'   => '}',
        'asciitilde'   => '~',

        # Now a couple of basic keys that don't change across platforms
        'BackSpace'    => "\b",
        'Delete'       => "\x7F",
        'Down'         => '',
        'End'          => '',
        'Escape'       => "\e",
        'Home'         => '',
        'Insert'       => '',
        'Left'         => '',
        'Next'         => '',
        'Prior'        => '',
        'Return'       => "\n",
        'Right'        => '',
        'Tab'          => "\t",
        'Up'           => '',
      }.each do |keysym, unicode|
        pattern("<#{keysym}>", keysym, unicode)
      end

      # F1-F12
      1.upto(12).each{|n| pattern("<F#{n}>", "F#{n}", '') }

      # Something for german keyboards
      pattern('<Control-bracketleft>', 'bracketleft', '[')
      pattern('<Control-bracketright>', 'bracketright', ']')
    end
  end
end
