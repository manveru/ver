require_relative '../../helper'

shared :with_buffer do
  before do
    @buffer ||= VER::Buffer.new
    @buffer.value = <<-TEXT
Fugiat eos voluptatum officia fugit ad sit qui.
Alias et voluptas sapiente sed.
Unde ut qui esse repellendus sunt dolorum officia.
Officia accusamus perferendis ab.
Nesciunt repellendus et recusandae dolorum quis repudiandae ad minima.
Ducimus quo et ea.
Qui cumque blanditiis aliquam accusamus perspiciatis provident sapiente fuga.
    TEXT
    @buffer.insert = '1.0'
    @buffer.major_mode = VER::MajorMode[:Fundamental]
    @insert = @buffer.at_insert
  end

  after do
    @buffer.value = ''
  end

  def buffer
    @buffer
  end

  def insert
    @insert
  end

  def type(string)
    buffer.type(string)
  end

  def minibuf
    buffer.minibuf
  end
end

shared :control_mode do
  behaves_like :with_buffer

  before do
    buffer.minor_mode?(:insert).should == nil
    Tk::Clipboard.set 'foo'
  end
end

VER.spec keymap: 'vim' do
  describe 'Keymap for VIM' do
    describe 'Control mode movement' do
      behaves_like :with_buffer

      it 'goes to first column with <0>' do
        buffer.insert = '1.5'
        type '0'
        insert.should == '1.0'
      end

      it 'goes to end of buffer with <G>' do
        type 'G'
        insert.should == 'end - 1 chars'
      end

      it 'goes to last column with <dollar> ($)' do
        type '<dollar>'
        insert.should == '1.0 lineend'
      end

      it 'goes to last column with <End>' do
        type '<End>'
        insert.should == '1.0 lineend'
      end

      it 'goes to start of buffer with <g><g>' do
        buffer.insert = 'end'
        type 'gg'
        insert.should == '1.0'
      end

      it 'goes to arbitrary line with \d+<g><g>' do
        type '5gg'
        insert.line.should == 5
      end

      it 'goes to matching brace with <percent> (%)' do
        buffer.value = '(Veniam (vitae (ratione (facere))))'
        buffer.insert = '1.0'
        type '<percent>'
        insert.index.should == '1.34'
      end

      it 'goes to next char with <l> and <Right>' do
        type 'l'
        insert.should == '1.1'
        type '<Right>'
        insert.should == '1.2'
      end

      it 'goes to prev char with <h> and <Left>' do
        buffer.insert = '1.5'
        type 'h'
        insert.should == '1.4'
        type '<Left>'
        insert.should == '1.3'
      end

      it 'goes to next chunk with <W>' do
        type 'W'
        insert.index.should == '1.7'
      end

      it 'goes to next line with <j>, <Down>, and <Control-n>' do
        type 'j'
        buffer.count('1.0', 'insert', :displaylines).should == 1
        type '<Down>'
        buffer.count('1.0', 'insert', :displaylines).should == 2
        type '<Control-n>'
        buffer.count('1.0', 'insert', :displaylines).should == 3
      end

      it 'goes to next page with <Control-f> and <Next>' do
        type '<Control-f>'
        buffer.count('1.0', 'insert', :displaylines).should == 1
        type '<Next>'
        buffer.count('1.0', 'insert', :displaylines).should == 2
      end

      it 'goes to next word with <w> and <Shift-Right>' do
        type 'w'
        insert.index.should == '1.7'
        type '<Shift-Right>'
        insert.index.should == '1.11'
      end

      it 'goes to next chunk end with <E>' do
        type 'E'
        insert.index.should == '1.5'
      end

      it 'goes to next word end with <e>' do
        type 'e'
        insert.index.should == '1.5'
      end

      it 'goes to prev chunk with <B>' do
        insert.index = 'end'
        type 'B'
        insert.index.should == '7.72'
      end

      it 'goes to prev line with <k>, <Up>, and <Control-p>' do
        insert.index = 'end'
        type 'k'
        buffer.count('insert', 'end', :displaylines).should == 2
        type '<Up>'
        buffer.count('insert', 'end', :displaylines).should == 3
        type '<Control-p>'
        buffer.count('insert', 'end', :displaylines).should == 4
      end

      it 'goes to prev page with <Control-b> and <Prior>' do
        insert.index = 'end'
        type '<Control-b>'
        insert.index.should == '8.0'
        type '<Prior>'
        insert.index.should == '8.0'
      end

      it 'goes to prev word with <b> and <Shift-Left>' do
        insert.index = '1.10'
        type 'b'
        insert.index.should == '1.7'
        type '<Shift-Left>'
        insert.index.should == '1.0'
      end

      it 'goes to start of line with <Home>' do
        insert.index = '1.10'
        type '<Home>'
        insert.index.should == '1.0'
      end

      it 'changes at end of line with <A>' do
        buffer.minor_mode?(:insert).should == nil
        insert.index = '1.0'
        type 'A'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 47
        insert.index.should == '1.0 lineend'
        buffer.minor_mode?(:insert).should != nil
      end

      it 'changes at next char with <a>' do
        buffer.minor_mode?(:insert).should == nil
        insert.index = '1.0'
        type 'a'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 47
        insert.index.should == '1.1'
        buffer.minor_mode?(:insert).should != nil
      end
    end

    describe 'Control mode deletion' do
      behaves_like :control_mode

      it 'changes movement with <c> prefix' do
        type 'cl'
        Tk::Clipboard.get.should == "F"
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 46
        buffer.minor_mode?(:insert).should != nil
        insert.index.should == '1.0'
      end

      it 'changes to right end of next word with <c><w>' do
        type 'cw'
        Tk::Clipboard.get.should == "Fugiat"
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 41
        buffer.minor_mode?(:insert).should != nil
        insert.index.should == '1.0'
      end

      it 'changes a line with <c><c>' do
        type 'cc'
        Tk::Clipboard.get.should == "Fugiat eos voluptatum officia fugit ad sit qui.\n"
        buffer.count('1.0', 'end', :lines).should == 7
        buffer.minor_mode?(:insert).should != nil
        insert.index.should == '1.0'
      end

      it 'kills movement with <d> prefix' do
        insert.index = '1.1'
        type 'dl'
        Tk::Clipboard.get.should == 'u'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 46
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.1'
      end

      it 'kills a line with <d><d>' do
        type 'dd'
        Tk::Clipboard.get.should == "Fugiat eos voluptatum officia fugit ad sit qui.\n"
        buffer.count('1.0', 'end', :lines).should == 7
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.0'
      end

      it 'changes to end of line with <C>' do
        insert.index = '1.1'
        type 'C'
        Tk::Clipboard.get.should == 'ugiat eos voluptatum officia fugit ad sit qui.'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 1
        buffer.minor_mode?(:insert).should != nil
        insert.index.should == '1.1'
      end

      it 'kills to end of line with <D>' do
        insert.index = '1.1'
        type 'D'
        Tk::Clipboard.get.should == 'ugiat eos voluptatum officia fugit ad sit qui.'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 1
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.1'
      end

      it 'kills next char with <x>' do
        insert.index = '1.1'
        type 'x'
        Tk::Clipboard.get.should == 'u'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 46
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.1'
      end

      it 'kills previous char with <X>' do
        insert.index = '1.1'
        type 'X'
        Tk::Clipboard.get.should == 'F'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 46
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.0'
      end
    end
  end
end
