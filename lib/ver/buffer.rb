module VER
  class Buffer < Text
    include Keymapped
    extend Forwardable

    autoload :Frame,                     'ver/buffer/frame'
    autoload :InvalidTrailingWhitespace, 'ver/buffer/invalid_trailing_whitespace'
    autoload :MarkupUnderlineLink,       'ver/buffer/markup_underline_link'
    autoload :MatchingBrace,             'ver/buffer/matching_brace'

    OPTIONS = {
      autoseparators:      false,
      background:          '#000',
      blockcursor:         false,
      borderwidth:         0,
      exportselection:     true,   # provide selection to X automatically
      foreground:          '#fff', # when first showing, it's not highlighted...
      highlightbackground: '#000', # this specifies the colors
      highlightcolor:      '#fff', # that are used when the widget
      highlightthickness:  1,      # has input focus.
      insertbackground:    '#fff',
      relief:              :solid,
      setgrid:             false,
      tabstyle:            :wordprocessor,
      takefocus:           true,
      undo:                false,
      wrap:                :word
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

    REPEAT_BREAK_CMD = [
      :repeat_action,
      :undo,
      :redo,
    ]

    REPEAT_BREAK_MODE = [
      :move,
      :search,
    ]

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
                :theme_config, :matching_brace, :layout, :syntax, :minibuf,
                :snippets, :preferences
    attr_accessor :uri, :project_root, :project_repo, :undoer, :pristine,
                  :prefix_arg, :readonly, :encoding, :filename, :at_sel,
                  :symbolic, :locked, :register, :skip_prefix_count_once

    # Hack for smoother minibuf completion
    public :binding, :local_variables, :global_variables

    alias pristine? pristine
    alias symbolic? symbolic
    alias locked? locked

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
      @minibuf   = VER.minibuf.peer_create(frame, self)

      if options.horizontal_scrollbar
        @xbar = Tk::Tile::XScrollbar.new(frame)
        xscrollbar(@xbar)
      end

      if options.vertical_scrollbar
        @ybar = Tk::Tile::YScrollbar.new(frame)
        yscrollbar(@ybar)
      end
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
      self.register   = Register['*']
      self.major_mode = :Fundamental
    end

    def setup_binds
      bind('<<EnterMinorMode>>', &method(:on_enter_minor_mode))
      bind('<<Modified>>',       &method(:on_modified))
      bind('<<Movement>>',       &method(:on_movement))
      bind('<FocusIn>',          &method(:on_focus_in))
      bind('<FocusOut>',         &method(:on_focus_out))
      bind('<Destroy>',          &method(:on_destroy))
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
      adjust_sight
      at_sel.refresh
      @matching_brace.refresh
      sync_position_status
    end

    def on_focus_in(event)
      if @minibuf.asking
        @minibuf.focus
      else
        Dir.chdir(filename.dirname.to_s) if filename && options.auto_chdir
        on_movement(event)
      end

      Tk.callback_break
    end

    def on_focus_out(event)
      Tk.callback_break
    end

    def on_destroy(event)
      @lock = true
      frame.destroy
      VER.cancel_block(@highlighter)
      VER.buffers.delete(self)
      unlock_uri(uri)
    ensure
      VER.defer{ VER.exit if VER.buffers.empty? }
    end

    def adjust_sight
      see(@look_at || at_insert)
    end

    def look_at(obj)
      @look_at = obj
    end

    # This has to be called _before_ <Destroy> is received, otherwise the Buffer
    # is half-dead.
    def persist_info
      file = VER.loadpath.first/'buffer_info.json'
      l "Persisting Buffer info into: #{file}"

      JSON::Store.new(file.to_s, true).transaction do |buffer_info|
        syntax_name = @syntax.name if @syntax

        buffer_info[uri.to_s] = {
          'insert' => index('insert').to_s,
          'syntax' => syntax_name
        }
      end
    end

    def load_info
      file = VER.loadpath.first/'buffer_info.json'
      l "Loading Buffer info from: #{file}"
      JSON::Store.new(file.to_s, true).transaction do |buffer_info|
        if info = buffer_info[uri.to_s]
          return info
        end
      end

      return {}
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

    def actions
      major_mode.action_history
    end

    def message(*args)
      @minibuf.message(*args)
    end

    def warn(*args)
      @minibuf.warn(*args)
    end

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
        open_symbolic(uri, line, char)
      when Pathname
        open_pathname(uri, line, char)
      when String, URI
        open_uri(uri, line, char)
      else
        raise ArgumentError, "Invalid uri: %p" % [uri]
      end

      true
    end

    def open_symbolic(symbol, line, char)
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

      after_open(Syntax.new(syntax), line, char)
    end

    def open_pathname(pathname, line, char)
      lock_uri(pathname) do |answer|
        begin
          case answer
          when :single, :shared, :read_only
            self.uri = self.filename = pathname

            content, encoding = pathname.read_encoded_file
            self.encoding = encoding
            self.value = content.chomp
            self.readonly = answer == :read_only || pathname.readonly?
            self.locked = answer == :single
            detect_project_paths
            update_mtime
            after_open(nil, line, char)
          when :abort
            close
            :abort
          when :quit
            VER.exit
          end
        rescue Errno::ENOENT => ex
          VER.error(ex)
          open_empty(line, char)
        end
      end
    end

    def open_empty(line, char)
      self.uri = '<empty>'
      self.value = ''
      self.encoding = value.encoding
      self.readonly = false
      after_open(nil, line, char)
    end

    def open_uri(uri, line, char)
      self.uri = uri
      self.value = Kernel.open(uri){|io| io.read.chomp }
      after_open(nil, line, char)
    end

    def after_open(syntax = nil, line = nil, char = nil)
      @undoer = VER::Undo::Tree.new(self)
      VER.opened_file(self)
      layout.wm_title = uri.to_s

      info = load_info

      if line || char
        self.insert = "#{line || 1}.#{char || 0}"
      else
        self.insert = info['insert'] || '1.0'
      end

      VER.buffers << self
      message "Opened #{uri}"

      # Don't rely on the <Map> event, since it's prone to race-conditions.
      finalize_open(syntax || info['syntax'])
    rescue => ex
      VER.error(ex)
    end

    def finalize_open(syntax)
      VER.defer do
        syntax ? setup_highlight_for(syntax) : setup_highlight
        load_preferences
        apply_modeline
      end
      bind('<Map>'){ adjust_sight }
    end

    def lock_uri(uri, &block)
      lock = uri_lockfile(uri)

      if lock.file? # omg, someone is using it!
        info  = Hash[lock.read.scan(/^(\w+):\s*(.*)$/)]
        ctime = lock.ctime
        pid   = info['pid']
        user  = info['user']
        uri   = info['uri']
        alive = info

        prompt = <<-TEXT.chomp
Found a lock file at: #{lock}
owned by: #{user}
used by: #{pid}
dated: #{ctime}
for: #{uri}

Another program may be editing the same file.
If this is the case, be careful not to end up with two different instances of the same file when making changes.
Close this buffer or continue with caution.

[O]pen Read-Only, [E]dit anyway, [D]elete lock, [Q]uit, [A]bort: 
        TEXT

        ask(prompt) do |answer, action|
          case action
          when :modified
            case answer
            when /o/i
              yield :read_only
              :abort
            when /e/i
              yield :shared
              :abort
            when /q/i
              yield :quit
              :abort
            when /a/i
              yield :abort
              :abort
            when /d/i
              VER.defer do
                lock.rm
                lock_uri(uri, &block)
              end
              :abort
            else
              warn('invalid answer')
              minibuf.answer = ''
            end
          end
        end
      else
        File.open(lock, 'w+') do |file|
          file.puts(
            "pid: #{Process.pid}",
            "uid: #{Process.uid}",
            "uri: #{uri}"
          )
        end

        yield :single
      end
    end

    def unlock_uri(uri = self.uri)
      return unless locked?
      uri_lockfile(uri).rm_f
    end

    def uri_lockfile(uri = self.uri)
      require 'tmpdir'
      hash = Digest::SHA1.hexdigest(uri.to_s)
      lock = Pathname.tmpdir/'ver/lock'/hash
      lock.dirname.mkpath
      lock
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
      may_close do
        persist_info
        layout.destroy
      end
    end

    def touch!(*indices)
      tag_add('ver.highlight.pending', *indices.flatten)
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
    ensure
      self.pristine = false
    end

    def store(namespace, key, value = None)
      if None == value
        @store_hash[namespace][key]
      else
        @store_hash[namespace][key] = value
      end
    end

    def change_register
      major_mode.read(1) do |name|
        if unicode = name.unicode
          if unicode.empty?
            warn "invalid name for register: %p" % [name]
          else
            self.register = Register[unicode]
          end
        else
          warn "invalid name for register: %p" % [name]
        end
      end
    end

    def with_register
      @with_register_level ||= 0
      @with_register_level += 1
      value = yield(register)
      @with_register_level -= 1
    ensure
      self.register = Register['*'] if @with_register_level == 0
    end

    def update_prefix_arg
      numbers = []

      events.reverse_each do |event|
        break unless event.keysym =~ /^(\d+)$/
        numbers << $1
      end

      if numbers.any? && numbers != ['0']
        self.prefix_arg = numbers.reverse.join.to_i
      else
        self.prefix_arg = nil
      end
    end

    # Same as [prefix_arg], but returns 1 if there is no argument.
    #
    # The return value in case there is no argument can be changed by passing
    # a +default+ argument.
    #
    # Useful for [Move] methods and the like.
    # Please note that calling this method is destructive.
    # It will reset the state of the prefix_arg in order to avoid persistent
    # arguments.
    # So use it only once while your action is running, and store the result in a
    # variable if you need it more than once.
    def prefix_count(default = 1)
      if skip_prefix_count_once
        self.skip_prefix_count_once = false
        update_prefix_arg
        return default
      end

      count = prefix_arg || default
      update_prefix_arg
      count
    end

    def repeat_action
      stack = []

      actions.reverse_each do |event, mode, action|
        if stack.empty?
          next if REPEAT_BREAK_CMD.include?(action.to_method(self).name)
          next if REPEAT_BREAK_MODE.include?(mode.name)
        else
          break if REPEAT_BREAK_CMD.include?(action.to_method(self).name)
          break if REPEAT_BREAK_MODE.include?(mode.name)
        end

        stack << [event, action]
      end

      return if stack.empty?

      # make the argument the same for all called actions
      prefix_arg = self.prefix_arg

      stack.reverse_each do |event, action|
        self.prefix_arg = prefix_arg
        action.call(event)
      end
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

    def at_eol?
      at_insert == at_insert.lineend
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
    def up_down_displayline(count)
      insert = at_insert

      @udl_pos_orig = insert if @udl_pos_prev != insert

      lines = count(@udl_pos_orig, insert, :displaylines)
      target = index("#@udl_pos_orig + #{lines + count} displaylines")
      @udl_pos_prev = target

      @udl_pos_orig = target if target.char == @udl_pos_orig.char
      target
    end

    # This method goes up and down lines, not taking line wrapping into account.
    # To go a line down, pass 1, to go one up -1, you get the idea.
    # Tries to maintain the same char position across lines.
    def up_down_line(count)
      insert = at_insert

      # if the last movement was not done by up_down_*, set new origin.
      @udl_pos_orig = insert if @udl_pos_prev != insert

      # count lines between origin and current insert position.
      lines = count(@udl_pos_orig, insert, :lines)
      # now get the target count lines below.
      target = index("#@udl_pos_orig + #{lines + count} lines")

      @udl_pos_prev = target

      # if target has the same char pos as the previous one, use it as origin.
      @udl_pos_orig = target if target.char == @udl_pos_orig.char
      target
    end

    def setup_highlight
      setup_highlight_for(Syntax.from_filename(filename)) if filename
    end

    def setup_highlight_for(syntax)
      return if encoding == Encoding::BINARY
      return unless syntax
      syntax = Syntax.new(syntax) unless syntax.is_a?(Syntax)

      self.syntax = syntax
      VER.cancel_block(@highlighter)

      interval = options.syntax_highlight_interval.to_int
      @highlighter = VER.when_inactive_for(interval){
        handle_pending_syntax_highlights
      }

      touch!('1.0', 'end')
      handle_pending_syntax_highlights

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
      apply_preferences
    rescue Errno::ENOENT, TypeError => ex
      VER.error(ex)
    end

    def apply_preferences
      return unless @preferences

      @preferences.each do |preference|
        next unless preference[:name] == "Comments"
        if settings = preference[:settings]
          if shell_variables = settings[:shellVariables]
            shell_variables.each do |variable|
              name, value = variable.values_at(:name, :value)
              ENV[name] = value

              case name
              when 'TM_COMMENT_START'
                options.comment_line = value
              end
            end
          end
        end
      end
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
        syntax.highlight(self, from.line - 1, from, to) if syntax
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
