module VER
  # Common funcionality for Tk::Text widgets, mostly with shortcuts and helpers
  # for VER.
  class Text < ::Tk::Text
    require_relative 'text/position'
    require_relative 'text/tag'
    require_relative 'text/index'
    require_relative 'text/mark'
    require_relative 'text/range'
    require_relative 'text/selection'
    require_relative 'text/insert'
    require_relative 'text/end'

    attr_reader :lock

    def execute(*args, &block)
      super unless lock
    end

    def execute_only(*args, &block)
      super unless lock
    end

    def focus(*args)
      super unless lock
    end

    def place_forget(*args)
      super unless lock
    end

    def inspect
      format('#<VER::Text %p>', tk_pathname)
    end

    def index(idx)
      Index.new(self, execute('index', idx).to_s)
    end

    def index(position)
      Index.new(self, super.to_s)
    end

    def insert=(position)
      at_insert.index = position
    end

    def tag(name, *indices)
      if indices.empty?
        Tag.new(self, name)
      else
        tag = Tag.new(self, name)
        tag.add(*indices)
        tag
      end
    end

    def tags(index = Tk::None)
      tag_names(index).map { |name| Tag.new(self, name) }
    end

    def tag_ranges(tag_name)
      super(tag_name).map { |first, last| range(first, last) }
    end

    def range(first, last)
      Range.new(self, Index.new(self, first), Index.new(self, last))
    end

    def mark(name, index = nil, gravity = nil)
      mark = Mark.new(self, name, index)
      mark.gravity = gravity if gravity
      mark
    end

    def marks
      mark_names.map { |name| Mark.new(self, name) }
    end

    def mark_next(index)
      name = super
      Mark.new(self, name) if name
    end

    def mark_previous(index)
      name = super
      Mark.new(self, name) if name
    end
  end
end
