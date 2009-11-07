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
    attr_reader :filename, :encoding, :pristine, :syntax

    # attributes for diverse functionality
    attr_accessor :selection_mode, :selection_start

    def initialize(view, options = {})
      super
      self.view = view

      keymap_name = VER.options.fetch(:keymap)
      self.keymap = Keymap.get(name: keymap_name, receiver: self)

      defer do
        sleep 1
        # Tk::Wait.visibility(self)
        apply_mode_style(keymap.mode) # for startup
        # setup_tags
      end

      self.selection_start = nil
      @pristine = true
      @encoding = VER.options.fetch(:encoding)
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

    def open_path(path, line = 1)
      self.filename = path

      begin
        enc = encoding.name
        self.value = filename.open("r:#{enc}"){|io| io.read }
        message "Opened #{short_filename}"
      rescue Errno::ENOENT
        delete '1.0', :end
        message "Create #{short_filename}"
      end

      after_open(line)
    end

    def open_empty
      delete '1.0', :end
      message "[No File]"
      after_open
    end

    def after_open(line = 1)
      VER.opened_file(self)

      edit_reset
      mark_set :insert, "#{line}.0"
      setup_highlight

      @pristine = false
    end

    def may_close
      return yield unless modified?
      return yield if persisted?

      question = 'Save this buffer before closing? [y]es [n]o [c]ancel: '

      status_ask question, take: 1 do |answer|
        case answer[0]
        when 'Y', 'y'
          yield if file_save
          "saved"
        when 'N', 'n'
          yield
          "closing without saving"
        else
          "Cancel closing"
        end
      end
    end

    def persisted?
      return false unless filename && filename.file?
      require 'digest/md5'

      on_disk = Digest::MD5.hexdigest(File.read(filename))
      in_memory = Digest::MD5.hexdigest(value)
      on_disk == in_memory
    end

    def layout
      view.layout
    end

    def quit
      VER.exit
    end

    # lines start from 1
    # end is maximum lines + 1
    def status_projection(into)
      format = "%s  %s  %s [%s]"

      top, bot = yview

      if top < 0.5
        percent = '[top]'
      elsif bot > 99.5
        percent = '[bot]'
      else
        percent = "#{bot.to_i}%"
      end

      additional = [keymap.mode]
      syntax_name = syntax.name if syntax
      additional << syntax_name if syntax_name

      values = [
        short_filename,
        index(:insert).idx,
        percent,
        additional.join(' | '),
      ]

      into.value = format % values
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
        TktNamedTag.new(self, name, foreground: fg, background: bg)
      end

      search_all(regexp, from, to) do |match, match_from, match_to|
        name = yield(match, match_from, match_to) if block_given?
        fast_tag_add name, match_from, match_to
      end
    end

    def search_all(regexp, from = '1.0', to = 'end - 1 chars')
      return Enumerator.new(self, :search_all, regexp, from) unless block_given?
      from, to = from.to_s, to.to_s

      while result = search_with_length(regexp, from, to)
        pos, len, match = result
        break if !result || len == 0
        from = "#{pos} + #{len} chars"
        yield(match, pos, from)
      end
    end

    def rsearch_all(regexp, from = 'end', to = '1.0')
      return Enumerator.new(self, :rsearch_all, regexp, from) unless block_given?

      while result = rsearch_with_length(regexp, from, to)
        pos, len, match = result
        break if !result || len == 0
        from = index("#{pos} - #{len} chars")
        yield(match, pos, from)
      end
    end

    def tag_exists?(given_path)
      list = execute('tag', 'names', None).to_a
      list.include?(given_path)
    rescue RuntimeError => ex
      false
    end

    # Wrap Tk methods to behave as we want and to generate events
    def mark_set(mark_name, index)
      super

      return unless mark_name == :insert

      see :insert
      refresh_selection
      defer{ status_projection(status) }
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

    # fix the ruby definition of delete, Tk allows more than 2 indices
    def delete(*args)
      if args.size > 2
        deleted = args.each_slice(2).map{|left, right| get(left, right) }
      else
        deleted = get(*args)
      end

      copy(deleted)

      execute('delete', *args)

      touch!(*args)
    end

    def insert(*args)
      super
      touch!(args.first)
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
    def replace(index1, index2, *rest)
      super
      touch!(*index(index1).upto(index(index2)).to_a)
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

      if @syntax = Syntax.from_filename(filename)
        # defer{ syntax.highlight(self, get('0.0', :end)) }
      end
    end

    def schedule_line_highlight(raw_index)
      return unless @syntax
      index = index(raw_index)
      # schedule_line_highlight!(index.y - 1, index.linestart, index.lineend)
    end

    def schedule_highlight(options = {})
      return unless @syntax
      # schedule_highlight!
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

    def copy(text)
      if text.respond_to?(:to_str)
        copy_string(text)
      elsif text.respond_to?(:to_ary)
        copy_array(text)
      else
        copy_fallback(text)
      end
    end

    def copy_string(text)
      clipboard_set(text = text.to_str)

      copy_message text.count("\n"), text.size
    end

    def copy_array(text)
      clipboard_set(text, type: Array)

      copy_message text.size, text.reduce(0){|s,v| s + v.size }
    end

    def copy_fallback(text)
      clipboard_set(text)

      message "Copied unkown entity of class %p" % [text.class]
    end

    def copy_message(lines, chars)
      lines_desc = lines == 1 ? 'line' : 'lines'
      chars_desc = chars == 1 ? 'character' : 'characters'

      msg = "copied %d %s of %d %s" % [lines, lines_desc, chars, chars_desc]
      message msg
    end

    def paste_continous(text)
      if text =~ /\n/
        mark_set :insert, 'insert lineend'
        insert :insert, "\n"
        text.each_line{|line| insert(:insert, line) }
      else
        insert :insert, text
      end
    end

    def paste_tk_array(tk_array)
      chunks = Tk.send(:simplelist, tk_array)

      insert_y, insert_x = index(:insert).split

      chunks.each_with_index do |chunk, idx|
        y = insert_y + idx
        insert "#{y}.#{insert_x}", chunk
      end
    end

    def mode=(name)
      keymap.mode = mode = name.to_sym
      edit_separator
      apply_mode_style(mode)
      status_projection(status) if status
    end

    def apply_mode_style(mode)
      cursor = MODE_CURSOR[mode]
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
      return unless syntax
      return unless found = Syntax.find(name)

      theme = syntax.theme
      @syntax = Syntax.new(name, theme)
      schedule_highlight

      message "Syntax #{found} loaded"
    end

    def setup_tags
      TktNamedTag.new self, 'invalid.trailing-whitespace', background: '#f00'
      TktNamedTag.new self, 'markup.underline.link' , underline: true, foreground: '#00f'

      tag_bind('markup.underline.link', '1') do |event|
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

      tag_all_trailing_whitespace
      tag_all_uris
    end

    def tag_all_uris(given_options = {})
      tag_all_matching('markup.underline.link', /https?:\/\/[^)\]}\s]+/, given_options)
    end

    def tag_all_trailing_whitespace(given_options = {})
      tag_all_matching('invalid.trailing-whitespace', /[ \t]+$/, given_options)
    end

    def defer
      # EM.defer do
        begin
          yield
        rescue Exception => ex
          VER.error(ex)
        end
      # end
    end
  end
end
