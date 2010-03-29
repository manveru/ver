require_relative '../../helper'

shared :with_selection do
  before do
    @buffer ||= VER::Buffer.new
    Tk::Clipboard.clear
  end

  def buffer
    @buffer
  end

  def sel
    @buffer.at_sel
  end

  def start(mode, index)
    buffer.insert = index
    sel.reset
    sel.enter_mode(mode.to_s)
  end
end

VER.spec do
  describe 'VER::Text::Selection' do
    behaves_like :with_selection

    it 'can be retrieved from Buffer instance' do
      sel.should.not.be.nil
    end

    describe 'inherited from Tag' do
      behaves_like :with_selection

      it 'lowercases content' do
        buffer.value = 'ABCDEFGH'
        %w[1.0 1.2 1.4 1.6].each{|index| sel.add(index) }
        sel.lower_case!
        buffer.value.should == "aBcDeFgH\n"
      end

      it 'uppercases content' do
        buffer.value = 'abcdefgh'
        %w[1.0 1.2 1.4 1.6].each{|index| sel.add(index) }
        sel.upper_case!
        buffer.value.should == "AbCdEfGh\n"
      end

      it 'toggles case of content' do
        buffer.value = 'AbCdEfGh'
        sel.add('1.0', '1.0 lineend')
        sel.toggle_case!
        buffer.value.should == "aBcDeFgH\n"
      end

      it 'deletes contents of selection' do
        buffer.value = 'abcdefgh'
        %w[1.0 1.2 1.4 1.6].each{|index| sel.add(index) }
        sel.delete
        buffer.value.should == "bdfh\n"
      end

      it 'copies content over single range' do
        buffer.value = 'line one'
        sel.add('1.0', '1.9')
        sel.copy
        VER::Clipboard.dwim.should == 'line one'
      end

      it 'copies content over multiple lines' do
        buffer.value = "line one\nline two\nline three\n"
        sel.add('1.0', '4.0')
        sel.copy
        VER::Clipboard.dwim.should == "line one\nline two\nline three\n"
      end

      it 'evaluates content' do
        buffer.value = '1 + 1'
        sel.add('1.0', 'end')
        sel.evaluate!
        buffer.value.should == "1 + 1\n2\n"
        sel.ranges.should.be.empty
      end

      it 'replaces content with pipe result' do
        buffer.value = "one\ntwo\nthree"
        sel.add('1.0', 'end')
        sel.pipe!('rev')
        buffer.value.should == "eno\nowt\neerht\n"
        sel.ranges.should.be.empty
      end

      it 'wraps content' do
        buffer.value = <<-TEXT.chomp
Totam dolor debitis sit cupiditate placeat architecto quis. Sunt occaecati corrupti a porro dolor perspiciatis. Perferendis minima ipsam corrupti aut delectus. Deleniti assumenda ea velit. Rerum expedita veniam molestiae soluta.
        TEXT
        sel.add '1.0', 'end'
        sel.wrap
        buffer.value.should == <<-TEXT
Totam dolor debitis sit cupiditate placeat architecto quis.
Sunt occaecati corrupti a porro dolor perspiciatis.
Perferendis minima ipsam corrupti aut delectus.
Deleniti assumenda ea velit.
Rerum expedita veniam molestiae soluta.
        TEXT
      end
    end

    describe 'character-wise' do
      behaves_like :with_selection

      before do
        buffer.value = <<-TEXT.chomp
line one
line two
line three
        TEXT
      end

      it 'finishes selection after copy' do
        start('select_char', '1.0')
        buffer.insert = 'end'
        sel.copy
        VER::Clipboard.dwim.should == "line one\nline two\nline three\n"
        sel.ranges.should.be.empty
      end

      it 'indents content at start of line' do
        start('select_char', '1.0')
        buffer.insert = '1.5'
        sel.indent
        sel.ranges.should == [buffer.range('1.2', '1.8')]
        buffer.value.should == <<-TEXT
  line one
line two
line three
        TEXT
      end

      it 'indents content within a line' do
        start('select_char', '1.2')
        buffer.insert = '1.5'
        sel.indent
        sel.ranges.should == [buffer.range('1.4', '1.8')]
        buffer.value.should == <<-TEXT
li  ne one
line two
line three
        TEXT
      end

      it 'comments content' do
        start('select_char', '1.0')
        buffer.insert = 'end'
        sel.comment
        buffer.value.should == <<-TEXT
# line one
# line two
# line three
        TEXT
      end

      it 'uncomments content' do
        buffer.value = <<-TEXT.chomp
# line one
# line two
# line three
        TEXT
        start('select_char', '1.0')
        buffer.insert = 'end'
        sel.uncomment
        buffer.value.should == <<-TEXT
line one
line two
line three
        TEXT
      end
    end

    describe 'line-wise' do
      behaves_like :with_selection

      before do
        buffer.value = <<-TEXT.chomp
line one
line two
line three
        TEXT
      end

      it 'finishes selection after copy' do
        start('select_line', '1.0')
        buffer.insert = 'end'
        sel.copy
        VER::Clipboard.dwim.should == "line one\nline two\nline three\n"
        sel.ranges.should.be.empty
      end

      it 'indents content' do
        start('select_line', '1.2')
        buffer.insert = '1.5'
        sel.indent
        sel.ranges.should == [buffer.range('1.0', '1.10')]
        buffer.value.should == <<-TEXT
  line one
line two
line three
        TEXT
      end

      it 'comments content' do
        start('select_line', '1.0')
        buffer.insert = 'end'
        sel.comment
        buffer.value.should == <<-TEXT
# line one
# line two
# line three
        TEXT
      end

      it 'uncomments content' do
        buffer.value = <<-TEXT.chomp
# line one
# line two
# line three
        TEXT
        start('select_line', '1.0')
        buffer.insert = 'end'
        sel.uncomment
        buffer.value.should == <<-TEXT
line one
line two
line three
        TEXT
      end
    end

    describe 'block-wise' do
      behaves_like :with_selection

      before do
        buffer.value = <<-TEXT.chomp
line one
line two
line three
        TEXT
      end

      it 'indents content' do
        start('select_block', '1.2')
        buffer.insert = '1.5'
        sel.indent
        sel.ranges.should == [buffer.range('1.4', '1.8')]
        buffer.value.should == <<-TEXT
li  ne one
line two
line three
        TEXT
      end

      it 'comments content' do
        start('select_block', '1.0')
        buffer.insert = 'end'
        sel.comment
        buffer.value.should == <<-TEXT
# line one
# line two
# line three
        TEXT
      end

      it 'uncomments content' do
        buffer.value = <<-TEXT.chomp
# line one
# line two
# line three
        TEXT
        start('select_block', '1.0')
        buffer.insert = 'end'
        sel.uncomment
        buffer.value.should == <<-TEXT
line one
line two
line three
        TEXT
      end

      it 'finishes selection after copy' do
        start('select_block', '1.0')
        buffer.insert = '3.10'
        sel.copy
        VER::Clipboard.dwim.should == ["line one", "line two", "line three"]
        sel.ranges.should.be.empty
      end

      it 'replaces contents with another string' do
        start('select_block', '1.4')
        buffer.insert = '3.4'
        sel.replace_with_string('><', false)
        buffer.value.should == <<-TEXT
line><one
line><two
line><three
        TEXT
        VER::Clipboard.dwim.should == nil
        sel.ranges.should == [
          buffer.range('1.4', '1.6'),
          buffer.range('2.4', '2.6'),
          buffer.range('3.4', '3.6'),
        ]
      end
    end
  end
end
