module VER
  module Methods
    module Bookmark
      class << self
        def visit_char(text, name = nil)
          if name
            visit_named(text, name)
          else
            text.status_ask 'Bookmark name: ', take: 1 do |bm_name|
              visit_named(text, bm_name)
            end
          end
        end

        def add_char(text, name = nil)
          if name
            add_named(text, name)
          else
            text.status_ask 'Bookmark name: ', take: 1 do |bm_name|
              add_named(text, bm_name)
            end
          end
        end

        def add_named(text, name = nil)
          if name
            bm = bookmarks.add_named(name, bookmark_value(text))
            VER.message("Added bookmark [%s|%s:%d,%d]." % bm.to_a)
          else
            text.status_ask 'Bookmark name: ' do |bm_name|
              add_named(text, bm_name)
            end
          end
        end

        def remove_named(text, name = nil)
          if name
            if bm = bookmarks.delete(name)
              VER.message("Removed bookmark [%s|%s:%d,%d]." % bm.to_a)
            else
              VER.message("No Bookmark named %p." % [name])
            end
          else
            text.status_ask 'Bookmark name: ' do |bm_name|
              remove_named(text, bm_name)
            end
          end
        end

        def visit_named(text, name = nil)
          if name
            if bm = bookmarks[name]
              open(text, bm)
            else
              VER.message("No Bookmark named %p." % [name])
            end
          else
            text.status_ask 'Bookmark name: ' do |bm_name|
              visit_named(text, bm_name)
            end
          end
        end

        def toggle(text)
          pos = bookmark_value(text)

          if bm = bookmarks.at(pos)
            bookmarks.delete(bm)
            message("Removed bookmark [%s|%s:%d,%d]." % bm.to_a)
          else
            bm = bookmarks.add_unnamed(pos)
            message("Added bookmark [%s|%s:%d,%d]." % bm.to_a)
          end
        rescue => ex
          VER.error(ex)
        end

        def next(text)
          open(text, bookmarks.next_from(bookmark_value(text)))
        end

        def prev(text)
          open(text, bookmarks.prev_from(bookmark_value(text)))
        end

        private

        def bookmarks
          VER.bookmarks
        end

        def bookmark_value(text)
          [text.filename, *text.index(:insert).split]
        end

        def open(text, bookmark, use_col = true)
          return unless bookmark.respond_to?(:file) && bookmark.respond_to?(:index)

          line, col = use_col ? bookmark.index : [bookmark.line, 0]
          VER.find_or_create_buffer(bookmark.file, line, col)
        end
      end # << self
    end # Bookmark
  end # Methods

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

    class Bookmark < Struct.new(:name, :file, :line, :column)
      include Comparable

      def <=>(other)
        [file, index] <=> [other.file, other.index]
      end

      def index
        [line, column]
      end

      def index=(index)
        self.line, self.column = *index
      end

      def to_a
        [name, file, *index]
      end
    end # Bookmark
  end # Bookmarks
end # VER
