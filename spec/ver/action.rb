require 'bacon'
Bacon.summary_on_exit

class Dummy < BasicObject
  def initialize(name)
    @name = name
    @store = []
  end

  def method_missing(method, *args)
    @store << [method, *args]
    self
  end

  def ==(other)
    self.__name__ == other.__name__
  end

  def __name__
    @name
  end

  def __store__
    @store
  end
end

require_relative '../../lib/ver/action'
Action = VER::Action

describe 'Action' do
  it 'can have a receiver' do
    action = Action.new(Bacon, :summary_on_exit)
    action.receiver.should == Bacon
  end

  should 'call #send to the widget by default' do
    widget = Dummy.new('widget')
    action = Action.new(nil)
    action.call(widget, 1)
    action.last.should == [widget, :call, widget, [1]]
  end

  should 'call #call on the receiver if one exists' do
    receiver = Dummy.new('receiver')
    widget = Dummy.new('widget')
    action = Action.new(receiver)
    action.call(widget, 1)
    action.last.should == [receiver, :call, widget, [1]]
  end

  it 'can have a callback block' do
    out = nil
    block = lambda{|event| out = event }
    action = Action.new(&block)
    action.block.should == block
    action.method.should == :call
    action.args.should == []
  end

  it 'can have arguments' do
    action = Action.new(Bacon, :summary_on_exit, [1,2,3])
    action.args.should == [1,2,3]
  end
end
