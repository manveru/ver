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

    attr_accessor :keymap, :view, :status

    def initialize(view, options = {})
      super
      self.view = view

      keymap_name = VER.options.fetch(:keymap)
      self.keymap = Keymap.get(name: keymap_name, receiver: self)

      self.mode = :control
    end

    # lines start from 1
    # end is maximum lines + 1
    def status_projection(into)
      format = "%s  %d,%d  %d%% -- %s --"

      insert_y, insert_x = index(:insert).split('.').map(&:to_i)
      end_y, end_x       = index(:end   ).split('.').map(&:to_i)

      percent = (100.0 / (end_y - 2)) * (insert_y - 1)

      values = [
        view.file_path,
        insert_y, insert_x,
        percent,
        keymap.current_mode
      ]

      into.value = format % values
    end

    TAG_ALL_MATCHING_OPTIONS = {
      foreground: '#f00',
      background: '#00f',
    }

    def tag_all_matching(name, regexp, options = {})
      tag_delete name
      options = TAG_ALL_MATCHING_OPTIONS.merge(options)
      TktNamedTag.new(self, name, options)

      start = '0.0'
      while result = search_with_length(regexp, "#{start} + 1 chars", 'end - 1 chars')
        pos, len, match = result
        break if !result || len == 0

        tag_add name, pos, "#{pos} + #{len} chars"

        start = pos
      end
    end

    # Wrap Tk methods to behave as we want and to generate events
    def mark_set(mark_name, index)
      super

      Tk.event_generate(self, '<Movement>')

      mode = keymap.current_mode
      if mode =~ /^select/ && start = @selection_start
        now = index(:insert).split('.').map(&:to_i)
        left, right = [start, now].sort.map{|pos| pos.join('.') }
        tag_remove :sel, '0.0', 'end'
        tag_add :sel, left, right
      end

      see :insert if mark_name == :insert
    end

    def delete(*args)
      super
      touch!
    end

    def insert(*args)
      super
      touch!
    end

    def first_highlight
      @highlight_syntax = Syntax.from_filename(view.file_path)
      refresh_highlight
    end

    def refresh_highlight
      @highlight_syntax.highlight(self, value)
    end

    def touch!
      # refresh_highlight
    end

    private

    def mode=(name)
      keymap.current_mode = mode = name.to_sym

      cursor = MODE_CURSOR[mode]

      configure cursor
      @selection_start = nil
      # status.configure(background: cursor[:insertbackground])
    end
  end
end
