require 'bacon'
Bacon.summary_on_exit

class Dummy < BasicObject
  def initialize
    @store = []
  end

  def method_missing(method, *args)
    @store << [method, args]
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

  should 'call #call on the receiver by default' do
    dummy = Dummy.new
    action = Action.new(dummy)
    action.receiver.should == dummy
    action.call(:widget, 1)
    dummy.__store__.should == [
      [:should, []],
      [:respond_to?, [:to_ary]],
      [:send, [:call, :widget, 1]]
    ]
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

