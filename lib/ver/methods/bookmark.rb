module VER
  class Bookmarks
    include Enumerable

    def initialize
      @bm = []
      @idx = nil
    end

    def each(&block)
      @bm.each(&block)
    end

    def add_named(name, value)
      if value.is_a?(Bookmark)
        bm = value.dup
      else
        bm = Bookmark.new(name, *value.to_a)
      end

      @bm << bm
      @bm.uniq!
      @bm.sort!
      bm
    end
    alias []= add_named

    def add_unnamed(value)
      if value.is_a?(Bookmark)
        bm = value
      else
        bm = Bookmark.new(nil, *value.to_a)
      end

      @bm << bm
      @bm.uniq!
      @bm.sort!
      bm
    end

    def <<(value)
      add_unnamed(value)
      self
    end

    def [](name)
      @bm.find{|bm| bm.name == name }
    end

    def key?(name)
      @bm.any?{|bm| bm.name == name }
    end

    def delete(name)
      if found = @bm.find{|bm| bm.name == name }
        @bm.delete(found)
      end
    end

    def next_from(pos)
      needle = Bookmark.new(nil, *pos)
      @bm.find{|bm| bm > needle }
    end

    def prev_from(pos)
      needle = Bookmark.new(nil, *pos)
      @bm.reverse.find{|bm| needle > bm }
    end

    def at(pos)
      needle = Bookmark.new(nil, *pos)
      @bm.find{|bm| needle == bm }
    end

    class Bookmark < Struct.new(:name, :file, :index)
      include Comparable

      def <=>(other)
        [file, index] <=> [other.file, other.index]
      end

      def to_a
        [name, file, index.y, index.x]
      end
    end

    module Methods
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
