require_relative '../helper'
require 'ffi-tk'

class Text < Tk::Text
  def initialize(*args)
    super
    @undoer = VER::Undo::Tree.new(self)
  end

  def undo
    @undoer.undo
  end

  def redo
    @undoer.redo
  end

  def undo_record(&block)
    @undoer.record_multi(&block)
  end

  def touch!(*indices)
  end
end

VER.spec do
  describe 'VER::Undo' do
    buffer = Text.new

    describe 'simple' do
      should 'undo single insert' do
        buffer.undo_record do |record|
          record.insert :insert, 'foo'
        end
        buffer.value.should == "foo\n"
        buffer.undo
        buffer.value.should == "\n"
      end

      should 'undo multiple insertions' do
        buffer.undo_record do |record|
          record.insert :insert, 'foo'
          record.insert :insert, ' bar'
        end
        buffer.value.should == "foo bar\n"
        buffer.undo
        buffer.value.should == "\n"
      end

      should 'undo single replace' do
        buffer.value = 'foo bar'
        buffer.undo_record do |record|
          record.replace '1.0', '1.3', 'bar'
        end
        buffer.value.should == "bar bar\n"
        buffer.undo
        buffer.value.should == "foo bar\n"
      end

      should 'undo multiple replacements' do
        buffer.value = 'foo bar'
        buffer.undo_record do |record|
          record.replace '1.0', '1.3', 'bar'
          record.replace '1.4', '1.7', 'foo'
        end
        buffer.value.should == "bar foo\n"
        buffer.undo
        buffer.value.should == "foo bar\n"
      end

      should 'undo single delete' do
        buffer.value = 'foo bar'
        buffer.undo_record do |record|
          record.delete '1.0', '1.3'
        end
        buffer.value.should == " bar\n"
        buffer.undo
        buffer.value.should == "foo bar\n"
      end

      should 'undo multiple deletions' do
        buffer.value = 'foo bar'
        buffer.undo_record do |record|
          record.delete '1.0', '1.3'
          record.delete '1.1', '1.4'
        end
        buffer.value.should == " \n"
        buffer.undo
        buffer.value.should == "foo bar\n"
      end
    end

    describe 'complex' do
      should 'undo multiple deletions' do
        buffer.value = 'foo bar'
        buffer.undo_record do |record|
          record.delete '1.0', '1.3', '1.4', '1.7'
        end
        buffer.value.should == " \n"
        buffer.undo
        buffer.value.should == "foo bar\n"
      end
    end
  end
end

__END__

    should 'undo multiple inserts' do
      insert << 'foo' << 'foo' << 'foo'
      buffer.value.should == "foofoofoo\n"
      buffer.undo
      buffer.value.should == "\n"
    end

    should 'undo single delete' do
      buffer.value = 'abc'
      buffer.delete('1.1', '1.2')
      buffer.value.should == "ac\n"
      buffer.undo
      buffer.value.should == "abc\n"
    end

    should 'undo consecutive deletes' do
      buffer.value = 'abc'
      buffer.delete('1.1', '1.2')
      buffer.delete('1.1', '1.2')
      buffer.value.should == "a\n"
      buffer.undo
      buffer.value.should == "abc\n"
    end
  end
end
