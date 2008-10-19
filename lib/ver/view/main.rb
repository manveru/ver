require 'ver/action/main'

module VER
  class MainView < View
    def press(key)
      KeyMap.press(key, *modes) do |mode, signature|
        # VER.info "%p in %s mode called: %s" % [key, mode, signature]
        MainAction.new(self, mode, key).send(*signature)
      end

      draw
    end

    def draw
      pos = adjust_offset
      @window.move 0, 0
      last = 0
      @window.color_set Color[:white]

      buffer.each_line do |line|
        if visible_line?(line.number)
          @window.print_line(line)
          last = line.number
        end
      end

      @window.color_set Color[:yellow]
      (last..visible_lines.end).each do
        @window.print_line('~')
      end

      VER.status(status_line)
      @window.move(*pos)
    end

    STATUS_LINE = "%s [%s] (%s) %d,%d  Buffer %d/%d"

    def status_line
      modified = buffer.modified? ? '+' : ' '
      file     = buffer.filename
      modes    = @modes.join(',')
      row, col = cursor.to_pos
      n, m     = @buffers.index(buffer) + 1, @buffers.size

      STATUS_LINE % [file, modified, modes, row + offset, col, n, m]
    end
  end
end
