module VER
  class AskAction < Action
    def answer_question
      return unless found = @view.try_answer
      throw(:answer, found)
    end

    def stop_asking
      # Log.debug :caller => caller
      throw(:answer, false)
    end

    def up
      # query history
    end

    def down
      # query history
    end

    def left
      if cursor_x <= @view.limit_left
        @window.move(cursor_y, @view.limit_left + 1)
      else
        @window.move(cursor_y, cursor_x - 1)
      end
    end

    def right
      if cursor_x >= @view.limit_right
        @window.move(cursor_y, @view.limit_right - 1)
      else
        @window.move(cursor_y, cursor_x + 1)
      end
    end

    def insert_character(char = @key)
      current_line do |line|
        line[cursor_x, 0] = char
      end
    end

    def insert_space
      insert_character(' ')
    end

    def insert_backspace
      current_line do |line|
        left
        line[cursor_x, 1] = ''
      end
    end

    def insert_delete
      current_line do |line|
        line[cursor_x, 1] = ''
      end
    end

    def completion
      found = @view.complete
      @view.input = found if found
      @view.try_answer
    end

    def exit
      VER.stop
    end

    def current_line
      Log.debug @buffer
      line = @buffer.each_line{|line| break(line) if line.number == view_y }
      Log.debug :line => line

=begin
      if block_given?
        yield(line)
        line.store!
      else
        line
      end
=end
    end
  end
end
