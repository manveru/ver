module VER
  class Theme < Struct.new(:name, :uuid, :default, :colors)
    CACHE = {}

    def self.list
      VER.loadpath.map { |path| Dir[(path / 'theme/*.rb').to_s] }.flatten
    end

    def self.find(theme_name)
      VER.find_in_loadpath("theme/#{theme_name}.rb")
    end

    def self.load(filename)
      raise(ArgumentError, 'No path to theme file given') unless filename

      hash = eval(File.read(filename.to_s))
      uuid = hash[:uuid]

      CACHE[uuid] ||= create(uuid, hash)
    end

    def self.create(uuid, hash)
      instance = new
      instance.name = hash[:name]
      instance.uuid = uuid

      hash[:settings].each do |setting|
        next unless settings = setting[:settings]

        if scope_names = setting[:scope]
          # specific settings
          scope_names.split(/\s*,\s*/).each do |scope_name|
            instance.set(scope_name, settings)
          end
        elsif !settings.empty?
          # general settings
          instance.default = settings
        end
      end

      instance
    end

    def self.find_and_load(theme_name)
      load(find(theme_name))
    end

    R4G4B4 = '#%04x%04x%04x'

    def self.tm_color_to_tk_color(color)
      case color
      when /^(#\h{6})\h{2}$/, /^(#\h{6})$/, /^(#\h{3})\h$/
        color = Regexp.last_match(1)
      end

      xcolor = FFI::Tk.get_color(Tk.interp, color)
      format(R4G4B4, xcolor.red, xcolor.green, xcolor.blue)
    end

    def self.invert_rgb(color)
      xcolor = FFI::Tk.get_color(Tk.interp, color)
      format(R4G4B4, 0xffff - xcolor.red, 0xffff - xcolor.green, 0xffff - xcolor.blue)
    end

    def initialize(colors = {}, &block)
      self.colors = colors
      instance_eval(&block) if block_given?
    end

    def set(match, options)
      match = normalize(match)
      colors[match] = (colors[match] || {}).merge(sanitize_settings(options))
    end

    def get(name)
      name = normalize(name)
      colors.each do |syntax_name, _options|
        return syntax_name if name.start_with?(syntax_name)
      end

      nil
    end

    def default=(settings)
      self[:default] = sanitize_settings(settings)
    end

    def sanitize_settings(given_settings)
      settings = given_settings.dup

      settings.keys.each do |key|
        next unless value = settings.delete(key)
        next if value.empty?

        if value =~ /^#\h+$/
          settings[key] = Theme.tm_color_to_tk_color(value)
        elsif key.downcase == :fontstyle
          settings[:font] = fontstyle_as_font(value)
        else
          settings[key] = value
        end
      end

      settings
    end

    def fontstyle_as_font(style)
      options = Font.default_options

      options[:slant]      = :italic if style =~ /\bitalic\b/
      options[:underline]  = true    if style =~ /\bunderline\b/
      options[:overstrike] = true    if style =~ /\boverstrike\b/
      options[:weight]     = :bold   if style =~ /\bbold\b/

      Font[options]
    end

    def normalize(keyname)
      keyname.tr(' ', '-')
    end

    # -background or -bg, background, Background
    # -borderwidth or -bd, borderWidth, BorderWidth
    # -cursor, cursor, Cursor
    # -font, font, Font
    # -foreground or -fg, foreground, Foreground
    #
    # -highlightbackground, highlightBackground, HighlightBackground
    # -highlightcolor, highlightColor, HighlightColor
    # -highlightthickness, highlightThickness, HighlightThickness
    #
    # -insertbackground, insertBackground, Foreground
    # -insertborderwidth, insertBorderWidth, BorderWidth
    #
    # -insertofftime, insertOffTime, OffTime
    # -insertontime, insertOnTime, OnTime
    #
    # -selectbackground, selectBackground, Foreground
    # -selectborderwidth, selectBorderWidth, BorderWidth
    # -selectforeground, selectForeground, Background
    #
    # -inactiveselectbackground, inactiveSelectBackground, Foreground
    #
    # -spacing1, spacing1, Spacing1
    # -spacing2, spacing2, Spacing2
    # -spacing3, spacing3, Spacing3

    def apply_default_on(widget)
      config = {}

      default.each do |key, value|
        case key.downcase
        when :background, :bg
          config[:background] = value
        when :caret
          config[:insertbackground] = value
        when :foreground, :fg
          config[:foreground] = value
        when :invisibles, :linehighlight
          # TODO
          # widget.configure key => value
        when :selection
          config[:selectbackground] = value
          config[:selectforeground] = Theme.invert_rgb(value)
        else
          warn key => value
          config[key] = value
        end
      end

      widget.default_theme_config = config
    end

    def create_tags_on(widget)
      colors.each do |name, options|
        widget.tag_configure(name.to_s, options)
      end
    end

    def remove_tags_on(widget, from, to)
      outer_tags = widget.tag_names(from) & widget.tag_names(to)

      colors.each do |name, _options|
        name = name.to_s
        next if outer_tags.include?(name)
        begin
          widget.tag_remove(name, from, to)
        rescue StandardError
          nil
        end
      end
    end

    def delete_tags_on(widget)
      colors.each do |name, _option|
        begin
          widget.tag_delete(name.to_s)
        rescue StandardError
          nil
        end
      end
    end
  end
end
