require_relative '../../helper'

VER.spec keymap: 'diakonos', hidden: false do
  describe 'Diakonos keymap' do
    behaves_like :with_buffer

    should 'go to end of line with <End>' do
      type '<End>'
      insert.index.should == '1.0 lineend'
    end

    should 'go to end of buffer with <Alt-greater>' do
      type '<Alt-greater>'
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
      insert.index.should == '1.10'
    end

    should 'go to prev word with <Shift-Left>' do
      insert.index = '1.0 lineend'
      type '<Shift-Left>'
      insert.index.should == '1.40'
    end

    should 'go to start of buffer with <Alt-less>' do
      insert.index = '5.5'
      type '<Alt-less>'
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
      buffer.get('1.0', '1.0 lineend').should == 'Invent'
      buffer.get('2.0', '2.0 lineend').should == "ore voluptatibus dolorem assumenda."
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
