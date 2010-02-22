require_relative '../../helper'

before = lambda{ @buffer = VER::Buffer.new(VER.layout) }
after = lambda{ @buffer.destroy }

VER.spec do
  describe 'VER::Buffer::Tag' do
    describe 'Instance methods' do
      before(&before)
      after(&after)

      it 'adds indices' do
        tag = @buffer.tag(:spec)
        tag.ranges.should == []
        tag.add '1.0'
        tag.ranges.should == [ @buffer.range('1.0', '2.0') ]
      end

      it 'gets options' do
        @buffer.tag(:sel).cget(:foreground).should == '#000000'
      end

      it 'configures' do
        tag = @buffer.tag(:sel)
        tag.configure foreground: '#fff'
        tag.cget(:foreground).should == '#fff'
      end

      it 'has ranges' do
        @buffer.insert('end', 'some text', :spec)
        tag = @buffer.tag(:spec)
        tag.ranges.should == [@buffer.range('1.0', '1.9')]
      end

      it 'deletes' do
        tag = @buffer.tag(:spec, '1.0')
        tag.ranges.should == [@buffer.range('1.0', '2.0')]
        tag.delete
        tag.ranges.should == []
      end

      it 'removes' do
        @buffer.insert('end', 'some text', :spec)
        tag = @buffer.tag(:spec)
        tag.ranges.should == [@buffer.range('1.0', '1.9')]
        tag.remove('1.4')
        tag.ranges.should == [
          @buffer.range('1.0', '1.4'),
          @buffer.range('1.5', '1.9'),
        ]
      end
    end

    describe 'Buffer methods' do
      before(&before)
      after(&after)

      it 'has a list of tags' do
        tags = @buffer.tags
        tags.each{|tag| tag.class.should == VER::Buffer::Tag }
        tags.should.not.be.empty
      end

      it 'has ranges of tags' do
        @buffer.tag_ranges(:sel).should == []
      end

      it 'returns a tag' do
        @buffer.tag(:sel).should == VER::Buffer::Tag.new(@buffer, :sel)
      end

      it 'adds a tag for given indices' do
        @buffer.tag(:spec, '1.0')
        @buffer.tag_ranges(:spec).should == [@buffer.range('1.0', '2.0')]
      end
    end
  end
end
