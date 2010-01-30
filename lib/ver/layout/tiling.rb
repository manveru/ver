module VER
  class TilingLayout < Tk::Tile::LabelFrame
    autoload :CommonTiling, 'ver/layout/tiling/common'
    autoload :HorizontalTiling, 'ver/layout/tiling/horizontal'
    autoload :VerticalTiling, 'ver/layout/tiling/vertical'

    attr_reader :strategy, :stack, :options

    def initialize(parent, options = {})
      super

      pack(fill: :both, expand: true)

      # @stack contains the buffers in the order they are displayed
      @stack = []
      @options = {}
      self.strategy = VerticalTiling
    end

    def strategy=(mod)
      @strategy = mod
      apply if stack.any?
    end

    def create_buffer(options = {})
      buffer = Buffer.new(self, options)
      yield buffer
      stack.unshift(buffer)

      apply
      buffer.focus
    end

    def close_buffer(buffer)
      stack.delete(buffer)
      buffer.destroy

      if previous = stack.first
        apply
        previous.focus
      else
        VER.exit
      end
    end

    def focus_next(current)
      visible = head_tail_hidden.first(2).flatten
      return unless index = visible.index(current)

      found = visible[index + 1] || visible[0]
      found.focus
    end

    def focus_prev(current)
      visible = head_tail_hidden.first(2).flatten

      return unless index = visible.index(current)

      found = visible[index - 1]
      found.focus
    end

    # called on #3
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    # |     |  2  | > |     |  3  | > |     |  1  | > |     |  1  |
    # |  1  +-----+ > |  1  +-----+ > |  3  +-----+ > |  3  +-----+
    # |     |  3  | > |     |  2  | > |     |  2  | > |     |  2  |
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    def push_up(current)
      return unless index = stack.index(current)
      previous = stack[index - 1]
      current.raise(previous)
      stack[index - 1], stack[index] = current, previous

      apply
      previous.focus unless visible?(current)
    end

    # called on #3
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    # |     |  2  | > |     |  1  | > |     |  3  | > |     |  2  |
    # |  1  +-----+ > |  3  +-----+ > |  1  +-----+ > |  1  +-----+
    # |     |  3  | > |     |  2  | > |     |  2  | > |     |  3  |
    # +-----+-----+ > +-----+-----+ > +-----+-----+ > +-----+-----+
    def push_down(current)
      return unless index = stack.index(current)
      following = stack[index + 1] || stack[0]
      current.raise(following)
      stack[stack.index(following)], stack[index] = current, following

      apply
      following.focus unless visible?(current)
    end

    def push_top(current)
      stack.unshift(stack.delete(current))
      apply
    end

    def push_bottom(buffer)
      stack.push(stack.delete(buffer))
      apply
      stack.first.focus unless visible?(buffer)
    end

    def cycle_next(current)
      return unless index = stack.index(current)
      stack.push(stack.shift)
      apply
      stack[index].focus
    end

    def cycle_prev(current)
      return unless index = stack.index(current)
      stack.unshift(stack.pop)
      apply
      stack[index].focus
    end

    def apply(options = {})
      @options.merge!(options)
      strategy.apply(self, @options)
    end

    def head_tail_hidden(options = {})
      @options.merge!(options)
      strategy.prepare(self, @options).first(3)
    end

    def visible?(buffer)
      visible = head_tail_hidden.first(2).flatten
      visible.include?(buffer)
    end
  end
end
