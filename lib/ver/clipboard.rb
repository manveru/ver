module VER
  class ClipBoard
    def initialize(*contents)
      @contents = contents
      @limit = 100
    end

    def <<(text)
      (@contents.size - @limit).times{ @contents.shift }
      @contents << text
    end

    alias push <<

    def pop
      @contents.pop
    end

    def last
      @contents.last
    end

    def first
      @contents.first
    end
  end
end
