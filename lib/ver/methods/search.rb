module VER
  module Methods
    module Search
      # FIXME: Ruby is very, very, noisy on invalid regular expressions and may
      #       raise two different errors. the raising we can deal with, but
      #       without closing $stderr the warnings are unstoppable.
      #       So we try to use one of the many hacks from DHH (found in facets)
      SEARCH_PROC = lambda{|got|
        valid = false

        unless got.empty?
          view = View[:file]

          begin
            silently do
              if got == got.downcase # go case insensitive
                regex = /#{got}/i
              else
                regex = /#{got}/
              end

              valid = true
              view.search = regex
            end
          rescue RegexpError, SyntaxError => ex
            Log.error(ex)
            View[:ask].draw_exception(ex)
          end

          view.draw
          view.window.refresh
        end

        [valid, [got]]
      }

      def search
        VER.ask('Search: ', SEARCH_PROC) do |regex|
          highlight_all_search_results
          next_search
        end
      end

      def highlight_all_search_results
        cursors = view.highlights[:search] = buffer.grep_successive_cursors(view.search)
        cursors.each{|c| c.color = view.colors[:search] }
      end

      def next_search
        highlights = view.highlights[:search]
        sorted = highlights.sort_by{|c| [c.pos, c.mark].min }

        if coming = sorted.find{|c| c.pos > cursor.pos and c.mark > cursor.pos }
          view.cursor.pos = coming.pos
        end
      end

      def previous_search
        highlights = view.highlights[:search]
        sorted = highlights.sort_by{|c| -[c.pos, c.mark].min }

        if coming = sorted.find{|c| c.pos < cursor.pos and c.mark < cursor.pos }
          view.cursor.pos = coming.pos
        end
      end
    end
  end
end
