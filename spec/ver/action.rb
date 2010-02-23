require_relative '../helper'

module SpecReceiver
  class << self
    attr_reader :widget

    def set_widget(widget)
      @widget = widget
    end
  end
end


VER.spec do
  describe 'VER::Action' do
    describe 'given Symbol handler' do
      it 'sends handler to widget, then sends method without default args on result' do
        buffer = VER::Buffer.new(VER.layout)
        buffer.value = 'some line'
        action = VER::Action.new(:next_char, :at_insert)
        buffer.insert = '1.0'
        action.call(buffer)
        buffer.at_insert.index.should == '1.1'
        buffer.destroy
      end

      it 'sends handler to widget, then sends method with default args on result' do
        buffer = VER::Buffer.new(VER.layout)
        buffer.value = 'some line'
        action = VER::Action.new([:next_char, 2], :at_insert)
        buffer.insert = '1.0'
        action.call(buffer)
        buffer.at_insert.index.should == '1.2'
        buffer.destroy
      end

      it 'sends handler to widget, then sends method with given args on result' do
        buffer = VER::Buffer.new(VER.layout)
        buffer.value = 'some line'
        action = VER::Action.new(:next_char, :at_insert)
        buffer.insert = '1.0'
        action.call(buffer, 2)
        buffer.at_insert.index.should == '1.2'
        buffer.destroy
      end
    end

    describe 'given Module handler' do
      it 'sends method on handler with widget as argument' do
        buffer = VER::Buffer.new(VER.layout)
        action = VER::Action.new(:set_widget, ::SpecReceiver)
        action.call(buffer)
        ::SpecReceiver.widget.should == buffer
      end
    end

    describe 'given no handler' do
      it 'sends method on widget with given args' do
        buffer = VER::Buffer.new(VER.layout)
        buffer.value = 'some line'
        action = VER::Action.new(:next_char)
        buffer.insert = '1.0'
        action.call(buffer)
        buffer.at_insert.index.should == '1.1'
      end
    end
  end
end
