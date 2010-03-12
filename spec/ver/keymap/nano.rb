require_relative '../../helper'

shared :with_buffer do
  before do
    @buffer ||= VER.layout.create_buffer
    VER.layout.add_buffer(@buffer)
    @buffer.value = <<-TEXT.chomp
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
    Tk.update
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

  def clipboard
    VER::Clipboard.dwim
  end

  def clipboard_set(string)
    VER::Clipboard.dwim = string
  end
end

shared :control_mode do
  behaves_like :with_buffer

  before do
    clipboard_set 'foo'
  end
end

VER.spec keymap: 'nano', hidden: false do
  describe 'Nano keymap' do
    behaves_like :control_mode

    should 'go to end of line with <End>' do
      type '<End>'
      insert.index.should == '1.0 lineend'
    end
  end
end
