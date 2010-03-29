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
      pattern = nil

      case string
      when /^<(.*)>$/ # an actual or virtual pattern
        pattern = expand_pattern(string)
        PATTERN.fetch(pattern)
      when /^[^-]{2,}$/ # keysym
        pattern = "<#{string}>"
        KEYSYM.fetch(string)
      when /^.$/ # single unicode char
        pattern = "<#{string}>"
        UNICODE.fetch(string).min_by{|event| event.pattern.size }
      end
    rescue KeyError => ex
      capture(pattern || string)
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

    MODIFIERS = %w[
      Control Mod1 M1 Command Alt Mod2 M2 Option Shift Mod3 M3 Lock Mod4 M4
      Extended Mod5 M5 Button1 B1 Meta M Button2 B2 Double Button3 B3 Triple
      Button4 B4 Quadruple Button5 B5 ]

    DETAILS = %w[
      Activate Destroy Map ButtonPress Button Enter MapRequest ButtonRelease
      Expose Motion Circulate FocusIn MouseWheel CirculateRequest FocusOut
      Property Colormap Gravity Reparent Configure KeyPress Key ResizeRequest
      ConfigureRequest KeyRelease Unmap Create Leave Visibility Deactivate ]

    require 'abbrev'
    MODIFIERS_ABBREV = MODIFIERS.abbrev
    DETAILS_ABBREV = DETAILS.abbrev

    # because Control is used a lot more than Command.
    MODIFIERS_ABBREV['C'] = 'Control'

    PATTERN_ALIAS = {}

    # pattern has the form of <modifier-modifier-type-detail>
    # This may be shortened down to <detail>.
    # Here we expand short forms of modifier and type.
    # Short modifiers take precedence over short types, as they are way more
    # used.
    def self.expand_pattern(given_pattern)
      *parts, detail = given_pattern[1..-2].split('-')

      if parts.empty?
        PATTERN_ALIAS.fetch(given_pattern, given_pattern)
      else
        parts.map! do |part|
          MODIFIERS_ABBREV[part] || DETAILS_ABBREV[part] || part
        end

        aliased_detail = PATTERN_ALIAS.fetch(detail, detail)
        inner = (parts << aliased_detail).join('-')
        pattern = "<#{inner}>"
        PATTERN_ALIAS.fetch(pattern, pattern)
      end
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

      send_pattern = if Platform.mac?
                       pattern
                     else
                       pattern.gsub(/\bAlt\b/, 'M1')
                     end

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

      load_aliases
      l "Event patterns loaded"
    rescue Errno::ENOENT
      # Mostly harmless, the .events file isn't created yet.
      l "Attempt to load event patterns failed"
      load_default
      load_aliases
    end

    def self.load_default
      # To make creation easier, we define well-known patterns for ASCII here.
      # The rest is still to be defined by actual events.
      ('0'..'9').each{|chr| pattern("<Key-#{chr}>", chr, chr) }
      ('A'..'Z').each{|chr| pattern(chr, chr, chr) }
      ('a'..'z').each{|chr| pattern(chr, chr, chr) }
      keysyms = {
        'space'        => ' ',
        'exclam'       => '!',
        'quotedbl'     => '"',
        'numbersign'   => '#',
        'dollar'       => '$',
        'percent'      => '%',
        'ampersand'    => '&',
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
        'quoteright'   => '`',
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
      }

      if Platform.x11?
        keysyms.merge!({
          'apostrophe'   => "'",
          'grave'        => '`',
        })
      end

      keysyms.each do |keysym, unicode|
        pattern("<#{keysym}>", keysym, unicode)
      end

      # F1-F12
      1.upto(12){|n| pattern("<F#{n}>", "F#{n}", '') }

      # Something for german keyboards
      pattern('<Control-bracketleft>', 'bracketleft', '[')
      pattern('<Control-bracketright>', 'bracketright', ']')
    end

    # Compatibility between windowingsystems
    def self.load_aliases
      if Platform.unix? && Platform.x11?
        # Shift-Fn is handled differently, we alias them to F12+n
        # So if you map <F13>, it works, do not use <Shift-F1> or
        # <XF86_Switch_VT_1> in the keymap itself.
        1.upto 12 do |n|
          add_alias(fsym: "F#{12 + n}", tsym: "XF86_Switch_VT_#{n}")
        end
      else
        # Here we map all Shift-Fn keys to a F12+n pattern.
        1.upto 12 do |n|
          add_alias(fsym: "F#{12 + n}", tsym: "F#{n}", tpat: "<Shift-F#{n}>")
        end
      end

      if Platform.mac?
        pattern '<Shift-Insert>', 'Shift-Insert', ''
        if Platform.x11?
          pattern '<Shift-Left>',  'Left',  ''
          pattern '<Shift-Right>', 'Right', ''
          pattern '<Shift-Control-Left>', 'Shift-Control-Left', "\uffe1"
          pattern '<Shift-Control-Right>', 'Shift-Control-Right', "\uffe2"
          pattern '<Shift-Down>', 'Down', "\uff54"
          pattern '<Shift-Up>',   'Up',   "\uff52"
          pattern '<ISO_Left_Tab>', 'Tab', "\t"
        end
      end
    end


    def self.add_alias(from, to = {})
      fsym = from[:keysym] || from[:fsym] || raise(ArgumentError, "Need keysym")
      tsym = to[  :keysym] || from[:tsym] || raise(ArgumentError, "Need keysym")
      fpat = from[:pattern] || from[:fpat] || "<#{fsym}>"
      tpat = to[  :pattern] || from[:tpat] || "<#{tsym}>"
      unicode = from[:unicode] || to[:unicode] || ''

      event = pattern(tpat, tsym, unicode)
      PATTERN[fpat] = event
      KEYSYM[fsym] << event
      PATTERN_ALIAS[fpat] = tpat
    end
  end
end
