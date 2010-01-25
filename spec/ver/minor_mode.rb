require 'bacon'
Bacon.summary_on_exit

require_relative '../../lib/ver/keymap'
require_relative '../../lib/ver/minor_mode'
require_relative '../../lib/ver/action'

describe MinorMode = VER::MinorMode do
  before do
    MinorMode.clear
  end

  it 'has a name' do
    mode = MinorMode[:spec]
    mode.name.should == :spec
  end

  it 'has no parents at first' do
    mode = MinorMode[:spec]
    mode.parents.should.be.empty
  end

  it 'can depend on another minor mode' do
    control = MinorMode[:control]
    movement = MinorMode[:movement]
    control.inherits(:movement)

    control.parents.should == [movement]
  end

  it 'looks up key-sequences in the inheritance chain' do
    control = MinorMode[:control]
    movement = MinorMode[:movement]
    movement.map(:next_line, ['j'])
    control.map(:quit, ['q'])
    control.inherits(:movement)

    control.resolve(['q']).should == VER::Action.new(nil, :quit)
    control.resolve(['j']).should == VER::Action.new(nil, :next_line)
  end

  it 'indicates whether a sequence can be found' do
    control = MinorMode[:control]
    control.map(:quit, ['Z', 'Z'])

    control.resolve(['Z', 'Z']).should == VER::Action.new(nil, :quit)
    control.resolve(['Z']).should == VER::Keymap::INCOMPLETE
    control.resolve(['X']).should == VER::Keymap::IMPOSSIBLE
  end

  it 'may have a fallback that is returned on IMPOSSIBLE results' do
    mode = MinorMode[:spec]
    mode.map(:kill_word, ['d', 'w'])
    mode.missing(:insert)
    mode.resolve(['d', 'w']).should == VER::Action.new(nil, :kill_word)
    mode.resolve(['y']).should == VER::Action.new(nil, :insert)
  end

  it "can do lookup spanning multiple minor modes" do
    move = MinorMode[:move]
    move.map(:next_line, ['j'])
    move.map(:prev_line, ['k'])
    kill = MinorMode[:kill]
    kill.map(:kill_line, ['d', 'd'])
    kill.map(:kill_motion, ['d', :move])
    control = MinorMode[:control]
    control.inherits :move, :kill

    control.resolve(['d', 'd']).should == VER::Action.new(nil, :kill_line)
    control.resolve(['d', 'j']).should ==
      VER::Action.new(nil, :kill_motion, [VER::Action.new(nil, :next_line)])
  end
end
