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
    end
  end
end
