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
      name = name.to_s

      if tag_exists?(name)
        tag_remove(name, '0.0', 'end')
      else
        options = TAG_ALL_MATCHING_OPTIONS.merge(options)
        TktNamedTag.new(self, name, options)
      end

      start = '0.0'
      while result = search_with_length(regexp, "#{start} + 1 chars", 'end - 1 chars')
        pos, len, match = result
        break if !result || len == 0

        tag_add name, pos, "#{pos} + #{len} chars"

        start = pos
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

      case keymap.current_mode
      when :select_char
        tag_add :sel, left, right
      when :select_line
        tag_add :sel, "#{left} linestart", "#{right} lineend"
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

    def delete(*args)
      super
      touch!
    end

    def insert(*args)
      super
      touch!
    end

    def first_highlight
      return unless @highlight_syntax = Syntax.from_filename(filename)

      @highlight_thread = Thread.new{
        this = Thread.current
        this[:pending] = 0

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

      refresh_highlight!
    end

    def refresh_highlight(lineno = 0)
      return unless @highlight_thread
      @highlight_thread[:pending] += 1
    end

    private

    def refresh_highlight!
      tag_all_matching('trailing_whitespace', /[ \t]+$/, foreground: '#000', background: '#f00')
      @highlight_syntax.highlight(self, value, lineno = 0)
    end

    def touch!
      Tk.event_generate(self, '<Modified>')
    end

    def copy(text)
      TkClipboard.set text
    end

    def mode=(name)
      keymap.current_mode = mode = name.to_sym

      cursor = MODE_CURSOR[mode]

      configure cursor
      @selection_start = nil
      # status.configure(background: cursor[:insertbackground])
    end
  end
end
