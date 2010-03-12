require_relative '../../helper'

before = lambda{ @buffer = VER::Buffer.new(VER.layout) }
after = lambda{ @buffer.destroy }

VER.spec do
  describe 'VER::Buffer::Index' do
    describe 'Buffer methods' do
      before(&before)
      after(&after)

      it 'returns an Index from #index' do
        @buffer.index('1.0').should == VER::Buffer::Index.new(@buffer, '1.0')
      end
    end

    describe 'Instance methods' do
      before(&before)
      after(&after)

      it 'has a bbox' do
        bbox = @buffer.index('1.0').bbox
        bbox.class.should == Array
        bbox.size.should == 4
        bbox.all?{|entry| entry.is_a?(Integer) }.should.be.true
      end

      it 'is comparable' do
        @buffer.insert('1.0', 'some text')
        @buffer.index('1.0').should < @buffer.index('1.1')
        @buffer.index('1.1').should > @buffer.index('1.0')
        @buffer.index('1.1').should == @buffer.index('1.1')
        @buffer.index('1.1').should >= @buffer.index('1.1')
        @buffer.index('1.1').should >= @buffer.index('1.0')
        @buffer.index('1.1').should <= @buffer.index('1.1')
        @buffer.index('1.0').should <= @buffer.index('1.1')
        @buffer.index('1.0').should != @buffer.index('1.1')
        @buffer.index('1.1').should.be.between @buffer.index('1.0'), @buffer.index('1.2')
        @buffer.index('1.2').should.be.between @buffer.index('1.1'), @buffer.index('1.2')
      end

      it 'has dlineinfo' do
        dlineinfo = @buffer.index('1.0').dlineinfo
        dlineinfo.class.should == Array
        dlineinfo.size.should == 5
        dlineinfo.all?{|entry| entry.is_a?(Integer) }.should.be.true
      end

      it 'dumps all at index' do
        @buffer.index('1.0').dump(:all).should == [
          ["mark", "insert", "1.0"],
          ["mark", "current", "1.0"],
          ["text", "\n", "1.0"],
        ]
      end

      it 'gets content at index' do
        @buffer.index('1.0').get.should == "\n"
      end

      it 'deletes at index' do
        @buffer.insert('end', 'abc')
        @buffer.index('1.0').get.should == "a"
        @buffer.index('1.0').delete
        @buffer.value.should == "bc\n"
        @buffer.index('1.0').get.should == "b"
      end

      it 'has a line' do
        @buffer.index('1.0').line.should == 1
        @buffer.index('2.0').line.should == 2
        @buffer.index('3.0').line.should == 2
      end

      it 'has a char' do
        @buffer.index('1.0').char.should == 0
        @buffer.index('1.1').char.should == 0
      end

      it 'gets a list of tags at the position' do
        @buffer.insert 'end', 'some', 'some-tag'
        @buffer.insert 'end', ' '
        @buffer.insert 'end', 'tags', 'tags-tag'
        @buffer.index('1.0').tags.should == [@buffer.tag('some-tag')]
        @buffer.index('1.4').tags.should == []
        @buffer.index('1.5').tags.should == [@buffer.tag('tags-tag')]
      end

      it 'gets a list of tag names at the position' do
        @buffer.insert 'end', 'some', 'some-tag'
        @buffer.insert 'end', ' '
        @buffer.insert 'end', 'tags', 'tags-tag'
        @buffer.index('1.0').tag_names.should == ['some-tag']
        @buffer.index('1.4').tag_names.should == []
        @buffer.index('1.5').tag_names.should == ['tags-tag']
      end

      it 'copies line at position' do
        @buffer.insert '1.0', 'one line'
        VER::Clipboard.clear
        @buffer.index('1.0').copy_line
        VER::Clipboard.dwim.should == "one line\n"
      end

      it 'deletes line at position' do
        @buffer.insert '1.0', 'one line'
        VER::Clipboard.clear
        @buffer.index('1.0').delete_line
        VER::Clipboard.dwim.should.be.nil
        @buffer.value.should == "\n"
      end

      it 'kills line at position' do
        @buffer.insert '1.0', 'one line'
        VER::Clipboard.clear
        @buffer.index('1.0').kill_line
        VER::Clipboard.dwim.should == "one line\n"
        @buffer.value.should == "\n"
      end
    end
  end
end
