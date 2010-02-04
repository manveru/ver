require_relative '../helper'

MinorMode = VER::MinorMode
Keymap = VER::Keymap

VER.spec do
  describe VER::MinorMode do
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

      action_mode, action = control.resolve(['q'])
      action_mode.should == control
      action.method.should == :quit

      action_mode, action = control.resolve(['j'])
      action_mode.should == movement
      action.method.should == :next_line
    end

    it 'indicates whether a sequence can be found' do
      control = MinorMode[:control]
      control.map(:quit, ['Z', 'Z'])

      action_mode, action = control.resolve(['Z', 'Z'])
      action_mode.should == control
      action.method.should == :quit

      control.resolve(['Z']).should == Keymap::INCOMPLETE
      control.resolve(['X']).should == Keymap::IMPOSSIBLE
    end

    it 'may have a fallback that is returned on IMPOSSIBLE results' do
      mode = MinorMode[:spec]
      mode.map(:kill_word, ['d', 'w'])
      mode.missing(:insert)

      action_mode, action = mode.resolve(['d', 'w'])
      action.method.should == :kill_word

      action_mode, action = mode.resolve(['y'])
      action.method.should == :insert
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

      action_mode, action = control.resolve(['d', 'd'])
      action_mode.should == kill
      action.method.should == :kill_line

      action_mode, action = control.resolve(['d', 'j'])
      action_mode.should == kill
      action.method.should == :kill_motion
      action.args.first.method.should == :next_line
    end
  end
end
