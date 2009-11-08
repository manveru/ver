module VER
  class Theme < Struct.new(:name, :uuid, :default, :colors)
    CACHE = {}

    def self.list
      VER.loadpath.map{|path| Dir[(path/'theme/*.json').to_s] }.flatten
    end

    def self.find(theme_name)
      VER.find_in_loadpath("theme/#{theme_name}.json")
    end

    def self.load(filename)
       raise(ArgumentError, "No path to theme file given") unless filename

      json = JSON.load(File.read(filename.to_s))
      uuid = json['uuid']

      CACHE[uuid] ||= create(uuid, json)
    end

    def self.create(uuid, hash)
      instance = new
      instance.name = hash['name']
      instance.uuid = uuid

      hash['settings'].each do |setting|
        next unless settings = setting['settings']

        if scope_names = setting['scope']
          # specific settings
          scope_names.split(/\s*,\s*/).each do |scope_name|
            instance.set(scope_name, settings)
          end
        else
          # general settings
          instance.default = settings
        end
      end

      return instance
    end

    def self.find_and_load(theme_name)
      load(find(theme_name))
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
      colors.each do |syntax_name, options|
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

        if value =~ /^(#\h{6})/
          settings[key] = $1
        elsif key.downcase == 'fontstyle'
          settings['font'] = fontstyle_as_font(value)
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
      default.each do |key, value|
        case key.downcase
        when 'background'
          widget.configure background: value
        when 'caret'
          widget.configure insertbackground: value
        when 'foreground', 'fg'
          widget.configure foreground: value
        when 'invisibles'
          # TODO
          # widget.configure key => value
        when 'linehighlight'
          # TODO
          # widget.configure key => value
        when 'selection'
          widget.configure selectbackground: value
        else
          warn key => value
          widget.configure(key => value)
        end
      end
    end

    def create_tags_on(widget)
      colors.each do |name, options|
        widget.tag_configure(name.to_s, options)
      end
    end

    def remove_tags_on(widget, from, to)
      colors.each do |name, options|
        widget.tag_remove(name.to_s, from, to) rescue nil
      end
    end

    def delete_tags_on(widget)
      colors.each do |name, option|
        widget.tag_delete(name.to_s) rescue nil
      end
    end
  end
end
