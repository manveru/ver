module VER
  module Methods
    module Bookmark
      module_function

      def ask(buffer)
        buffer.ask 'Bookmark name: ' do |answer, action|
          case action
          when :modified, :attempt
            if (name = answer[0])
              yield name
              :abort
            else
              buffer.message 'Need a bookmark name'
            end
          end
        end
      end

      def visit_char(buffer, name = nil)
        if name
          visit_named(buffer, name)
        else
          ask(buffer) { |answer| visit_named(buffer, answer) }
        end
      end

      def add_char(buffer, name = nil)
        if name
          add_named(buffer, name)
        else
          ask(buffer) { |answer| add_named(buffer, answer) }
        end
      end

      def add_named(buffer, name = nil)
        if name
          bm = bookmarks.add_named(name, value(buffer))
          buffer.message(format('Added bookmark [%s|%s:%d,%d].', bm.to_a))
        else
          ask(buffer) { |answer| add_named(buffer, answer) }
        end
      end

      def remove_named(buffer, name = nil)
        if name
          if bm = bookmarks.delete(name)
            buffer.message(format('Removed bookmark [%s|%s:%d,%d].', bm.to_a))
          else
            buffer.message(format('No Bookmark named %p.', name))
          end
        else
          ask(buffer) { |answer| remove_named(buffer, answer) }
        end
      end

      def visit_named(buffer, name = nil)
        if name
          if bm = bookmarks[name]
            open(buffer, bm)
          else
            buffer.message(format('No Bookmark named %p.', name))
          end
        else
          ask(buffer) { |answer| visit_named(buffer, answer) }
        end
      end

      def toggle(buffer)
        pos = value(buffer)

        if bm = bookmarks.at(pos)
          bookmarks.delete(bm)
          message(format('Removed bookmark [%s|%s:%d,%d].', bm.to_a))
        else
          bm = bookmarks.add_unnamed(pos)
          message(format('Added bookmark [%s|%s:%d,%d].', bm.to_a))
        end
      rescue StandardError => ex
        VER.error(ex)
      end

      def next(buffer)
        open(buffer, bookmarks.next_from(value(buffer)))
      end

      def prev(buffer)
        open(buffer, bookmarks.prev_from(value(buffer)))
      end

      def bookmarks
        VER.bookmarks
      end

      def value(buffer)
        [buffer.filename, *buffer.index(:insert)]
      end

      def open(_buffer, bookmark, use_col = true)
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
      bm = if value.is_a?(Bookmark)
             value.dup
           else
             Bookmark.new(name, *value.to_a)
           end

      @bm << bm
      @bm.uniq!
      @bm.sort!
      bm
    end
    alias []= add_named

    def add_unnamed(value)
      bm = if value.is_a?(Bookmark)
             value
           else
             Bookmark.new(nil, *value.to_a)
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
      @bm.find { |bm| bm.name == name }
    end

    def key?(name)
      @bm.any? { |bm| bm.name == name }
    end

    def delete(name)
      if found = @bm.find { |bm| bm.name == name }
        @bm.delete(found)
      end
    end

    def next_from(pos)
      needle = Bookmark.new(nil, *pos)
      @bm.find { |bm| bm > needle }
    end

    def prev_from(pos)
      needle = Bookmark.new(nil, *pos)
      @bm.reverse.find { |bm| needle > bm }
    end

    def at(pos)
      needle = Bookmark.new(nil, *pos)
      @bm.find { |bm| needle == bm }
    end

    class Bookmark < Struct.new(:name, :file, :line, :char)
      include Comparable

      def <=>(other)
        [file, index] <=> [other.file, other.index]
      end

      def index
        [line, char]
      end

      def index=(index)
        self.line, self.char = *index
      end

      def to_a
        [name, file, *index]
      end
    end # Bookmark
  end # Bookmarks
end # VER
