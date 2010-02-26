module VER
  class Buffer < Text
    include Keymapped
    extend Forwardable

    autoload :Frame,                     'ver/buffer/frame'
    autoload :InvalidTrailingWhitespace, 'ver/buffer/invalid_trailing_whitespace'
    autoload :MarkupUnderlineLink,       'ver/buffer/markup_underline_link'
    autoload :MatchingBrace,             'ver/buffer/matching_brace'

    OPTIONS = {
      borderwidth:      0,
      blockcursor:      false,
      exportselection:  true,   # provide selection to X automatically
      foreground:       '#fff', # when first showing, it's not highlighted...
      background:       '#000',
      insertbackground: '#fff',
      setgrid:          false,
      takefocus:        true,
      tabstyle:         :wordprocessor,
      wrap:             :word,
      undo:             false,
      autoseparators:   false
    }

    MODE_STYLES = {
      :control  => {blockcursor: false},
      :insert   => {blockcursor: false, insertbackground: 'red'},
      /select/  => {blockcursor: true,  insertbackground: 'yellow'},
      /replace/ => {blockcursor: true,  insertbackground: 'orange'},
    }

    TAG_ALL_MATCHING_OPTIONS = { from: '1.0', to: 'end - 1 chars' }

    PROJECT_DIRECTORY_GLOB = '{.git/,.hg/,_darcs/,_FOSSIL_}'

    MODELINES = {
      /\s+(?:ver|vim?|ex):\s*.*$/ => /\s+(?:ver|vim?|ex):\s*(.*)$/,
      /\s+(?:ver|vim?|ex):[^:]+:/ => /\s+(?:ver|vim?|ex):([^:]+):/,
      /^(?:ver|vim?):[^:]+:/      => /^(?:ver|vim?):([^:]+):/,
    }

    None = Object.new

    def self.[](uri, line = nil, char = nil)
      find_or_create(uri, line, char)
    end

    def self.create(path = nil, line = nil, char = nil)
      VER.layout.create_buffer do |buffer|
        buffer.open(path, line, char)
        yield(buffer) if block_given?
        buffer
      end
    end

    def self.find_or_create(uri, line = nil, char = nil, &block)
      case uri
      when Pathname, Symbol
        if buffer = VER.buffers.find{|buf| buf.uri == uri }
          buffer.show
          buffer.focus
          buffer.at_insert.go_line_char(line, char)
          yield buffer if block_given?
          buffer
        else
          create(uri, line, char, &block)
        end
      when String
        path = Pathname(uri.to_str).expand_path
        find_or_create(path, line, char, &block)
      else
        raise ArgumentError, "Invalid path: %p" % [path]
      end
    end

    attr_reader :frame, :status, :options, :at_current, :at_insert, :at_end,
                :theme_config, :matching_brace, :layout, :syntax
    attr_accessor :uri, :project_root, :project_repo, :undoer, :pristine,
                  :prefix_arg, :readonly, :encoding, :filename, :at_sel,
                  :symbolic

    def initialize(parent = VER.layout, given_options = {})
      @layout = parent
      @frame = Frame.new(parent, self)

      font, tabstop = VER.options.font, VER.options.tabstop
      tabs = font.measure('0') * tabstop

      default_options = OPTIONS.merge(
        font:            font,
        insertofftime:   VER.options.insertofftime,
        insertontime:    VER.options.insertontime,
        tabs:            tabs
      )

      super(frame, default_options.merge(given_options))

      setup
    end

    def setup
      setup_tags
      setup_misc
      setup_widgets
      setup_layout
      setup_binds
      layout.bind('<Map>'){ Tk.update }
    end

    def setup_widgets
      @status    = Status.new(frame, self)
      @xbar      = Tk::Tile::XScrollbar.new(frame)
      @ybar      = Tk::Tile::YScrollbar.new(frame)
      @minibuf   = VER.minibuf.peer_create(frame)
      xscrollbar(@xbar)
      yscrollbar(@ybar)
    end

    def setup_layout
      self.    grid_configure row: 0, column: 0, sticky: :nsew
      @ybar.   grid_configure row: 0, column: 1, sticky: :ns if @ybar
      @xbar.   grid_configure row: 1, column: 0, sticky: :ew if @xbar
      status.  grid_configure row: 2, column: 0, sticky: :ew
      @minibuf.grid_configure row: 3, column: 0, sticky: :ew

      frame.grid_columnconfigure 0, weight: 1
      frame.grid_columnconfigure 1, weight: 0
      frame.grid_rowconfigure    0, weight: 1
      frame.grid_rowconfigure    1, weight: 0
      frame.grid_rowconfigure    2, weight: 0
      frame.grid_rowconfigure    3, weight: 0
    end

    def setup_misc
      @store_hash     = Hash.new{|h,k| h[k] = {} }
      @options        = Options.new(:text, VER.options)
      @at_current     = Mark.new(self, :current)
      @at_insert      = Insert.new(self)
      @at_end         = End.new(self)
      @at_sel         = Selection::Char.new(self, false)
      @theme_config   = nil
      @highlighter    = nil
      @pristine       = true
      self.major_mode = :Fundamental
    end

    def setup_binds
      bind('<<EnterMinorMode>>', &method(:on_enter_minor_mode))
      bind('<<Modified>>',       &method(:on_modified))
      bind('<<Movement>>',       &method(:on_movement))
      bind('<<FocusIn>>',        &method(:on_focus_in))
      bind('<<FocusOut>>',       &method(:on_focus_out))
      bind('<<Destroy>>',        &method(:on_destroy))
    end

    def setup_tags
      @invalid_trailing_whitespace = InvalidTrailingWhitespace.new(self)
      @markup_underline_link       = MarkupUnderlineLink.new(self)
      @matching_brace              = MatchingBrace.new(self)
    end

    def on_enter_minor_mode(event)
      sync_mode_status
      sync_mode_style(event.detail)
    end

    def on_modified(event)
      on_movement(event)
    end

    def on_movement(event)
      at_insert.see
      at_sel.refresh
      @matching_brace.refresh
      sync_position_status
    end

    def on_focus_in(event)
      Dir.chdir(filename.dirname.to_s) if filename && options.auto_chdir
      # Tk::Tile::Style.configure(frame.style, border: 1, background: '#f00')
      on_movement(event)
      Tk.callback_break
    end

    def on_focus_out(event)
      # Tk::Tile::Style.configure(frame.style, border: 1, background: '#fff')
      Tk.callback_break
    end

    def on_destroy(event)
      VER.cancel_block(@highlighter)
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

    def sync_mode_style(given_mode = nil)
      config = (theme_config || {}).merge(blockcursor: false)

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

    def events
      major_mode.event_history
    end

    def message(*args)
      @minibuf.message(*args)
    end

    def warn(*args)
      @minibuf.warn(*args)
    end

    # Hack for smoother minibuf completion
    public :binding, :local_variables, :global_variables

    alias pristine? pristine
    alias symbolic? symbolic

    def persisted?
      return false unless filename
      return false unless filename.file?
      require 'digest/md5'

      on_disk = Digest::MD5.hexdigest(filename.read)
      in_memory = Digest::MD5.hexdigest(value)
      on_disk == in_memory
    end

    def type(string)
      major_mode.fake(string)
    end

    def short_filename
      if filename
        if root = @project_root
          filename.relative_path_from(root).to_s
        else
          filename.sub(Dir.pwd + '/', '').to_s
        end
      elsif uri
        uri.to_s
      end
    end

    def filename=(path)
      @filename = Pathname(path.to_s).expand_path
      status.event :filename if status
    end

    def encoding=(enc)
      @encoding = enc
      status.event :encoding if enc && status
    end

    def name=(name)
      @name = name
      status.event :filename if status
    end

    def syntax=(syn)
      @syntax = syn
      status.event :syntax if syn && status
    end

    def insert=(position)
      at_insert.index = position
    end

    def delete(*indices)
      return super unless undoer

      undo_record do |record|
        record.delete(*indices)
      end
    end

    def replace(*args)
      return super unless undoer

      undo_record do |record|
        record.replace(*args)
      end
    end

    def insert(*args)
      return super unless undoer

      undo_record do |record|
        record.insert(*args)
      end
    end

    def open(uri, line = 1, char = 0)
      case uri
      when Symbol
        open_symbolic(uri)
      when Pathname
        open_pathname(uri)
      when String, URI
        open_uri(uri)
      else
        raise ArgumentError, "Invalid uri: %p" % [uri]
      end

      self.insert = "#{line || 1}.#{char || 0}"
      VER.buffers << self
      message "Opened #{uri}"
    end

    def open_symbolic(symbol)
      self.uri = symbol
      self.symbolic = true

      case symbol
      when :Scratch
        self.value = <<-TEXT
