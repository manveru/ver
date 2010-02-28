require_relative '../../helper'

before = lambda{
  @buffer = VER::Buffer.new(VER.layout)
  @buffer.value = <<-VALUE.chomp
line one
line two
  VALUE
  @range = @buffer.range('1.5', '2.4')
}
after = lambda{ @buffer.destroy }

VER.spec do
  describe 'VER::Text::Range' do
    before(&before)
    after(&after)

    it 'gets contents' do
      @range.get.should == "one\nline"
    end

    it 'counts contents' do
      @range.count(:chars).should == 8
    end

    it 'deletes contents' do
      @range.delete
      VER::Clipboard.set 'foo'
      @buffer.value.should == "line  two\n"
      VER::Clipboard.get.should == 'foo'
    end

    it 'kills contents' do
      VER::Clipboard.set 'foo'
      @range.kill
      @buffer.value.should == "line  two\n"
      VER::Clipboard.get.should == "one\nline"
    end

    it 'replaces contents' do
      @range.replace('one and')
      @buffer.value.should == "line one and two\n"
    end

    it 'replaces contents with a tag' do
      @range.replace("one\nline", 'some')
      @range.dump(:all).should == [
        ["tagon", "some", "1.5"],
        ["text", "one\n", "1.5"],
        ["text", "line", "2.0"]
      ]
    end

    it 'copies contents' do
      VER::Clipboard.set 'foo'
      @range.copy
      VER::Clipboard.get.should == "one\nline"
    end

    it 'dumps contents' do
      @range.dump(:all).should == [
        ["text", "one\n", "1.5"],
        ["text", "line", "2.0"]
      ]
    end

    it 'inspects itself' do
      @range.inspect.should.start_with '#<VER::Text::Range (1.5..2.4) on '
    end
  end
end
