module VER
  module Methods
    module Bookmark
      def char_bookmark_visit(name = nil)
        if name
          named_bookmark_visit(name)
        else
          status_ask 'Bookmark name: ', take: 1 do |bm_name|
            named_bookmark_visit(bm_name)
          end
        end
      end

      def char_bookmark_add(name = nil)
        if name
          named_bookmark_add(name)
        else
          status_ask 'Bookmark name: ', take: 1 do |bm_name|
            named_bookmark_add(bm_name)
          end
        end
      end

      def named_bookmark_add(name = nil)
        if name
          bm = bookmarks.add_named(name, bookmark_value)
          message("Added bookmark [%s|%s:%d,%d]." % bm.to_a)
        else
          status_ask 'Bookmark name: ' do |bm_name|
            named_bookmark_add(bm_name)
          end
        end
      end

      def named_bookmark_remove(name = nil)
        if name
          if bm = bookmarks.delete(name)
            message("Removed bookmark [%s|%s:%d,%d]." % bm.to_a)
          else
            message("No Bookmark named %p." % [name])
          end
        else
          status_ask 'Bookmark name: ' do |bm_name|
            named_bookmark_remove(bm_name)
          end
        end
      end

      def named_bookmark_visit(name = nil)
        if name
          if bm = bookmarks[name]
            bookmark_open(bm)
          else
            message("No Bookmark named %p." % [name])
          end
        else
          status_ask 'Bookmark name: ' do |bm_name|
            named_bookmark_visit(bm_name)
          end
        end
      end

      def bookmark_toggle
        pos = bookmark_value

        if bm = bookmarks.at(pos)
          bookmarks.delete(bm)
          message("Removed bookmark [%s|%s:%d,%d]." % bm.to_a)
        else
          bm = bookmarks.add_unnamed(bookmark_value)
          message("Added bookmark [%s|%s:%d,%d]." % bm.to_a)
        end
      rescue => ex
        VER.error(ex)
      end

      def next_bookmark
        bookmark_open(bookmarks.next_from(bookmark_value))
      end

      def prev_bookmark
        bookmark_open(bookmarks.prev_from(bookmark_value))
      end

      private

      def bookmarks
        VER.bookmarks
      end

      def bookmark_value
        [filename, index(:insert)]
      end

      def bookmark_open(bookmark, use_x = true)
        return unless bookmark.respond_to?(:file) && bookmark.respond_to?(:index)

        view.find_or_create(bookmark.file) do |view|
          y, x = use_x ? bookmark.index.split : [bookmark.index.y, 0]
          view.text.mark_set(:insert, "#{y}.#{x}")
        end
      end
    end
  end
end
