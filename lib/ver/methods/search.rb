module VER
  module Methods
    module Search
      def search
        VER.ask('Search: ', SEARCH_PROC) do |regex|
          # view.highlights = view.buffer.grep_cursors(/#{regex}/i)
          next_highlight
          View.active.draw
        end
      end

      def next_highlight
        sorted = view.highlights.sort_by{|c| [c.pos, c.mark].min }
        if coming = sorted.find{|c| c.pos > cursor.pos and c.mark > cursor.pos }
          view.cursor.pos = coming.pos
        end
      end

      def previous_highlight
        sorted = view.highlights.sort_by{|c| -[c.pos, c.mark].min }

        if coming = sorted.find{|c| c.pos < cursor.pos and c.mark < cursor.pos }
          view.cursor.pos = coming.pos
        end
      end
    end
  end
end
