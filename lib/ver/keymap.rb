module VER
  module KeyMap
    MODES = {}

    module_function

    def let(name, &block)
      mode = MODES[name] ||= Mode.new(name)
      mode.let(&block)
    end

    def press(key, *modes)
      MODES.each do |mode_name, mode_map|
        if modes.include?(mode_name) and method = mode_map[key]
          return yield(mode_name, method)
        end
      end

      Log.warn "not mapped key: %p in modes: %p" % [key, modes]
    rescue Exception => ex
      Log.error "Key: %p in modes: %p" % [key, modes]
      Log.error ex
    end

    class Mode
      def initialize(name)
        @name = name
        @map = {}
      end

      def let(&block)
        instance_eval(&block)
      end

      def keys(keys, method)
        keys.each{|k| self[k] = method }
      end

      def key(k, method)
        self[k] = method
      end

      def [](key)
        @map[key.to_s]
      end

      def []=(key, method)
        @map[key.to_s] = method
      end
    end
  end

  class Action
    WORD_PART = VER::Keyboard::PRINTABLE.grep(/\w/)
    WORD_BREAK = Regexp.union(*(VER::Keyboard::PRINTABLE - WORD_PART))
    CHUNK_BREAK = /\s+/

    def initialize(view, mode, key)
      @view, @mode, @key = view, mode, key
      @window, @buffer = @view.window, @view.buffer
    end

    def down
      return unless following = @buffer.line_at(view_y + 1)
      following_end = following.size - 2

      Log.debug :cursor_y => cursor_y, :@window_height => @window.height

      if (cursor_y + 1) < @window.height
        @window.move(cursor_y + 1, cursor_x)
        @window.move(cursor_y, following_end) if following_end < cursor_x
      else
        @view.scroll(1)
      end

      return true
    end

    def up
      return unless prev = @buffer.line_at(view_y - 1)
      prev_end = prev.size - 2

      if cursor_y <= @window.top
        @view.scroll -1
      else
        @window.move(cursor_y - 1, cursor_x)
        @window.move(cursor_y, prev_end) if prev_end < cursor_x
      end

      return true
    end

    def left
      if cursor_x == 0
        end_of_line if up
      else
        @window.move(cursor_y, cursor_x - 1)
      end
    end

    def right
      offset = cursor_x + 1

      if offset > (current_line.size - 2)
        beginning_of_line if down
      elsif @window.width >= offset
        @window.move(cursor_y, offset)
      else
        beginning_of_line if down
      end
    end

    def beginning_of_line
      @window.move(cursor_y, 0)
    end

    def end_of_line
      @window.move(cursor_y, current_line.size - 2)
    end

    def word_right
      this_line, following_line = @buffer.lines_at(view_y, view_y + 1)

      if offset = this_line.to_s.index(WORD_BREAK, cursor_x + 1)
        @window.move(cursor_y, offset + 1)
      elsif following_line
        down
        beginning_of_line
        word_right
      else
        end_of_line
      end
    end

    def chunk_right
      this_line, following_line = @buffer.lines_at(view_y, view_y + 1)

      if offset = this_line.to_s.index(CHUNK_BREAK, cursor_x + 1)
        @window.move(cursor_y, offset + 1)
      elsif following_line
        down
        beginning_of_line
        word_right
      else
        end_of_line
      end
    end

    def word_left
      prev, this = @buffer.lines_at(view_y - 1, view_y)

      if offset = this.to_s.rindex(WORD_BREAK, cursor_x)
        @window.move(cursor_y, offset - 1)
      elsif prev
        up
        end_of_line
        word_left
      end
    end

    def chunk_left
      prev, this = @buffer.lines_at(view_y - 1, view_y)

      if offset = this.to_s.rindex(CHUNK_BREAK, cursor_x)
        @window.move(cursor_y, offset - 1)
      elsif prev
        up
        end_of_line
        word_left
      end
    end

    def append_end_of_line
      end_of_line
      append
    end

    def append
      right
      into_insert_mode
    end

    def undo
      @buffer.undo
    end

    def insert_beginning_of_line
      beginning_of_line
      into_insert_mode
    end

    def insert_return
      insert_string_here("\n")
      down
      beginning_of_line
    end

    def insert_backspace
      if cursor_x == 0
        join_line_up
      else
        line = current_line
        line[cursor_x - 1, 1] = ''
        line.store!
        left
      end
    end

    def insert_delete
      line = current_line
      line[cursor_x, 1] = ''
      line.store!
    end

    def join_line_up
      prev, this = @buffer.lines_at(view_y - 1, view_y)
      prev.join!(this) if prev
    end

    def join_line_down
      this, following = @buffer.lines_at(view_y, view_y + 1)
      this.join!(following) if following
    end

    def insert_space
      insert_string_here(' ')
    end

    def insert_character
      insert_string_here(@key)
    end

    def buffer_persist
      filename = @buffer.save_file
      # View[:status].show "Saved to: #{filename}"
    end

    def buffer_close
      throw(:close)
    end

    def buffer_open
      ask do |got|
      end

      @buffer.load_file
    end

    # mode switching

    def into_control_mode
      into_mode :control
    end

    def into_replace_mode
      into_mode :replace
    end

    def into_insert_mode
      into_mode :insert
    end

    private

    def into_mode(name)
      return if @mode == name
      left if name == :control
      @view.modes = [name]
    end

    def current_line
      @buffer.line_at(view_y)
    end

    def insert_string_here(string)
      line = current_line
      line[cursor_x, 0] = string
      Log.debug :string => string, :line => line.line
      @window.move(cursor_y, cursor_x + string.size)
      line.store!
    end

    def view_y
      cursor_y + @view.offset
    end

    def cursor_x
      @window.x
    end

    def cursor_y
      @window.y
    end

    def pos
      @window.pos
    end
  end
end

VER::KeyMap.let :insert do
  keys VER::Keyboard::PRINTABLE, :insert_character
  key :space,     :insert_space
  key :return,    :insert_return
  key 'C-m',      :insert_return
  key :backspace, :insert_backspace
  key :dc,        :insert_delete

  # move

  key :up, :up
  key :down, :down
  key :left, :left
  key :right, :right

  # mode switches

  key :esc,  :into_control_mode
  key 'C-c', :into_control_mode # esc is slow due to timeout
end

VER::KeyMap.let :control do
  key :a,    :append
  key :A,    :append_end_of_line
  key :s,    :delete_then_input
  key :J,    :join_line_down
  key 'C-s', :buffer_persist
  key 'C-w', :buffer_close
  key 'C-o', :buffer_open
  key 'I',   :insert_beginning_of_line
  key '0',   :beginning_of_line
  key '$',   :end_of_line
  key :u,    :undo

  # mode switches

  key :R,   :into_replace_mode
  key :i,   :into_insert_mode
  key :esc, :into_control_mode

  # move

  key :h, :left
  key :j, :down
  key :k, :up
  key :l, :right

  key :up, :up
  key :down, :down
  key :left, :left
  key :right, :right

  key :w, :word_right
  key :W, :chunk_right
  key :b, :word_left
  key :B, :chunk_left
end
