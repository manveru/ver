require_relative '../../../lib/ver/undo'
require 'ffi-tk'

class Text < Tk::Text
  class Index < Struct.new(:text, :position)
    include Comparable

    def <=>(other)
      if    text.compare(position, '>',  other.position)
        1
      elsif text.compare(position, '<',  other.position)
        -1
      elsif text.compare(position, '==', other.position)
        0
      end
    end

    def inspect
      position.inspect
    end
  end

  def index(index)
    Index.new(self, super(index))
  end
end

require 'bacon'
Bacon.summary_at_exit

describe 'VER::Undo::Record.sanitize' do
  @text = Text.new
  @text.value = <<-TEXT
this is the line one
this is the line two
this is the line three
this is the line four
this is the line six
  TEXT

  @tree = VER::Undo::Tree.new(@text)

  def sanitize(*given)
    record = VER::Undo::Record.new(@tree, @text)
    results = record.sanitize(*given)
    results.map{|result| result.map{|index| index.position }}
  end

  should 'sanitize two indices' do
    sanitize('1.0', '1.0').should == [%w[1.0 1.0]]
  end

  should 'fail on odd number' do
    i = '1.0'
    lambda{ sanitize(i, i, i) }.should.raise(ArgumentError)
    lambda{ sanitize(i, i, i, i, i) }.should.raise(ArgumentError)
  end

  should 'sanitize ordered non-overlapping' do
    sanitize(*%w[1.0 1.5 1.6 1.10]).should == [%w[1.6 1.10], %w[1.0 1.5]]
  end

  should 'sanitize unordered non-overlapping' do
    sanitize(*%w[1.6 1.10 1.0 1.5]).should == [%w[1.6 1.10], %w[1.0 1.5]]
  end

  should 'sanitize unordered overlapping' do
    sanitize(*%w[1.6 1.10 1.0 1.7]).should == [%w[1.0 1.10]]
  end

  should 'sanitize ordered overlapping' do
    sanitize(*%w[1.0 1.7 1.5 1.8]).should == [%w[1.0 1.8]]
  end

  should 'sanitize a lot' do
    indices = %w[
      1.0 2.0
      1.3 2.1
      2.2 3.4
      3.6 3.8
      3.7 4.0
    ]
    sanitize(*indices).should == [%w[3.6 4.0], %w[2.2 3.4], %w[1.0 2.1]]
  end
end
