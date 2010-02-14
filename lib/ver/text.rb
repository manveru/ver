module VER
  class Text < Tk::Text
    autoload :Index, 'ver/text/index'
    include Keymapped

    None = Object.new
    MATCH_WORD_RIGHT =  /[^a-zA-Z0-9]+[a-zA-Z0-9'"{}\[\]\n-]/
    MATCH_WORD_LEFT =  /(^|\b)\S+(\b|$)/
    MODE_STYLES = {
      :insert   => {insertbackground: 'red', blockcursor: false},
      /select/  => {insertbackground: 'yellow', blockcursor: true},
      /replace/ => {insertbackground: 'orange', blockcursor: true},
    }

    attr_accessor(:buffer, :status, :project_root, :project_repo,
                  :undoer, :pristine, :prefix_arg, :readonly)
    attr_reader(:filename, :options, :snippets, :preferences, :store_hash,
                :default_theme_config, :encoding, :syntax, :name)

    def initialize(buffer, options = {})
      @project_repo = @project_root = @highlighter = nil

      if peer = options.delete(:peer)
        @tag_commands = {}
        @tk_parent = buffer
        @store_hash = peer.store_hash
        @default_theme_config = peer.default_theme_config
        Tk.execute(peer.tk_pathname, 'peer', 'create', assign_pathname, options)
        self.filename = peer.filename
        configure(peer.configure)
      else
        @default_theme_config = nil
        @store_hash = Hash.new{|h,k| h[k] = {} }
        super
      end

      widget_setup(buffer)
    end

    # This is a noop, it simply provides a target with a sane name.
    def update_prefix_arg(widget)
      numbers = []

      major_mode.event_history.reverse_each do |event|
        break unless event[:sequence] =~ /^(\d+)$/
        numbers << $1
      end

      if numbers.any? && numbers != ['0']
        self.prefix_arg = numbers.reverse.join.to_i
      else
        self.prefix_arg = nil
      end
    end

    # Same as [prefix_arg], but returns 1 if there is no argument.
    # Useful for [Move] methods and the like.
    # Please note that calling this method is destructive.
    # It will reset the state of the prefix_arg in order to avoid persistent
    # arguments.
    # So use it only once while your action is running, and store the result in a
    # variable if you need it more than once.
    def prefix_count
      count = prefix_arg || 1
      update_prefix_arg(self)
      count
    end

    def persisted?
      return false unless filename
      return false unless filename.file?
      require 'digest/md5'

      on_disk = Digest::MD5.hexdigest(filename.read)
      in_memory = Digest::MD5.hexdigest(value)
      on_disk == in_memory
    end

    def store(namespace, key, value = None)
      if None == value
        @store_hash[namespace][key]
      else
        @store_hash[namespace][key] = value
      end
    end

    def inspect
      details = {
        mode: major_mode
      }.map{|key, value| "%s=%p" % [key, value ] }.join(' ')
      "#<VER::Text #{details}>"
    end

    def value=(string)
      super
      touch!('1.0', 'end')
    end

    def peer_create(buffer)
      self.class.new(buffer, peer: self)
    end

    def widget_setup(buffer)
      self.buffer = buffer
      @options = Options.new(:text, VER.options)

      @undoer = VER::Undo::Tree.new(self)

      self.major_mode = :Fundamental

      sync_mode_style
      setup_tags

      @pristine = true
      @syntax = nil
      self.encoding = Encoding.default_internal

      event_setup
    end

    def event_setup
      bind '<<EnterMinorMode>>' do |event|
        sync_mode_status
        sync_mode_style(event.detail)
      end

      bind '<<Modified>>' do |event|
        see :insert
        sync_position_status
      end

      bind '<<Movement>>' do |event|
        see :insert
        Methods::Selection.refresh(self)
        show_matching_brace
        sync_position_status
      end

      bind('<FocusIn>') do |event|
        on_focus_in(event)
        Tk.callback_break
      end

      bind('<FocusOut>') do |event|
        on_focus_out(event)
        Tk.callback_break
      end

      bind '<Destroy>' do |event|
        VER.cancel_block(@highlighter)
      end
    end

    def on_focus_in(event)
      Dir.chdir(filename.dirname.to_s) if options.auto_chdir
      set_window_title
      see(:insert)
      Tk::Tile::Style.configure(buffer.style, border: 1, background: '#f00')
    end

    def on_focus_out(event)
      Tk::Tile::Style.configure(buffer.style, border: 1, background: '#fff')
    end

    def pristine?
      @pristine
    end

    def index(idx)
      Index.new(self, execute('index', idx).to_s)
    end

    def message(*args)
      VER.message(*args)
    end

    def noop(*args)
      # message "Noop %p in mode %p" % [args, keymap.mode]
    end

    def short_filename
      if filename
        if root = @project_root
          filename.relative_path_from(root).to_s
        else
          filename.sub(Dir.pwd + '/', '').to_s
        end
      elsif name
        name.to_s
      end
    end

    def name=(name)
      @name = name
      status.event :filename if status
    end

    def filename=(path)
      @filename = Pathname(path.to_s).expand_path
      status.event :filename if status
    end

    def syntax=(syn)
      @syntax = syn
      status.event :syntax if syn && status
    end

    def encoding=(enc)
      @encoding = enc
      status.event :encoding if enc && status
    end

    def layout
      buffer.layout
    end

    def sync_mode_status
      status.event :mode
    end

    def sync_position_status
      status.event :position, :percent
    end

    def sync_encoding_status
      status.event :encoding
    end

    def sync_percent_status
      status.event :percent
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
        tag_add name, match_from, match_to
      end
    end

    def search_all(regexp, start = '1.0', stop = 'end - 1 chars')
      unless block_given?
        return Enumerator.new(self, :search_all, regexp, start, stop)
      end

      while result = search(regexp, start, stop, :count)
        pos, len = result
        return if !pos || len == 0

        from  = index(pos)
        to    = index("#{pos} + #{len} chars")
        match = get(from, to)

        yield(match, from, to)

        start = to
      end
    end

    def rsearch_all(regexp, start = 'end', stop = '1.0')
      unless block_given?
        return Enumerator.new(self, :rsearch_all, regexp, start, stop)
      end

      while result = rsearch(regexp, start, stop, :count)
        pos, len = result
        break if !pos || len == 0

        from = index(pos)
        to   = index("#{pos} + #{len} chars")
        match = get(from, to)

        yield(match, from, to)

        start = from
      end
    end

    def up_down_line(count)
      insert = index(:insert)

      @udl_pos_orig = insert if @udl_pos_prev != insert

      lines = count(@udl_pos_orig, insert, :displaylines)
      target = index("#@udl_pos_orig + #{lines + count} displaylines")
      @udl_pos_prev = target

      @udl_pos_orig = target if target.x == @udl_pos_orig.x
      target
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

    def insert(index, string, tag = Tk::None)
      index = index(index) unless index.respond_to?(:to_index)

      Methods::Undo.record self do |record|
        record.insert(index, string, tag)
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

      Methods::Undo.record self do |record|
        record.replace(index1, index2, string)
      end
    end

    def delete(*indices)
      Methods::Delete.delete(self, *indices)
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
      elsif name
        title = "[#{name}] - VER"
      else
        title = "[No Name] - VER"
      end

      VER.root.wm_title = title
    end

    def setup_highlight
      setup_highlight_for(Syntax.from_filename(filename)) if filename
    end

    def setup_highlight_for(syntax)
      return if encoding == Encoding::BINARY
      return unless syntax

      self.syntax = syntax
      VER.cancel_block(@highlighter)

      interval = options.syntax_highlight_interval.to_int
      @highlighter = VER.when_inactive_for(interval){
        handle_pending_syntax_highlights
      }

      touch!('1.0', 'end')

      sync_mode_status
    end

    # TODO: maybe we can make this one faster when many lines are going to be
    #       highlighted at once by bundling them.
    def touch!(*indices)
      tag_add('ver.highlight.pending', *indices) if @syntax
      Tk::Event.generate(self, '<<Modified>>')
    end

    def load_theme(name)
      return unless syntax
      return unless found = Theme.find(name)

      syntax.theme = Theme.load(found)
      touch!('1.0', 'end')

      message "Theme #{found} loaded"
    end

    def load_syntax(name)
      return false unless syntax

      theme = syntax.theme

      if name.is_a?(Syntax)
        self.syntax = Syntax.new(name.name, theme)
      elsif found = Syntax.find(name)
        self.syntax = Syntax.new(name, theme)
      else
        return false
      end

      message "Syntax #{syntax.name} loaded"
    end

    def handle_pending_syntax_highlights
      ignore_tags = %w[ver.highlight.pending sel]
      tag_ranges('ver.highlight.pending').each do |from, to|
        (tag_names(from) - ignore_tags).each do |tag_name|
          tag_from, _ = tag_prevrange(tag_name, from)
          from = tag_from if tag_from && from > tag_from
        end

        (tag_names(to) - ignore_tags).each do |tag_name|
          _, tag_to = tag_nextrange(tag_name, to)
          to = tag_to if tag_to && to < tag_to
        end

        from, to = index(from).linestart, index(to).lineend
        lineno = from.y - 1
        syntax.highlight(self, lineno, from, to)
        tag_all_trailing_whitespace(from: from, to: to)
        tag_all_uris(from: from, to: to)
        tag_remove('ver.highlight.pending', from, to)
      end
    end

    def default_theme_config=(config)
      @default_theme_config = config
      sync_mode_style
    end

    def ask(prompt, options = {}, &action)
      options[:caller] ||= self
      VER.minibuf.ask(prompt, options, &action)
    end

    def load_preferences
      return unless syntax

      name = syntax.name
      return unless file = VER.find_in_loadpath("preferences/#{name}.rb")
      @preferences = eval(file.read)
    rescue Errno::ENOENT, TypeError => ex
      VER.error(ex)
    end

    def load_snippets
      return unless syntax

      name = syntax.name
      return unless file = VER.find_in_loadpath("snippets/#{name}.rb")
      @snippets = eval(file.read)
    rescue Errno::ENOENT, TypeError => ex
      VER.error(ex)
    end

    def sync_mode_style(given_mode = nil)
      config = (default_theme_config || {}).merge(blockcursor: false)

      modes = given_mode ? [given_mode] : major_mode.minors

      modes.each do |mode|
        mode = MinorMode[mode]

        MODE_STYLES.each do |pattern, style|
          config.merge!(style) if pattern === mode.name
        end
      end

      configure(config)
      return unless status && color = config[:insertbackground]

      status.style = {
        background: cget(:background),
        foreground: color,
      }
    end

    private

    def setup_tags
      setup_highlight_trailing_whitespace
      setup_highlight_links
      setup_highlight_pending
    end

    def setup_highlight_pending
      # tag_configure 'ver.highlight.pending', underline: true
    end

    def setup_highlight_trailing_whitespace
      tag_configure 'invalid.trailing-whitespace', background: '#400'
    end

    def setup_highlight_links
      tag_configure 'markup.underline.link' , underline: true, foreground: '#0ff'

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
      tag_all_matching('markup.underline.link', /https?:\/\/[^<>)\]}\s'"]+/, given_options)
    end

    def tag_all_trailing_whitespace(given_options = {})
      tag_all_matching('invalid.trailing-whitespace', /[ \t]+$/, given_options)
    end

    def show_matching_brace(index = :insert)
      tag = 'ver.highlight.brace'
      tag_remove(tag, '1.0', 'end')

      if pos = Methods::Move.matching_brace_pos(self, index)
        tag_configure(tag, background: '#ff0', foreground: '#00f')
        tag_add(tag, 'insert', 'insert + 1 chars', pos, "#{pos} + 1 chars")
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
