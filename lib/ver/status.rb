module VER
  # The status bar
  class Status < Tk::Tile::Frame
    autoload :Context, 'ver/status/context'

    attr_accessor :buffer

    def self.variable(*names)
      names.each do |name|
        class_eval(<<-RUBY, __FILE__, __LINE__)
          def #{name}=(value) @#{name}.set(value); end
          def #{name}; @#{name}.get; end
        RUBY
      end
    end

    variable :file, :position, :percent, :mode, :syntax, :encoding, :battery

    def initialize(buffer, options = {})
      super
      self.buffer = buffer

      @widgets = Set.new

      text.options.statusline.each do |name, options|
        iv = "@#{name}"
        instance_variable_set(iv, add_label(name, options))
      end
    end

    def text
      buffer.text
    end

    DEFAULT = {
      sticky: :ew,
      weight: 0,
      row: 0,
    }

    def add_label(name, options = {})
      options = DEFAULT.merge(options)
      font = text.options.font
      id = Digest::MD5.hexdigest(tk_pathname)
      var = Tk::Variable.new("#{name}_#{id}")

      label = Tk::Tile::Label.new(self, font: font, textvariable: var)
      @widgets << label

      weight = options.delete(:weight)
      label.grid_configure(options)
      grid_columnconfigure label, weight: weight

      var
    end

    def style=(config)
      Tk::After.idle{ @widgets.each{|widget| widget.configure(config) } }
    end
  end
end
