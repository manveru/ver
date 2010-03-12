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

VER.spec keymap: 'diakonos', hidden: false do
  describe 'Diakonos keymap' do
    behaves_like :control_mode

    should 'go to end of line with <End>' do
      type '<End>'
      insert.index.should == '1.0 lineend'
    end

    should 'go to end of buffer with <M1-greater>' do
      type '<M1-greater>'
      insert.index.should == 'end - 1 chars'
    end

    should 'go to next char with <Right>' do
      type '<Right>'
      insert.index.should == '1.1'
    end

    should 'go to prev char with <Left>' do
      insert.index = '1.2'
      type '<Left>'
      insert.index.should == '1.1'
    end

    should 'go to next line with <Down>' do
      type '<Down>'
      insert.index.should == '2.0'
    end

    should 'go to prev line with <Up>' do
      insert.index = '2.0'
      type '<Up>'
      insert.index.should == '1.0'
    end

    should 'go to next word with <Shift-Right>' do
      type '<Shift-Right>'
      insert.index.should == '1.7'
    end

    should 'go to prev word with <Shift-Left>' do
      insert.index = '1.0 lineend'
      type '<Shift-Left>'
      insert.index.should == '1.46'
    end

    should 'go to start of buffer with <M1-less>' do
      insert.index = '5.5'
      type '<M1-less>'
      insert.index.should == '1.0'
    end

    should 'go to start of line with <Home>' do
      insert.index = '1.10'
      type '<Home>'
      insert.index.should == '1.0'
    end

    should 'insert newline with <Return>' do
      insert.index = '1.6'
      type '<Return>'
      insert.index.should == '2.0'
      buffer.get('1.0', '1.0 lineend').should == 'Fugiat'
      buffer.get('2.0', '2.0 lineend').should == "eos voluptatum officia fugit ad sit qui."
    end

    should 'insert characters for anything not mapped' do
      buffer.value = ''
      typed = []
      (0..255).map{|c| c.chr }.grep(/[[:print:]]/).each do |char|
        event = VER::Event[char]
        typed << char
        type event.pattern
      end

      insert.index.should == '1.95'
      buffer.value.chomp.should == typed.join
    end

=begin
    map :next_page,       %w[Next]
    map :prev_page,       %w[Prior]
=end
  end
end
