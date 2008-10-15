require 'remix/buffer'

module Remix
  class Cursor
    attr_reader :mark, :pos, :buffer
    attr_accessor :opdelta

    def initialize(pos, buffer)
      @pos, @buffer = pos, buffer
      @mark = buffer.size
    end

    def wrap_region
      return yield if @pos < @mark
      @pos, @mark = @mark, @pos
      result = yield
      @pos, @mark = @mark, @pos
      return result
    end

    def rindex(pattern)
      wrap_region{ @buffer.rindex(pattern, @pos..@mark) }
    end

    def index(pattern)
      wrap_region{ @buffer.index(pattern, @pos..@mark) }
    end
    alias find index

    def beginning_of_line
      @pos = rindex("\n")
    end
  end
end