# This buffer is for notes you don't want to save, and for Ruby evaluation.
# If you want to create a file, visit that file with :o.
# then enter the text in that file's own buffer.
        TEXT
        syntax = 'Ruby'
      when :Messages
        clear
        tag(:info).configure(foreground: '#aaf')
        tag(:warn).configure(foreground: '#faa')
        syntax = 'Plain Text'
      when :Completions
        clear
        self.major_mode = :Completions
        tag('ver.minibuf.completion').configure(foreground: '#fff')
        syntax = 'Plain Text'
      else
        clear
        syntax = 'Plain Text'
      end

      after_open(Syntax.new(syntax))
    end

    def open_pathname(pathname)
      self.uri = self.filename = pathname
      self.value = content = pathname.read.chomp
      self.encoding = content.encoding
      self.readonly = !pathname.writable?
      detect_project_paths
      update_mtime
      after_open
    rescue Errno::ENOENT
      self.value = ''
      self.encoding = value.encoding
      self.readonly = false
      after_open
    end

    def open_uri
      self.uri = uri
      self.value = Kernel.open(uri){|io| io.read.chomp }
      after_open
    end

    def after_open(syntax = nil)
      @undoer = VER::Undo::Tree.new(self)
      VER.opened_file(self)
      layout.wm_title = uri.to_s

      bind('<Map>') do
        VER.defer do
          syntax ? setup_highlight_for(syntax) : setup_highlight
          apply_modeline
        end
        bind('<Map>'){ at_insert.see }
      end
    end

    def update_mtime
      store(:stat, :mtime, filename.mtime) if filename
    rescue Errno::ENOENT
    end

    def detect_project_paths
      return unless filename
      parent = filename.expand_path.dirname

      begin
        (parent/PROJECT_DIRECTORY_GLOB).glob do |repo|
          self.project_repo = repo
          self.project_root = repo.dirname
          return
        end

        parent = parent.dirname
      end until parent.root?
    end

    def apply_modeline
      MODELINES.each do |search_pattern, extract_pattern|
        found = search(search_pattern, 1.0, :end, :count)
        next if found.empty?

        pos, count = found
        line = get(pos, "#{pos} + #{count} chars")

        line =~ extract_pattern
        $1.scan(/[^:\s]+/) do |option|
          apply_modeline_option(option)
        end
      end
    end

    def apply_modeline_option(option)
      negative = option.gsub!(/^no/, '')
      boolean = !negative

      case option
      when 'ai', 'autoindent'
        set :autoindent, boolean
      when 'et', 'expandtab'
        set :expandtab, boolean
      when /(?:tw|textwidth)=(\d+)/
        set :textwidth, $1.to_i
      when /(?:ts|tabstop)=(\d+)/
        set :tabstop, $1.to_i
      when /(?:sw|shiftwidth)=(\d+)/
        set :shiftwidth, $1.to_i
      when /(?:ft|filetype)=(\w+)/
        set :filetype, $1
      else
        VER.warn "Unknown modeline: %p" % [option]
      end
    end

    def set(option, value)
      method = "set_#{option}"

      if respond_to?(method)
        if block_given?
          __send__(method, value, &Proc.new)
        else
          __send__(method, value)
        end
      else
        options[option] = value
        yield(value) if block_given?
      end
    end

    def set_filetype(type)
      syntax = VER::Syntax.from_filename(Pathname("foo.#{type}"))

      if load_syntax(syntax)
        options.filetype = type
      end
    end

    def hide
      layout.hide
    end

    def show
      layout.show
    end

    def close
      layout.close
    end

    def touch!(*indices)
      tag_add('ver.highlight.pending', *indices.flatten) if @syntax
      Tk::Event.generate(self, '<<Modified>>')
    end

    def undo
      undoer.undo if undoer
    end

    def redo
      undoer.redo if undoer
    end

    # Use this method in commands that do multiple insert, delete, replace
    def undo_record(&block)
      VER.warn "Buffer is Read-only" if readonly
      undoer ? undoer.record_multi(&block) : yield(self)
    end

    def store(namespace, key, value = None)
      if None == value
        @store_hash[namespace][key]
      else
        @store_hash[namespace][key] = value
      end
    end

    def update_prefix_arg
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
      update_prefix_arg
      count
    end

    def tag_exists?(given_path)
      tag_names.include?(given_path)
    rescue RuntimeError => ex
      false
    end

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

    # OK, finally found the issue.
    #
    # the implementation of tk::TextUpDownLine is smart, but not smart enough.
    # It doesn't assume large deltas between the start of up/down movement and
    # the last other modification of the insert mark.
    #
    # This means that, after scrolling with up/down for a few hundred lines, it
    # has to calculate the amount of display lines in between, which is a very
    # expensive calculation and time increases O(delta_lines).
    #
    # We'll try to solve this another way, by assuming that there are at least a
    # few other lines of same or greater length in between, we simply compare
    # against a closer position and make delta_lines as small as possible.
    #
    #
    # Now, if you go to, like column 100 of a line, and there is never a line as
    # long for the rest of the file, the scrolling will still slow down a lot.
    # This is an issue we can fix if we "forget" the @udl_pos_orig after a
    # user-defined maximum delta (something around 200 should do), will
    # implement that on demand.
    def up_down_line(count)
      insert = index(:insert)

      @udl_pos_orig = insert if @udl_pos_prev != insert

      lines = count(@udl_pos_orig, insert, :displaylines)
      target = index("#@udl_pos_orig + #{lines + count} displaylines")
      @udl_pos_prev = target

      @udl_pos_orig = target if target.char == @udl_pos_orig.char
      target
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

    def load_snippets
      return unless syntax

      name = syntax.name
      return unless file = VER.find_in_loadpath("snippets/#{name}.rb")
      @snippets = eval(file.read)
    rescue Errno::ENOENT, TypeError => ex
      VER.error(ex)
    end

    def load_preferences
      return unless syntax

      name = syntax.name
      return unless file = VER.find_in_loadpath("preferences/#{name}.rb")
      @preferences = eval(file.read)
    rescue Errno::ENOENT, TypeError => ex
      VER.error(ex)
    end

    def handle_pending_syntax_highlights
      ignore_tags = %w[ver.highlight.pending sel]

      tag_ranges('ver.highlight.pending').each do |range|
        from, to = range.first, range.last

        (tag_names(from) - ignore_tags).each do |tag_name|
          tag_from, _ = tag_prevrange(tag_name, from)
          from = tag_from if tag_from && from > tag_from
        end

        (tag_names(to) - ignore_tags).each do |tag_name|
          _, tag_to = tag_nextrange(tag_name, to)
          to = tag_to if tag_to && to < tag_to
        end

        from, to = index("#{from} linestart"), index("#{to} lineend")
        syntax.highlight(self, from.line - 1, from, to)
        @invalid_trailing_whitespace.refresh(from: from, to: to)
        @markup_underline_link.refresh(from: from, to: to)
        tag_remove('ver.highlight.pending', from, to)
      end
    end

    def default_theme_config=(config)
      @theme_config = config
      sync_mode_style
    end

    def ask(prompt, options = {}, &action)
      options[:caller] ||= self
      @minibuf.ask(prompt, options, &action)
    end

    class HighlightPending < Tag
      NAME = 'ver.highlight.pending'.freeze

      def initialize(buffer, name = NAME)
        super
      end
    end
  end
end
