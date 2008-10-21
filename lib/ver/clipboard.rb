module VER
  class ClipBoard
    def initialize(*contents)
      @contents = contents
    end

    def <<(text)
      @contents << text
    end

    def pop
      @contents.pop
    end

    def push(text)
      @contents.push(text)
    end

    def last
      @contents.last
    end

    def first
      @contents.first
    end
  end
end
