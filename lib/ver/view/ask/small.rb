module VER
  class View
    class AskSmall < View
      module Methods

        def history_backward
          view.input = view.history[history_pick]
        end

        def history_forward
          view.input = view.history[history_pick]
        end

        def history_pick
          view.history_pick = [0, view.history_pick + 1, view.history.size].sort[1]
        end

        def pick
          view.update_choices

          if answer = view.answer
            view.block.call(answer)
            view.history << answer unless view.history.last == answer
            view.close
            View[:file].open
          end
        end

        def stop
          view.close
          View[:file].open
        end

        def completion
          view.update_choices
          view.try_completion
        end
      end

      LAYOUT = {
        :width => lambda{|w| w },
        :height => 2,
        :top => lambda{|h| h - 2},
        :left => 0
      }

      DEFAULT = {
        :interactive => true,
        :mode => :ask
      }

      attr_reader :prompt, :valid, :choices, :block, :history
      attr_accessor :history_pick

      def initialize(*args)
        super
        @buffer = MemoryBuffer.new(:ask)
        @prompt = '>'
        @history = [] # Hash.new{|h,k| h[k] = [] }
      end

      def open(prompt, completer, &block)
        @prompt, @completer, @block = prompt, completer, block
        @buffer.clear
        @choices.clear if @choices
        @history_pick = @history.size

        update_choices

        super()
      end

      def press(key)
        super{|key| update_choices }
      end

      def answer
        buffer.to_s if @valid
      end

      def draw
        window.move 0, 0
        window.wdeleteln
        window.wdeleteln
        window.color = Color[:white]
        window.print "#{@prompt}#{buffer}"

        if @choices
          window.move 1, 0
          window.print_line @choices.join(' ')
        end

        window.move 0, (cursor.pos + @prompt.size)
        window.refresh
      end

      def update_choices
        @valid, @choices = @completer.call(buffer.to_s)
        @choices.map!{|c| c.to_s }
      end

      # FIXME: improve completion to be useful instead of annoying
      def try_completion
        if @choices.size == 1
          self.input = @choices.first
          return true
        elsif @choices.any?
          string = @choices.abbrev.keys.min_by{|k| k.size }[0..-2]
          self.input = string unless string.empty?
          return false
        end
      end
    end
  end
end
