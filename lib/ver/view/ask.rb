require 'ver/action/ask'

module VER
  class AskView < StatusView
    attr_reader :limit_left

    HISTORY = []

    def ask(question, &block)
      View[:status].hide_window
      View[:info].hide_window
      show_window

      @question = question
      @block = block
      @buffer = MemoryBuffer.new(:ask)
      @limit_left = question.size
      draw

      catch(:answer){ focus_input }
    ensure
      HISTORY << @buffer
      hide_window
      View[:status].show_window
      View[:info].show_window
      View[:main].focus_input
    end

    def limit_right
      @buffer.size - 1
    end

    def draw
      @window.color_set Color[:yellow]
      y, x = @window.pos
      @window.move 0, 0
      @window.printw(@question)
      @window.printw(' ')
      @window.printw(@buffer[0..-1])
      @window.refresh
      @window.move(y)

=begin
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
=end
    end

    def finalize
    end

    def complete
      match, *matches = all = @block[buffer[0..-1]]

      if match and matches.empty?
        match
      elsif match
        all
      end
    end

    def press(key)
      KeyMap.press(key, :ask) do |mode, method|
        AskAction.new(self, mode, key).send(method)
        draw
      end
    end
  end
end
