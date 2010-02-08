module VER
  module Methods
    module Bookmark
      module_function

      def ask(text)
        text.ask 'Bookmark name: ' do |answer, action|
          case action
          when :modified, :attempt
            if name = answer[0]
              yield name
              :abort
            else
              VER.message 'Need a bookmark name'
            end
          end
        end
      end

      def visit_char(text, name = nil)
        if name
          visit_named(text, name)
        else
          ask(text){|bm| visit_named(text, bm) }
        end
      end

      def add_char(text, name = nil)
        if name
          add_named(text, name)
        else
          ask(text){|bm| add_named(text, bm) }
        end
      end

      def add_named(text, name = nil)
        if name
          bm = bookmarks.add_named(name, value(text))
          VER.message("Added bookmark [%s|%s:%d,%d]." % bm.to_a)
        else
          ask(text){|bm| add_named(text, bm) }
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
          ask(text){|bm| remove_named(text, bm) }
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
          ask(text){|bm| visit_named(text, bm) }
        end
      end

      def toggle(text)
        pos = value(text)

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
        open(text, bookmarks.next_from(value(text)))
      end

      def prev(text)
        open(text, bookmarks.prev_from(value(text)))
      end

      def bookmarks
        VER.bookmarks
      end

      def value(text)
        [text.filename, *text.index(:insert).split]
      end

      def open(text, bookmark, use_col = true)
        return unless bookmark.respond_to?(:file) && bookmark.respond_to?(:index)

        line, col = use_col ? bookmark.index : [bookmark.line, 0]
        VER.find_or_create_buffer(bookmark.file, line, col)
      end
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
