require 'ffi-tk/event/data'
module Tk
  module Event
    class Data
      def inspect
        out = ["#<Event"]
        (members - [
          :border_width, :window_path, :focus, :height, :width,
          :mousewheel_delta, :override_redirect, :place, :x, :y, :x_root, :y_root,
        ]).each do |name|
          out << "%s=%p" % [name, self[name]]
        end
        out.join(' ') << '>'
      end
    end
  end
end

module VER
  def self.minor_mode(name, &block)
    if mode = MinorMode.find(name)
      mode.instance_eval(&block)
    else
      MinorMode.new(name, &block)
    end
  end

  class EventWidget < BasicObject
    attr_reader :event, :widget

    def initialize(event)
      @event, @widget = event, event.widget
    end

    def method_missing(method, *args)
      ::Kernel.p(method: method, args: args)
      result = @widget.send(method, *args)
      if method =~ /=$/
        ::VER::EventWidget.class_eval(::Kernel.p(<<-CODE), __FILE__, __LINE__)
          def #{method}(arg)
            @widget.#{method} arg
          end
        CODE
      else
        ::VER::EventWidget.class_eval(::Kernel.p(<<-CODE), __FILE__, __LINE__)
          def #{method}(*args)
            @widget.#{method}(*args)
          end
        CODE
      end
      result
    end
  end

  class MinorMode
    MODES = {}
    LEAVE = "<<LeaveMinorMode%s>>"
    ENTER = "<<EnterMinorMode%s>>"

    def self.[](name)
      sym = name.to_s.sub(/_minor_mode$/, '').to_sym
      MODES.fetch(sym)
    rescue KeyError => ex
      message = "%s for %p" % [ex.message, sym]
      raise(ex, message)
    end

    def self.find(name)
      self[name]
    rescue KeyError
    end

    attr_reader :name, :tag, :brothers, :handler_object

    def initialize(name, &block)
      @brothers = []
      @below = []
      @above = []
      common_setup(name, :minor_mode)
      MODES[@name] = self
      instance_eval(&block) if block
    end

    def common_setup(name, suffix)
      @name = name.to_sym
      @hashes = {}
      @tag = Tk::BindTag.new("#{name}_#{suffix}")
    end

    def handler(object)
      @handler_object = object
    end

    def add(invocation, *sequences)
      virtual = bare_to_virtual(invocation)
      mod, method = invocation
      mod, method = handler_object, mod if handler_object && !method
      method, *args = [*method]

      sequences = sequences_to_tcl(*sequences)
      Tk::Event.add(virtual, *sequences)

      @tag.bind(virtual){|event|
        p event
        begin
          seq_tag, seq_hash = event.sequence[/<<(.*)>>/, 1].split('-', 2)
          p seq_tag: seq_tag, seq_invoc: @hashes[seq_hash]
        rescue => ex
          p ex
        end
        p [@tag, mod, method, args]
        Tk.callback_break if event.keycode == 136 # <Cancel>

        if mod
          mod.send(method, EventWidget.new(event), *args)
        else
          event.widget.send(method, EventWidget.new(event), *args)
        end

        # This is a hack, we need to send a non-virtual event to the widget to
        # outsmart Tk.
        # For some reason, given: `bind . dd`, then pressing ddd would invoke
        # the bind twice.
        # Binding <Double-d> is no solution, it's hardcoded with a 500ms timeout
        # and can cause a lot of confusion.
        # I bind to <Cancel> because i haven't seen a keyboard with that key yet
        # and it kinda reflects the intended behaviour.
        # Please note that if you `bind . dd` and `bind . d<Key>`, the command
        # bound to 'd<Key>' will receive <Cancel> as the <Key> if the sequence
        # ddd is typed. So we break processing if we receive that.
        # More edge-cases might occur, we'll handle them as they show up.
        Tk::Event.generate(event.window_path, '<Cancel>', when: :now)

        Tk.callback_break
      }
    end

    def ignore(*sequences)
      sequences = sequences_to_tcl(*sequences)
      sequences.each do |sequence|
        @tag.bind(sequence){
          p ignore: sequence
          Tk.callback_break
        }
      end
    end

    def enter(invocation)
      mod, method = invocation
      mod, method = handler_object, mod if handler_object && !method
      method, *args = [*method]

      Tk::Bind.bind('all', ENTER % to_camel_case){|event|
        mod.send(method, event, *args)
        Tk.callback_break
      }
    end

    def leave(invocation)
      mod, method = invocation
      mod, method = handler_object, mod if handler_object && !method
      method, *args = [*method]

      Tk::Bind.bind('all', LEAVE % to_camel_case){|event|
        mod.send(method, event, *args)
        Tk.callback_break
      }
    end

    def below(*brothers)
      brothers.flatten!

      @brothers += brothers
      @brothers.uniq!

      @below += brothers
      @below.uniq!

      p self: self, below: @below, brothers: @brothers
    end
    alias based_on below

    def above(*brothers)
      brothers.flatten!

      @brothers += brothers
      @brothers.uniq!

      @above += brothers
      @above.uniq!

      p self: self, above: @above, brothers: @brothers
    end

    def become(new_mode, *sequences)
      # TODO: port all the data from the old event into the new one
      sequences = sequences_to_tcl(*sequences)
      sequences.each do |sequence|
        @tag.bind(sequence){|event|
          widget = event.widget
          use!(widget, self, MinorMode[new_mode], event)

          Tk.callback_break
        }
      end
    end


    def sequences_to_tcl(*sequences)
      sequences.map do |sequence|
        sequence.gsub(/^\^([[:ascii:]])$/){ "<Control-#{KEYSYMS[$1] || $1}>" }.
                 gsub(/^M-([[:ascii:]])$/){ "<Alt-#{KEYSYMS[$1] || $1}>" }
      end
    end

    # Convert a given bare object to a matching tk virtual sequence.
    #
    # Make sure the virtual sequence includes a reference to the mode it is bound to.
    # Otherwise binds to virtual events will also bind to sequences defined to
    # identical virtual sequences will match.
    def bare_to_virtual(bare)
      info = {invocation: bare}
      info[:handler] = handler_object if handler_object

      marshal = Marshal.dump(info)
      base64 = [marshal].pack('m').delete("\n=")
      hash = Digest::MD5.hexdigest(base64)
      @hashes[hash] = info
      "<<#{tag.name}-#{hash}>>"
    end

    def <=>(brother)
      r =
      if @below.include?(brother.name)
        1
      elsif @above.include?(brother.name)
        -1
      else
        self.name <=> brother.name
      end
      p [self, brother, r]
      r
    end

    include Comparable

    def brotherhood(brothers = [self])
      pending = self.brothers.map{|mm| MinorMode[mm] }

      while current = pending.shift
        unless brothers.include?(current)
          brothers << current
          pending.concat(current.brotherhood(brothers)).flatten!
        end
      end

      brothers.sort
    end

    def to_tcl
      @tag.to_tcl
    end

    def inspect
      @tag.name.inspect
    end

    def major?
      false
    end

    def minor?
      true
    end

    def use!(widget, old, new, event = nil)
      all      = widget.bindtags
      specific = all[0, 1]
      modes    = all[1..-4]
      general  = all[-3..-1]

      majors, minors = modes.partition{|mode| mode =~ /_major_mode$/ }

      # get the index of the old mode and insert the new brotherhood there.
      # go through all minor modes and remove all that depend on the old one.
      if index = minors.index(old.tag.name)
        new_modes = new.brotherhood
        old_modes = old.brotherhood

        minors.each do |minor|
          minor_mode = MinorMode[minor]
          minor_modes = minor_mode.brotherhood
          next unless minor_modes.any?{|brother| minors.include?(brother.tag.name) }
          old_modes << minor_mode
        end

        old_modes.uniq!

        minors -= old_modes.map{|brother| brother.tag.name }
        minors[index, 0] = new_modes
        minors.compact!
        minors.uniq!
      else
        msg = "Cannot replace %p with %p in %p" % [old, new, all]
        raise ArgumentError, msg
      end

      leave_general_event(widget, old, new, event)

      leaving = (old_modes - new_modes).reverse
      leaving.each{|mode| leave_event(widget, mode, new, event) }

      p use: [old, new]
      p old_modes: old_modes, new_modes: new_modes
      p before: widget.bindtags
      widget.bindtags(*specific, *minors, *majors, *general)
      p after: widget.bindtags

      entering = (new_modes - old_modes).reverse
      entering.each{|mode| enter_event(widget, old, mode, event) }

      enter_general_event(widget, old, new, event)
    end

    def enter_general_event(widget, old, new, event = nil)
      detail = "#{old.name} #{new.name}"
      send_event(widget, ENTER % '', event, detail)
    end

    def leave_general_event(widget, old, new, event = nil)
      detail = "#{old.name} #{new.name}"
      send_event(widget, LEAVE % '', event, detail)
    end

    def enter_event(widget, old, new, event = nil)
      detail = "#{old.name} #{new.name}"
      send_event(widget, ENTER % new.to_camel_case, event, detail)
    end

    def leave_event(widget, old, new, event = nil)
      detail = "#{old.name} #{new.name}"
      send_event(widget, LEAVE % old.to_camel_case, event, detail)
    end

    def send_event(widget, virtual, event, data)
      if event
        event.resend(widget, virtual, data: data)
      else
        Tk::Event.generate(widget, virtual, data: data)
      end
    end

    def to_camel_case
      name.to_s.split('_').map{|e| e.capitalize}.join
    end

    def to_hash
      hash = {}

      Tk::Bind.bind(tag).each do |bind|
        next unless bind =~ /^<<.*>>$/ # only virtual events
        hash[bind] = Tk::Event.info(bind)
      end

      hash
    end
  end

  # Tk keysyms
  KEYSYMS = {
    " "  => "space",
    "!"  => "exclam",
    '"'  => "quotedbl",
    "#"  => "numbersign",
    "$"  => "dollar",
    "%"  => "percent",
    "&"  => "ampersand",
    "'"  => "quoteright",
    "("  => "parenleft",
    ")"  => "parenright",
    "*"  => "asterisk",
    "+"  => "plus",
    ","  => "comma",
    "-"  => "minus",
    "."  => "period",
    "/"  => "slash",
    "0"  => "KeyPress-0",
    "1"  => "KeyPress-1",
    "2"  => "KeyPress-2",
    "3"  => "KeyPress-3",
    "4"  => "KeyPress-4",
    "5"  => "KeyPress-5",
    "6"  => "KeyPress-6",
    "7"  => "KeyPress-7",
    "8"  => "KeyPress-8",
    "9"  => "KeyPress-9",
    ":"  => "colon",
    ";"  => "semicolon",
    "<"  => "less",
    "="  => "equal",
    ">"  => "greater",
    "?"  => "question",
    "@"  => "at",
    "["  => "bracketleft",
    "\\" => "backslash",
    "]"  => "bracketright",
    "^"  => "asciicircum",
    "_"  => "underscore",
    "`"  => "quoteleft",
    "{"  => "braceleft",
    "|"  => "bar",
    "}"  => "braceright",
    "~"  => "asciitilde",
  }

  SYMKEYS = KEYSYMS.invert
end
