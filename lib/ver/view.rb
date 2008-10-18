module VER
  # Responsibilities:
  # * draw contents
  # * relation between window, buffer (and cursors?)
  # * Define the borders of visibility

  class View
    LIST = {}

    def self.[](name)
      LIST[name]
    end

    def self.[]=(name, view)
      LIST[name] = view
    end

    def self.draw
      LIST.each{|name, view| view.draw }
    end

    def self.resize
      LIST.each{|name, view| view.resize }
    end

    attr_accessor :window, :buffers, :modes
    attr_reader :name, :offset

    def initialize(name, window, *buffers)
      @name, @window, @buffers = name, window, buffers
      @modes = [:control]
      @offset = 0
      @bottom = @window.height
      @redraw = true

      View::LIST[name] = self

      yield(self) if block_given?
    end

    def focus_input
      focus
      View.draw
      Keyboard.focus(self)
      Keyboard.poll
    end

    def resize
      @window.resize
    end

    def show_window
      @window.show
    end

    def hide_window
      @window.hide
    end

    def cursor
      line = window.y + @offset
      line_start = buffer.index(/\A(.+\n){#{line}}/).to_s.size + window.x
      Cursor.new(buffer, line_start)
    end

    # Buffer position to window y, x
    def pos2yx(pos)
      # lines = buffer[0..pos].split("\n")
      chunk = buffer[0..pos]
      y = chunk.count("\n")
      x = chunk[/^.+\Z/].size

      return y, x
    end

    # window y, x to buffer position
    def yx2pos(y, x)
      y_pos = y + offset

      buffer.each_line do |line|
        return line.range.begin + x if line.number == y_pos
      end

      return 0
    end

    def scroll(n)
      @offset += n
      @offset = 0 if @offset < 0
    end

    def focus
      @window.move(@window.y, @window.x)
    end

    def draw
      buffer.draw_on(@window, @offset) if buffer
    end

    def show(string)
      buffer[nil] = string
      window.clear
      draw
      window.refresh
      View[:main].focus
    end
  end
end

__END__

    def self.ask(question, *answers, &block)
      window = Window.new{ {
        :height => 2,
        :width  => Ncurses.stdscr.getmaxx,
        :top    => Ncurses.stdscr.getmaxy - 2,
        :left   => 0 } }

      buffer = MemoryBuffer.new(:ask)
      view = self.new(:ask, window, buffer)

      view = View[:ask]
      view.show(question)
      view.window.move(0, (question.size + 1))

      if block_given?
        view.expect(&block)
      else
        abbrev = answers.map{|a| a.to_s }.abbrev
        view.expect(abbrev)
      end

      catch(:answer){
        Keyboard.focus(view)
        Keyboard.poll
      }
    ensure
      Keyboard.focus View[:main]
    end

    attr_accessor :input, :input_color

    ANSWER_COLOR = {:match => :green, :mismatch => :red}

    def draw
      @window.printw "duh"
    end
  end
end

__END__

    def draw
      @input_color ||= ANSWER_COLOR[:mismatch]
      @suggestions ||= []

      y, x = @window.pos
      question, answer = buffer.line_at(0).to_s, " #@input\n"
      x = (question + answer).size - 1

      chunks = [
        [Color[COLOR[@name]], question],
        [Color[input_color],  answer],
      ]
      esc = Regexp.escape(@input.to_s)
      @suggestions.each{|suggestion|
        if tail = suggestion.dup.gsub!(/^#{esc}/, '')
          chunks << [Color[:green], " #@input"]
          chunks << [Color[:yellow], tail]
        end
      }

      @window.show_colored_chunks(chunks)
      @window.move(y, x)
    end

    def expect(hash = {}, &block)
      @input = ''
      @suggestions = []
      @expect = block_given? ? block : hash
    end

    # Be careful with the result of @expect, we don't wanna modify it
    def complete(answer = @input)
      if found = @expect[answer]
        @input_color = ANSWER_COLOR[:match]
        found.dup
      else
        @input_color = ANSWER_COLOR[:mismatch]
        nil
      end
    end
    alias try_answer complete

    def press(key)
      KeyMap.press(key, :ask) do |mode, method|
        AskAction.new(self, mode, key).send(method)
        update
        draw
      end
    end
  end

  class FileView < AskView
    def try_answer(path = @input.dup)
      File.file?(path) ? path : nil
    end

    def complete(path = @input.dup)
      suggestions(path).abbrev.keys.min_by{|k| k.size }.dup
    end

    def suggestions(path)
      Dir["#{path}*"]
    end

    def uselss
      first, *rest = all = Dir["#{path}*"]
      @suggestions = all

      if first and rest.empty?
        @input_color = ANSWER_COLOR[:match]
        first
      elsif all.any?
        @input_color = ANSWER_COLOR[:mismatch]
        all.abbrev.keys.min_by{|k| k.size }.dup
      else
        @input_color = ANSWER_COLOR[:mismatch]
        path.dup
      end
    end

    def old_try_answer(answer = @input)
      if File.file?(answer)
        @suggestions = []
        @input_color = ANSWER_COLOR[:match]
        answer.dup
      elsif File.directory?(answer)
#         answer << '/'
#         answer.squeeze!('/')
        @input_color = ANSWER_COLOR[:mismatch]
        complete(answer)
      end
    end
  end
end
