require_relative '../../helper'

VER.spec do
  describe 'VER::Buffer::Selection' do
    buffer = VER::Buffer.new(VER.layout)
    sel = buffer.at_sel

    it 'can be retrieved from Buffer instance' do
      sel.should.not.be.nil
    end

    it 'can lowercase the selected text' do
      buffer.value = 'ABCDEFGH'
      %w[1.0 1.2 1.4 1.6].each{|index| sel.add(index) }
      sel.lower_case
      buffer.value.should == "aBcDeFgH\n"
    end

    it 'can uppercase the selected text' do
      buffer.value = 'abcdefgh'
      %w[1.0 1.2 1.4 1.6].each{|index| sel.add(index) }
      sel.upper_case
      buffer.value.should == "AbCdEfGh\n"
    end

    it 'can toggle case of selected text' do
      buffer.value = 'AbCdEfGh'
      sel.add('1.0', 'end')
      sel.toggle_case
      buffer.value.should == "aBcDeFgH\n"
    end

    it 'deletes contents of selection' do
      buffer.value = 'abcdefgh'
      %w[1.0 1.2 1.4 1.6].each{|index| sel.add(index) }
      sel.delete
      buffer.value.should == "bdfh\n"
    end

    it 'copies single selection' do
      buffer.value = 'line one'
      sel.add('1.0', '1.9')
      sel.copy
      Tk::Clipboard.get.should == 'line one'
    end

    it 'copies multiple lines selection' do
      buffer.value = "line one\nline two\nline three\n"
      sel.add('1.0', '4.0')
      sel.copy
      Tk::Clipboard.get.should == "line one\nline two\nline three\n"
    end

    it 'selects by character' do
      buffer.tag_delete :sel
      buffer.type 'ggvG'
      ranges = sel.ranges
      ranges.size.should == 1
      range = ranges.first
      range.first.should == '1.0'
      range.last.should == '5.0'
    end

    it 'selects by line' do
      buffer.tag_delete :sel
      buffer.type 'ggV'
      ranges = sel.ranges
      ranges.size.should == 1
      range = ranges.first
      range.first.should == '1.0'
      range.last.should == '1.8'

      # extend by a line
      buffer.type '2gg'
      ranges = sel.ranges
      ranges.size.should == 1
      range = ranges.first
      range.first.should == '1.0'
      range.last.should == '2.8'
    end

    it 'selects by block' do
      buffer.tag_delete :sel
      buffer.type 'gg<Control-v>'
      ranges = sel.ranges
      ranges.size.should == 1
      range = ranges.first
      range.first.should == '1.0'
      range.last.should == '1.1'

      # extend by a line
      buffer.type '2gg'
      ranges = sel.ranges
      ranges.size.should == 2
      ranges[0].first.should == '1.0'
      ranges[0].last. should == '1.1'
      ranges[1].first.should == '2.0'
      ranges[1].last. should == '2.1'
    end
  end
end
