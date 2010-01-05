module VER
  class Text < Tk::Text
    autoload :Index, 'ver/text/index'
    include Methods

    MODE_CURSOR = {
      :insert       => {insertbackground: 'red',    blockcursor: false},
      :control      => {insertbackground: 'green',  blockcursor: true},
      :select_char  => {insertbackground: 'yellow', blockcursor: true},
      :select_line  => {insertbackground: 'yellow', blockcursor: true},
      :select_block => {insertbackground: 'yellow', blockcursor: true},
    }
    MATCH_WORD_RIGHT =  /[^a-zA-Z0-9]+[a-zA-Z0-9'"{}\[\]\n-]/
    MATCH_WORD_LEFT =  /(^|\b)\S+(\b|$)/

    attr_accessor :keymap, :view, :status
    attr_reader :filename, :encoding, :pristine, :syntax, :undoer

    # attributes for diverse functionality
    attr_accessor :selection_mode, :selection_start

    def initialize(view, options = {})
      if peer = options.delete(:peer)
        @tag_commands = {}
        @tk_parent = view
        Tk.execute(peer.tk_pathname, 'peer', 'create', assign_pathname, options)
        self.filename = peer.filename
        configure(peer.configure)
      else
        super
      end

      widget_setup(view)
    end

    def peer_create(view)
      self.class.new(view, peer: self)
    end

    def view_peer
      view.create_peer
    end

    def widget_setup(view)
      self.view = view
      @options = Options.new(:text, VER.options)

      keymap_name = @options.keymap
      self.keymap = Keymap.get(name: keymap_name, receiver: self)

      apply_mode_style(keymap.mode) # for startup
      setup_tags

      @undoer = VER::Undo::Tree.new(self)

      self.selection_start = nil
      @pristine = true
      @syntax = nil
      @encoding = Encoding.default_internal

      self.mode = keymap.mode
    end

    def pristine?
      @pristine
    end

    def index(idx)
      Index.new(self, execute('index', idx).to_s)
    end

    def message(*args)
      status.message(*args)
    end

    def noop(*args)
      message "Noop %p in mode %p" % [args, keymap.mode]
    end

    def short_filename
      filename.sub(Dir.pwd + '/', '') if filename
    end

    def filename=(path)
      @filename = Pathname(path.to_s).expand_path
    end

    def layout
      view.layout
    end

    def status_projection(into)
      format = options.statusline.dup

      format.gsub!(/%([[:alpha:]]+)/, '#{\1()}')
      format.gsub!(/%_([[:alpha:]]+)/, '#{(_ = \1()) ? " #{_}" : ""}')
      format.gsub!(/%([+-]?\d+)([[:alpha:]]+)/, '#{\2(\1)}')
      format = "%{#{format}}"

      context = Status::Context.new(self)
      line = context.instance_eval(format)

      into.value = line
    rescue => ex
      puts ex, ex.backtrace
    end

    TAG_ALL_MATCHING_OPTIONS = { from: '1.0', to: 'end - 1 chars' }

    def tag_all_matching(name, regexp, options = {})
      name = name.to_s
      options = TAG_ALL_MATCHING_OPTIONS.merge(options)
      from, to = options.values_at(:from, :to)

      if tag_exists?(name)
        tag_remove(name, from, to)
      else
        fg, bg = options.values_at(:foreground, :background)
        tag_configure(name, foreground: fg, background: bg)
      end

      search_all(regexp, from, to) do |match, match_from, match_to|
        name = yield(match, match_from, match_to) if block_given?
        fast_tag_add name, match_from, match_to
      end
    end

    def search_all(regexp, from = '1.0', to = 'end - 1 chars')
      return Enumerator.new(self, :search_all, regexp, from) unless block_given?
      from, to = from.to_s, to.to_s

      while result = search(regexp, from, to, :count)
        pos, len = result
        break if !pos || len == 0

        match = get(pos, "#{pos} + #{len} chars")
        from = "#{pos} + #{len} chars"

        yield(match, pos, from)
      end
    end

    def rsearch_all(regexp, from = 'end', to = '1.0')
      return Enumerator.new(self, :rsearch_all, regexp, from) unless block_given?

      while result = rsearch(regexp, from, to, :count)
        pos, len = result
        break if !pos || len == 0

        match = get(pos, "#{pos} + #{len} chars")
        from = index("#{pos} - #{len} chars")

        yield(match, pos, from)
      end
    end

    def tag_exists?(given_path)
      tag_names.include?(given_path)
    rescue RuntimeError => ex
      false
    end

    # Wrap Tk methods to behave as we want and to generate events
    def mark_set(mark_name, index)
      super
      return unless mark_name == :insert
      Tk::Event.generate(self, '<<Movement>>')
    end

    def insert(index, string)
      index = index(index) unless index.respond_to?(:to_index)

      undo_record do |record|
        record.insert(index, string)
      end
    end

    # Replaces the range of characters between index1 and index2 with the given
    # characters and tags.
    # See the section on [insert] for an explanation of the handling of the
    # tag_list arguments, and the section on [delete] for an explanation
    # of the handling of the indices.
    # If index2 corresponds to an index earlier in the text than index1, an
    # error will be generated.
    # The deletion and insertion are arranged so that no unnecessary scrolling
    # of the window or movement of insertion cursor occurs.
    # In addition the undo/redo stack are correctly modified, if undo operations
    # are active in the text widget.
    #
    # replace index1 index2 chars ?tagList chars tagList ...?
    def replace(index1, index2, string)
      index1 = index(index1) unless index1.respond_to?(:to_index)
      index2 = index(index2) unless index2.respond_to?(:to_index)
      return if index1 == index2

      undo_record do |record|
        record.replace(index1, index2, string)
      end
    end

    def focus
      super
      Tk::Event.generate(self, '<<Focus>>')
    end

    def fast_tag_add(tag, *indices)
      execute('tag', 'add', tag, *indices)
      self
    rescue RuntimeError => ex
      VER.error(ex)
    end

    def set_window_title
      if filename
        home = Pathname(ENV['HOME'])
        dir, file = filename.split
        dir_relative_to_home = dir.relative_path_from(home)

        if dir_relative_to_home.to_s.start_with?('../')
          title = "#{file} (#{dir}) - VER"
        else
          title = "#{file} (#{dir_relative_to_home}) - VER"
        end
      else
        title = "[No Name] - VER"
      end

      VER.root.wm_title = title
    end

    def setup_highlight
      return unless filename
      return if @encoding == Encoding::BINARY

      if @syntax = Syntax.from_filename(filename)
        schedule_highlight!
        status_projection(status) if status
      end
    end

    def schedule_line_highlight(raw_index)
      return unless @syntax
      index = index(raw_index)
      schedule_line_highlight!(index.y - 1, index.linestart, index.lineend)
    end

    def schedule_highlight(options = {})
      return unless @syntax
      schedule_highlight!
    end

    # TODO: maybe we can make this one faster when many lines are going to be
    #       highlighted at once by bundling them.
    def touch!(*args)
      args.each{|arg| schedule_line_highlight(arg) } if @syntax
      Tk::Event.generate(self, '<<Modified>>')
    end

    def load_theme(name)
      return unless syntax
      return unless found = Theme.find(name)

      syntax.theme = Theme.load(found)
      schedule_highlight

      message "Theme #{found} loaded"
    end

    def load_syntax(name)
      return false unless syntax

      theme = syntax.theme

      if name.is_a?(Syntax)
        @syntax = Syntax.new(name.name, theme)
      elsif found = Syntax.find(name)
        @syntax = Syntax.new(name, theme)
      else
        return false
      end

      schedule_highlight

      message "Syntax #{@syntax.name} loaded"
    end

    private

    def schedule_highlight!(*args)
      defer do
        syntax.highlight(self, value)
        tag_all_trailing_whitespace
        tag_all_uris
      end
    end

    # TODO: only tag the current line.
    def schedule_line_highlight!(line, from, to)
      defer do
        syntax.highlight(self, get(from, to), line, from, to)
        tag_all_trailing_whitespace(from: from, to: to)
        tag_all_uris(from: from, to: to)
      end
    end

    def mode=(name)
      keymap.mode = mode = name.to_sym
      undo_separator
      apply_mode_style(mode)
      status_projection(status) if status
    end

    def apply_mode_style(mode)
      cursor = MODE_CURSOR[mode]
      return unless cursor
      configure cursor

      return unless status && color = cursor[:insertbackground]
      style = status.style
      Tk::Tile::Style.configure style, fieldbackground: color
    end

    def load_preferences
      return unless @syntax

      name = @syntax.name
      file = VER.find_in_loadpath("preferences/#{name}.rb")
      @preferences = eval(file.read)
    rescue Errno::ENOENT, TypeError => ex
      VER.error(ex)
    end

    def setup_tags
      setup_highlight_trailing_whitespace
      setup_highlight_links
    end

    def setup_highlight_trailing_whitespace
      tag_configure 'invalid.trailing-whitespace', background: '#f00'
    end

    def setup_highlight_links
      tag_configure 'markup.underline.link' , underline: true, foreground: '#00f'

      tag_bind('markup.underline.link', '<1>') do |event|
        pos = index("@#{event.x},#{event.y}")

        uri = tag_ranges('markup.underline.link').find{|from, to|
          if index(from) <= pos && index(to) >= pos
            break get(from, to)
          end
        }

        if uri
          browser = ENV['BROWSER'] || ['links', '-g']
          system(*browser, uri)
          message "%p opens the uri: %s" % [browser, uri]
        end
      end
    end

    def tag_all_uris(given_options = {})
      tag_all_matching('markup.underline.link', /https?:\/\/[^)\]}\s'"]+/, given_options)
    end

    def tag_all_trailing_whitespace(given_options = {})
      tag_all_matching('invalid.trailing-whitespace', /[ \t]+$/, given_options)
    end

    def defer
      Tk::After.idle do
        begin
          yield
        rescue Exception => ex
          VER.error(ex)
        end
      end
    end

    def font(given_options = nil)
      if given_options
        options.font.configure(given_options)
      else
        options.font
      end
    end
  end
end
