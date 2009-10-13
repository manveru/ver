module VER
  class Text < Tk::Text
    include Methods

    MODE_CURSOR = {
      :insert       => {insertbackground: 'red',    blockcursor: false},
      :control      => {insertbackground: 'green',  blockcursor: true},
      :select_char  => {insertbackground: 'yellow', blockcursor: true},
      :select_line  => {insertbackground: 'yellow', blockcursor: true},
      :select_block => {insertbackground: 'yellow', blockcursor: true},
    }

    attr_accessor :keymap, :view, :status, :filename

    def initialize(view, options = {})
      super
      self.view = view

      keymap_name = VER.options.fetch(:keymap)
      self.keymap = Keymap.get(name: keymap_name, receiver: self)

      @selection_start = @highlight_thread = nil
      @pristine = true
    end

    def short_filename
      filename.sub(Dir.pwd + '/', '')
    end

    def open_path(path)
      @filename = Pathname(path.to_s).expand_path

      begin
        self.value = @filename.read
        status.message "Opened #{short_filename}"
      rescue Errno::ENOENT
        clear
        status.message "Create #{short_filename}"
      end

      after_open
    end

    def open_empty
      clear
      status.message "[No File]"
      after_open
    end

    def after_open
      VER.opened_file(self)

      edit_reset

      if @pristine
        Thread.new do
          wait_visibility
          setup_highlight
        end
      else
        setup_highlight
      end

      focus
      mark_set :insert, '0.0'

      @pristine = false
    end

    def layout
      view.layout
    end

    def quit
      Tk.exit
    end

    def insert_index
      index(:insert).split('.').map(&:to_i)
    end

    def end_index
      index(:end).split('.').map(&:to_i)
    end

    # lines start from 1
    # end is maximum lines + 1
    def status_projection(into)
      format = "%s  %d,%d  %d%% [%s]"

      insert_y, insert_x = insert_index
      end_y, end_x       = end_index

      percent = (100.0 / (end_y - 2)) * (insert_y - 1)
      percent = 100.0 if percent.nan?

      additional = [keymap.mode]
      syntax_name = @syntax.name if @syntax
      additional << syntax_name if syntax_name

      values = [
        short_filename,
        insert_y, insert_x,
        percent,
        additional.join(' | '),
      ]

      into.value = format % values
    end

    TAG_ALL_MATCHING_OPTIONS = {
      foreground: '#f00',
      background: '#00f',
    }

    def tag_all_matching(name, regexp, options = {})
      name = name.to_s

      if tag_exists?(name)
        tag_remove(name, '0.0', 'end')
      else
        options = TAG_ALL_MATCHING_OPTIONS.merge(options)
        TktNamedTag.new(self, name, options)
      end

      start = '0.0'
      while result = search_with_length(regexp, start, 'end - 1 chars')
        pos, len, match = result
        break if !result || len == 0

        start = "#{pos} + #{len} chars"
        tag_add name, pos, start
      end
    end

    def tag_exists?(given_path)
      list = tk_split_simplelist(tk_send_without_enc('tag', 'names', None), false, true)
      list.include?(given_path)
    end

    # Wrap Tk methods to behave as we want and to generate events
    def mark_set(mark_name, index)
      super

      return unless mark_name == :insert

      Tk.event_generate(self, '<Movement>')
    end

    def refresh_selection
      return unless start = @selection_start

      now = index(:insert).split('.').map(&:to_i)
      left, right = [start, now].sort.map{|pos| pos.join('.') }
      tag_remove :sel, '0.0', 'end'

      case keymap.mode
      when :select_char
        tag_add :sel, left, "#{right} + 1 chars"
      when :select_line
        tag_add :sel, "#{left} linestart", "#{right} lineend + 1 chars"
      when :select_block
        ly, lx = left.split('.').map(&:to_i)
        ry, rx = right.split('.').map(&:to_i)

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

      tk_send_without_enc('delete', *args)

      touch!
    end

    def insert(*args)
      super
      touch!
    end

    def setup_highlight
      return unless filename
      return unless @syntax = Syntax.from_filename(filename)

      @highlight_thread = create_highlight_thread
    end

    def create_highlight_thread
      @highlight_thread = Thread.new{
        this = Thread.current
        this[:pending] = 1

        loop do
          if this[:pending] > 0
            while this[:pending] > 0
              this[:pending] -= 1
              sleep 0.2
            end

            refresh_highlight!
          else
            sleep 0.5
          end
        end
      }
    end

    def refresh_highlight(lineno = 0)
      return unless @highlight_thread
      @highlight_thread[:pending] += 1
    end

    def caret(keys=nil)
      if keys
        tk_call_without_enc('tk', 'caret', self, *hash_kv(keys))
        self
      else
        lst = tk_split_list(tk_call_without_enc('tk', 'caret', self))
        info = {}
        while key = lst.shift
          info[key[1..-1]] = lst.shift
        end
        info
      end
    end

    def focus
      super
      Tk.event_generate(self, '<Focus>')
    end

    def fast_tag_add(tag, *indices)
      tk_send_without_enc('tag', 'add', _get_eval_enc_str(tag), *indices)
      self
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

      VER.root['title'] = title
    end

    private

    def refresh_highlight!
      tag_all_matching('trailing_whitespace', /[ \t]+$/, foreground: '#000', background: '#f00')
      @syntax.highlight(self, value, lineno = 0)
    end

    def touch!
      Tk.event_generate(self, '<Modified>')
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
      TkClipboard.set(text = text.to_str)

      copy_message text.count("\n"), text.size
    end

    def copy_array(text)
      TkClipboard.set(text, type: Array)

      copy_message text.size,  text.reduce(0){|s,v| s + v.size }
    end

    def copy_fallback(text)
      TkClipboard.set(text)

      status.message "Copied unkown entity of class %p" % [text.class]
    end

    def copy_message(lines, chars)
      lines_desc = lines == 1 ? 'line' : 'lines'
      chars_desc = chars == 1 ? 'character' : 'characters'

      msg = "copied %d %s of %d %s" % [lines, lines_desc, chars, chars_desc]
      status.message msg
    end

    def paste_continous(text)
      if text =~ /\n/
        mark_set :insert, 'insert lineend'
        insert :insert, "\n"
        insert :insert, text.chomp
      else
        insert :insert, text
      end
    end

    def paste_tk_array(tk_array)
      chunks = Tk.send(:simplelist, tk_array)

      insert_y, insert_x = index(:insert).split('.').map(&:to_i)

      chunks.each_with_index do |chunk, idx|
        y = insert_y + idx
        insert "#{y}.#{insert_x}", chunk
      end
    end

    def mode=(name)
      keymap.mode = mode = name.to_sym

      cursor = MODE_CURSOR[mode]
      configure cursor

      return unless status && color = cursor[:insertbackground]
      style = status.style
      Tk::Tile::Style.configure style, fieldbackground: color
    end

    def load_theme(name)
      return unless @syntax
      return unless found = Theme.find(name)

      @syntax.theme = Theme.load(found)
      refresh_highlight

      status.message "Theme #{found} loaded"
    end

    def load_syntax(name)
      return unless @syntax
      return unless found = Syntax.find(name)

      theme = @syntax.theme
      @syntax = Syntax.new(name, theme)
      refresh_highlight

      status.message "Syntax #{found} loaded"
    end

    def clear_selection
      @selection_start = nil
      tag_remove :sel, '0.0', 'end'
    end
  end
end
