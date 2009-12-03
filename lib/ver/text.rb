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

    GUESS_ENCODING_ORDER = [
      Encoding::US_ASCII,
      Encoding::UTF_8,
      Encoding::Shift_JIS,
      Encoding::EUC_JP,
      Encoding::EucJP_ms,
      Encoding::Big5,
      Encoding::UTF_16BE,
      Encoding::UTF_16LE,
      Encoding::UTF_32BE,
      Encoding::UTF_32LE,
      Encoding::CP949,
      Encoding::Emacs_Mule,
      Encoding::EUC_KR,
      Encoding::EUC_TW,
      Encoding::GB18030,
      Encoding::GBK,
      Encoding::Stateless_ISO_2022_JP,
      Encoding::CP51932,
      Encoding::EUC_CN,
      Encoding::GB12345,
      Encoding::Windows_31J,
      Encoding::MacJapanese,
      Encoding::UTF8_MAC,
      Encoding::BINARY,
    ]

    MATCH_WORD_RIGHT =  /[^a-zA-Z0-9]+[a-zA-Z0-9'"{}\[\]\n-]/
    MATCH_WORD_LEFT =  /(^|\b)\S+(\b|$)/

    attr_accessor :keymap, :view, :status
    attr_reader :filename, :encoding, :pristine, :syntax, :undoer

    # attributes for diverse functionality
    attr_accessor :selection_mode, :selection_start

    def initialize(view, options = {})
      super
      self.view = view
      @options = Options.new(:text, VER.options)

      keymap_name = @options.keymap
      self.keymap = Keymap.get(name: keymap_name, receiver: self)

      apply_mode_style(keymap.mode) # for startup
      setup_tags


      require 'ver/undo'
      @undoer = Undo::Tree.new(self)

      self.selection_start = nil
      @pristine = true
      @syntax = nil
      @encoding = Encoding.default_internal
      @dirty_indices = []

      self.mode = keymap.mode
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

    class StatusContext < Struct.new(:text)
      def filename(width = 0)
        "%#{width}s" % text.filename
      end
      alias F filename

      def basename(width = 0)
        "%#{width}s" % text.filename.basename
      end
      alias f basename

      def relative(width = 0)
        "%#{width}s" % text.short_filename
      end
      alias r relative

      def dir(width = 0)
        "%#{width}s" % text.filename.directory
      end
      alias d dir

      def line(width = 0)
        "%#{width}s" % (text.count('1.0', 'insert', :lines) + 1)
      end
      alias l line

      def lines(width = 0)
        "%#{width}s" % text.count('1.0', 'end', :lines)
      end
      alias L lines

      def column(width = 0)
        "%#{width}s" % text.count('insert linestart', 'insert', :displaychars)
      end
      alias c column

      def percent
        here = text.count('1.0', 'insert', :lines)
        total = text.count('1.0', 'end', :lines)
        percent = ((100.0 / total) * here).round

        case percent
        when 100; 'Bot'
        when 0  ; 'Top'
        else    ; '%2d%%' % percent
        end
      end
      alias P percent

      def buffer(width = 0)
        "%#{width}s" % text.layout.views.index(text.view)
      end
      alias b buffer

      def buffers(width = 0)
        "%#{width}s" % text.layout.views.size
      end
      alias B buffers

      def encoding(width = 0)
        "%#{width}s" % text.encoding
      end
      alias e encoding

      def syntax(width = 0)
        "%#{width}s" % text.syntax.name if text.syntax
      end
      alias s syntax

      def mode(width = 0)
        "%#{width}s" % text.keymap.mode
      end
      alias m mode

      # format sequences:
      #
      # %c Current capacity (mAh)
      # %r Current rate
      # %b short battery status, '+', '-', '!'
      # %p battery load percentage
      # %m remaining time in minutes
      # %h remaining time in hours
      # %t remaining time in as 'H:M'
      def battery(format = '[%b] %p% %t')
        now = Time.now

        if @battery_last
          if @battery_last < (now - 60)
            @battery_last = now
            @battery_value = battery_build(format)
          else
            @battery_value
          end
        else
          @battery_last = now
          @battery_value = battery_build(format)
        end
      rescue => ex
        puts ex, *ex.backtrace
        ex.message
      end

      def battery_build(format)
        total = {}

        Dir.glob('/proc/acpi/battery/*/{state,info}') do |file|
          parsed = battery_parse(file)
          next unless parsed[:present] == 'yes'
          # FIXME: doesn't take care of multiple batteries
          total.merge!(parsed)
        end

        # rate might be 0
        rate = total[:present_rate].to_i
        capacity = total[:remaining_capacity].to_i

        if rate == 0
          hours, percent = 2, 100
          time = hours_left = minutes_left = 'N/A'
        else
          hours, minutes = ((capacity * 60.0) / rate).divmod(60)
          minutes = minutes.round
          percent = ((100 / total[:last_full_capacity].to_f) * capacity).round
          hours_left = (hours + (minutes / 60.0)).round
          minutes_left = (hours / 60.0) + minutes
          time = "#{hours}:#{minutes}"
        end

        case total[:charging_state]
        when 'discharging'
          b = hours < 1 ? '!' : '-'
        when 'charging'
          b = '+'
        end

        final = {
          '%c' => capacity,
          '%r' => rate,
          '%b' => b,
          '%p' => percent,
          '%m' => minutes_left,
          '%h' => hours_left,
          '%t' => time,
        }

        @last = Time.now
        format.gsub(/%\w/, final)
      end

      def battery_parse(file)
        data = {}

        File.open(file) do |io|
          io.each_line do |line|
            next unless line =~ /^([^:]+):\s*(.+)$/
            data[$1.downcase.tr(' ', '_').to_sym] = $2
          end
        end

        data
      end
    end

    def status_projection(into)
      format = options.statusline.dup

      format.gsub!(/%([[:alpha:]]+)/, '#{\1()}')
      format.gsub!(/%_([[:alpha:]]+)/, '#{(_ = \1()) ? " #{_}" : ""}')
      format.gsub!(/%([+-]?\d+)([[:alpha:]]+)/, '#{\2(\1)}')
      format = "%{#{format}}"

      # puts format
      context = StatusContext.new(self)
      line = context.instance_eval(format)
      # p line

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

    def refresh_selection
      return unless start = selection_start

      now = index(:insert)
      left, right = [start, now].sort
      tag_remove :sel, '1.0', 'end'

      case selection_mode
      when :select_char
        tag_add :sel, left, "#{right} + 1 chars"
      when :select_line
        tag_add :sel, "#{left} linestart", "#{right} lineend"
      when :select_block
        ly, lx = left.split
        ry, rx = right.split

        from_y, to_y = [ly, ry].sort
        from_x, to_x = [lx, rx].sort

        from_y.upto to_y do |y|
          tag_add :sel, "#{y}.#{from_x}", "#{y}.#{to_x + 1}"
        end
      end
    end

    def insert(index, string)
      index = index(index) unless index.is_a?(Index)
      # p insert: [index, string]

      record_multi do |record|
        record.insert(index, string)
      end

      touch!(index)
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
      index1, index2 = index(index1), index(index2)
      return if index1 == index2
      p replace: [index1, index2, string]

      undoer.record do |record|
        record.replace(index1, index2, string)
        p record
      end

      undoer.compact!
      touch!(*index1.upto(index2).to_a)
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
        defer{ syntax.highlight(self, value) }
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

    # TODO: maybe we can make this one faster when many lines are going to be
    #       highlighted at once by bundling them.
    def touch!(*args)
      args.each{|arg| schedule_line_highlight(arg) } if @syntax
      Tk::Event.generate(self, '<<Modified>>')
    end

    def mode=(name)
      keymap.mode = mode = name.to_sym
      @undoer.separate!
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

    def load_preferences
      return unless @syntax

      name = @syntax.name
      file = VER.find_in_loadpath("preferences/#{name}.json")
      @preferences = JSON.load(File.read(file))
    rescue Errno::ENOENT, TypeError => ex
      VER.error(ex)
    end

    def setup_tags
      setup_highlight_trailing_whitespace
      setup_highlight_links
    end

    def setup_highlight_trailing_whitespace
      tag_configure 'invalid.trailing-whitespace', background: '#f00'
      tag_all_trailing_whitespace
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

      tag_all_uris
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
