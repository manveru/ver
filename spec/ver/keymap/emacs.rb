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

VER.spec keymap: 'emacs' do
  describe 'Keymap for Emacs' do
    describe 'movement' do
      behaves_like :with_buffer

      it 'goes to first column with <Home> and <Control-a>' do
        insert.index = '1.0 lineend'
        type '<Home>'
        insert.index.should == '1.0 linestart'
        insert.index = '1.0 lineend'
        type '<Control-a>'
        insert.index.should == '1.0 linestart'
      end
    end
  end
end
