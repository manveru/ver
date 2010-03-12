require_relative '../../helper'

before = lambda{ @buffer = VER::Buffer.new(VER.layout) }
after = lambda{ @buffer.destroy }

VER.spec do
  describe 'VER::Text::Mark' do
    describe 'Instance methods' do
      before(&before)
      after(&after)

      it 'has gravity' do
        mark = @buffer.at_insert
        mark.gravity.should == :right
      end

      it 'changes gravity' do
        mark = @buffer.at_insert
        mark.gravity = :left
        mark.gravity.should == :left
        mark.gravity = :right
        mark.gravity.should == :right
      end

      it 'can insert text' do
        @buffer.at_insert.insert 'This is some text'
        @buffer.value.should == "This is some text\n"
      end

      it 'sets a mark' do
        @buffer.at_insert.insert 'This is some text'
        mark = @buffer.mark(:spec)
        mark.index = '1.5'
        mark.index.should == '1.5'
      end

      it 'unsets the mark' do
        mark = @buffer.mark(:spec)
        mark.unset
        lambda{ mark.index }.
          should.raise(RuntimeError).message.
          should =~ /^bad text index "spec"/
      end

      it 'deletes text' do
        @buffer.at_insert.insert('ayeah')
        mark = @buffer.mark(:spec, '1.0')
        mark.delete(1)
        @buffer.get('1.0', 'end').should == "yeah\n"
        mark.delete(:end)
      end

      it 'returns the next mark after mark instance' do
        @buffer.at_insert.insert('yeah')
        insert = @buffer.mark(:insert, '1.0')
        spec = @buffer.mark(:spec, '1.1')
        insert.next.should == spec
      end

      it 'returns the previous mark before mark instance' do
        insert = @buffer.mark(:insert, 'end')
        spec = @buffer.mark(:spec, '1.5')
        insert.previous.should == spec
      end

      it 'copies motion starting at mark' do
        @buffer.at_insert.insert("simple line")
        insert = @buffer.mark(:insert, '1.0')
        motion = VER::Action.new(:next_word)

        VER::Clipboard.clear
        @buffer.mark(:insert).copying(motion)
        VER::Clipboard.dwim.should == "simple "
      end
    end

    describe 'Text methods' do
      before(&before)
      after(&after)

      it 'returns mark from #mark' do
        @buffer.mark(:insert).should == VER::Text::Mark.new(@buffer, :insert)
      end

      it 'sets mark with second argument to #mark' do
        @buffer.mark(:spec, '1.0').index.should == '1.0'
      end

      it 'returns marks from #marks' do
        @buffer.marks.should == [@buffer.at_insert, @buffer.at_current]
      end
    end
  end
end
