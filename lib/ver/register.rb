module VER
  class Register < Struct.new(:name, :value)
    REGISTERS = {}

    def self.[](name)
      name = name.to_str
      REGISTERS[name] ||= new(name)
    end

    # Assign given value to register of given name
    def self.[]=(name, value)
      self[name].value = value
    end

    def self.each(&block)
      REGISTERS.values.each(&block)
    end

    def self.fetch(name)
      REGISTERS.fetch(name.to_str)
    end

    def inspect
      "#<VER::Register name=%p, value=%p>" % [name, value]
    end

    # Special register for clipboard, found in Register['*']
    class Clipboard < Register
      def value=(object)
        VER::Clipboard.dwim = object
      end

      def value
        VER::Clipboard.dwim
      end

      def inspect
        "#<VER::Register::Clipboard name=%p, value=%p>" % [name, value]
      end
    end

    REGISTERS['*'] = Clipboard.new('*')
  end

  class RegisterList < Tk::Tile::Frame
    def self.open(buffer)
      new(buffer)
    end

    def self.show(buffer)
      buffer.ask ':register ' do |answer, action|
        case action
        when :modified
          begin
            buffer.warn ""
            register = Register.fetch(answer)
            buffer.message '"%s: %p' % [register.name, register.value]
            :abort
          rescue KeyError => ex
            buffer.warn "#{ex}: #{answer}"
          end
        end
      end
    end

    def initialize(*args)
      super
      pack fill: :x

      bind '<FocusOut>' do
        destroy
      end

      Register.each do |register|
        frame = Tk::Tile::Frame.new(self)
        label = Tk::Label.new(frame, text: register.name)
        entry = Tk::Tile::Entry.new(frame)
        entry.insert(0, register.value)

        frame.pack side: :top, fill: :x
        label.pack side: :left
        entry.pack side: :right, fill: :x, expand: true
      end
    end
  end
end
