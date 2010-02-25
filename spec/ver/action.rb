require_relative '../helper'

module SpecReceiver
  class << self
    attr_reader :widget

    def set_widget(widget)
      @widget = widget
    end

    def reset
      @widget = nil
    end
  end
end

shared :with_buffer do
  before{ @buffer = VER::Buffer.new }
  after{ @buffer.destroy }

  def buffer
    @buffer
  end

  def widget
    ::SpecReceiver.widget
  end
end

shared :with_module_handler do
  behaves_like :with_buffer

  before{
    ::SpecReceiver.reset
    @action = VER::Action.new(:set_widget, ::SpecReceiver)
  }

  def action
    @action
  end
end

shared :with_no_handler do
  behaves_like :with_buffer

  before{
    buffer.value = 'some line'
    buffer.insert = '1.0'
    @action = VER::Action.new(:next_char)
  }

  def action
    @action
  end
end

shared :with_symbol_handler do
  behaves_like :with_buffer

  before{
    buffer.value = 'some line'
    buffer.insert = '1.0'
  }
end

VER.spec do
  describe 'VER::Action' do
    describe 'given Symbol handler' do
      behaves_like :with_symbol_handler

      it 'sends handler to widget, then sends method without default args on result' do
        action = VER::Action.new(:next_char, :at_insert)
        buffer.at_insert.index.should == '1.0'
        action.call(buffer)
        buffer.at_insert.index.should == '1.1'
      end

      it 'sends handler to widget, then sends method with default args on result' do
        action = VER::Action.new([:next_char, 2], :at_insert)
        buffer.at_insert.index.should == '1.0'
        action.call(buffer)
        buffer.at_insert.index.should == '1.2'
      end

      it 'sends handler to widget, then sends method with given args on result' do
        action = VER::Action.new(:next_char, :at_insert)
        buffer.at_insert.index.should == '1.0'
        action.call(buffer, 2)
        buffer.at_insert.index.should == '1.2'
      end

      it 'converts to Method' do
        action = VER::Action.new(:next_char, :at_insert)
        method = action.to_method(buffer)
        method.name.should == :next_char
        method.receiver.should == buffer.at_insert

        buffer.at_insert.index.should == '1.0'
        method.call
        buffer.at_insert.index.should == '1.1'
      end

      it 'converts to Proc' do
        action = VER::Action.new(:next_char, :at_insert)
        proc = action.to_proc
        proc.should.be.kind_of Proc
        proc.arity.should == -2

        buffer.at_insert.index.should == '1.0'
        proc.call(buffer)
        buffer.at_insert.index.should == '1.1'
      end
    end

    describe 'given Module handler' do
      behaves_like :with_module_handler

      it 'sends method on handler with widget as argument' do
        widget.should.be.nil
        action.call(buffer)
        widget.should == buffer
      end

      it 'converts to Method' do
        method = action.to_method(buffer)
        method.should.be.kind_of Method
        method.name.should == :set_widget
        method.receiver.should == ::SpecReceiver

        widget.should.be.nil
        method.call(buffer)
        widget.should == buffer
      end

      it 'converts to Proc' do
        proc = action.to_proc
        proc.should.be.kind_of Proc
        proc.arity.should == -2

        widget.should.be.nil
        proc.call(buffer)
        widget.should == buffer
      end
    end

    describe 'given no handler' do
      behaves_like :with_no_handler

      it 'sends method on widget with given args' do
        buffer.at_insert.index.should == '1.0'
        action.call(buffer)
        buffer.at_insert.index.should == '1.1'
      end

      it 'converts to method' do
        buffer.at_insert.index.should == '1.0'

        method = action.to_method(buffer)
        method.should.be.kind_of Method
        method.name.should == :next_char
        method.receiver.should == buffer

        method.call
        buffer.at_insert.index.should == '1.1'
      end

      it 'converts to proc' do
        buffer.at_insert.index.should == '1.0'

        proc = action.to_proc
        proc.should.be.kind_of Proc
        proc.arity.should == -2
        proc.call(buffer)

        buffer.at_insert.index.should == '1.1'
      end
    end
  end
end
