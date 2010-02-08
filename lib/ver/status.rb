module VER
  # The status bar
  class Status < Tk::Tile::Frame
    autoload :Context, 'ver/status/context'

    attr_accessor :buffer

    def initialize(buffer, options = {})
      super
      self.buffer = buffer

      @widgets = []
      setup_widgets
    end

    def text
      buffer.text
    end

    def setup_widgets
      font = text.options.font
      id = Digest::MD5.hexdigest(tk_pathname)
      %w[file pos percent mode syntax encoding battery].each.with_index do |name, index|
        var = Tk::Variable.new("#{name}_#{id}")
        label = Tk::Tile::Label.new(self, font: font, textvariable: var)
        label.grid_configure row: 0, column: index, sticky: :ew
        instance_variable_set("@#{name}_label", label)
        instance_variable_set("@#{name}_var", var)
        @widgets << label
      end

      grid_columnconfigure 0, weight: 1
    end

    def file=(value)         @file_var.set(value) end
    def file;                @file_var.get;       end
    def encoding=(value) @encoding_var.set(value) end
    def encoding;        @encoding_var.get;       end
    def syntax=(value)     @syntax_var.set(value) end
    def syntax;            @syntax_var.get;       end
    def pos=(value)           @pos_var.set(value) end
    def pos;                  @pos_var.get;       end
    def percent=(value)   @percent_var.set(value) end
    def percent;          @percent_var.get;       end
    def mode=(value)         @mode_var.set(value) end
    def mode;                @mode_var.get;       end
    def battery=(value)   @battery_var.set(value) end
    def battery;          @battery_var.get;       end

    def style=(config)
      Tk::After.idle{ @widgets.each{|widget| widget.configure(config) } }
    end
  end
end
