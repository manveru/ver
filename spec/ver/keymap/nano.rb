require_relative '../../helper'

VER.spec keymap: 'nano', hidden: false do
  describe 'Nano keymap' do
    behaves_like :with_buffer

    should 'go to end of line with <End>' do
      type '<End>'
      insert.index.should == '1.0 lineend'
    end

    should 'go line down with <Down>' do
      type '<Down>'
      insert.index.should == '2.0'
    end

    should 'go line up with <Up>' do
      insert.index = '2.0'
      type '<Up>'
      insert.index.should == '1.0'
    end

    should 'go to next character with <Right>' do
      type '<Right>'
      insert.index.should == '1.1'
    end

    should 'go to previous character with <Left>' do
      insert.index = '1.1'
      type '<Left>'
      insert.index.should == '1.0'
    end
  end

  describe 'Nano keymap destructive binds' do
    behaves_like :destructive_mode

    should 'use <BackSpace> to delete previous char' do
      insert.index = '1.2'
      type '<BackSpace>'
      insert.get('linestart', 'linestart wordend').should == 'Iventore'
    end

    should 'use <Delete> to delete next char' do
      insert.index = '1.2'
      type '<Delete>'
      insert.get('linestart', 'linestart wordend').should == 'Inentore'
    end

    should 'use <Alt-t> to delete to end of buffer' do
      insert.index = 'insert linestart wordend'
      type '<Alt-t>'
      buffer.value.should == "Inventore\n"
    end

    should 'use <Alt-braceleft> to unindent a line' do
      buffer.value = "  some line"
      type '<Alt-braceleft>'
      buffer.value.should == "some line\n"
    end

    should 'insert verbatim character with <Alt-v> prefix' do
      buffer.value = ''
      type '<Alt-v><Control-j>'
      buffer.value.should == "\n\n"
    end

    should 'insert corresponding ascii character for <Escape><Escape>\d\d\d' do
      buffer.value = ''
      buffer.minor_mode?(:ascii_digit).should.be.nil
      type '<Escape><Escape>'
      buffer.minor_mode?(:ascii_digit).should.not.be.nil
      type '0'
      buffer.minor_mode?(:ascii_digit).should.not.be.nil
      buffer.value.should == "\n"
      type '4'
      buffer.minor_mode?(:ascii_digit).should.not.be.nil
      buffer.value.should == "\n"
      type '2'
      buffer.minor_mode?(:ascii_digit).should.be.nil
      buffer.value.should == "*\n"
    end
  end
end
