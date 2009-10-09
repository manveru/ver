module VER
  class Keymap
    def self.get(options)
      name = options.fetch(:name)

      find_and_load(name)
      send(name, options)
    end

    def self.find(keymap_name)
      VER.loadpath.each do |loadpath|
        path = loadpath/"keymap/#{keymap_name}.rb"
        return path if path.file?
      end

      nil
    end

    def self.find_and_load(keymap_name)
      if path = find(keymap_name)
        sane = path.dirname/path.basename(path.extname)
        require sane.to_s
      else
        raise LoadError, "cannot find keymap: %p" % [keymap_name]
      end
    end

    attr_accessor :modes, :current_mode, :callback

    def initialize(options)
      @callback = options[:receiver]
      @modes = {}

      prepare_tag
      prepare_default_binds
    end

    def send(*args)
      @callback.__send__(*args)
    end

    def enter_key(key)
      modes[current_mode].enter_key key
    end

    def enter_missing(key)
      modes[current_mode].enter_missing key
    end

    def prepare_tag
      @tag = TkBindTag.new
      tags = callback.bindtags

      index = tags.index(Tk::Text) ||
              tags.index(Tk::Entry) ||
              tags.index(Tk::Tile::TEntry)
      tags[index - 1, 0] = @tag

      callback.bindtags = tags
    end

    def prepare_default_binds
      @tag.bind 'Key' do |event|
        case event.char
        when ''
          # enter_missing event.keysym
          # p event
        else
          enter_missing event.char
        end

        Tk.callback_break
      end

      0.upto 9 do |n|
        @tag.bind("KeyPress-#{n}") do |key|
          enter_key n.to_s
          Tk.callback_break
        end
      end
    end

    def register(key)
      @tag.bind(key){|event|
        enter_key key
        Tk.callback_break
      }
    end

    # TODO: callbacks
    def current_mode=(cm)
      @current_mode = cm.to_sym
    end

    def add_mode(name)
      @modes[name.to_sym] = mode = VER::Mode.new(name, self)
      yield mode if block_given?
      mode
    end
  end
end
