require_relative '../helper'

MajorMode = VER::MajorMode
MinorMode = VER::MinorMode
Action = VER::Action
Keymap = VER::Keymap

VER.spec do

  describe VER::MajorMode do
    before do
      MajorMode.clear
      MinorMode.clear
    end

    it 'has a name' do
      mode = MajorMode[:spec]
      mode.name.should == :spec
    end

    it 'has no minor modes at first' do
      mode = MajorMode[:spec]
      mode.minors.should.be.empty
    end

    it 'has a keymap' do
      mode = MajorMode[:spec]
      mode.keymap.should == Keymap.new
    end

    it 'returns an action for a given sequence' do
      mode = MajorMode[:spec]
      mode.map(:kill_word, 'dw')
      mode.map(:kill_line, 'dd')

      action = mode.resolve(['d', 'w'])
      action.mode.should == mode
      action.handler.should == nil
      action.invocation.should == :kill_word
    end

    it 'creates an unambigous keymap' do
      mode = MajorMode[:spec]
      mode.map(:kill_word, 'dw')
      mode.map(:kill_line, 'dd')

      action = mode.keymap['d', 'w']
      action.handler.should == nil
      action.invocation.should == :kill_word

      action = mode.keymap['d', 'd']
      action.handler.should == nil
      action.invocation.should == :kill_line
    end

    it 'can inherit another major mode' do
      fund = MajorMode[:Fundamental]
      fund.map(:kill_word, 'dw')
      fund.map(:kill_line, 'dd')

      ruby = MajorMode[:Ruby]
      ruby.inherits(:Fundamental)
      ruby.map(:preview, '<Control-c><Control-c>')

      action = ruby.resolve(['d', 'd'])
      action.mode.should == fund
      action.invocation.should == :kill_line

      action = ruby.resolve(['d', 'w'])
      action.mode.should == fund
      action.invocation.should == :kill_word

      action = ruby.resolve(['<Control-c>', '<Control-c>'])
      action.mode.should == ruby
      action.invocation.should == :preview

      action = fund.resolve(['d', 'd'])
      action.mode.should == fund
      action.invocation.should == :kill_line

      action = fund.resolve(['d', 'w'])
      action.mode.should == fund
      action.invocation.should == :kill_word

      action = fund.resolve(['<Control-c>', '<Control-c>'])
      action.should.be.kind_of Keymap::Results::Impossible
    end

    it 'may have a fallback that is invoked on impossible results' do
      mode = MajorMode[:spec]
      mode.map(:kill_word, 'dw')
      mode.missing(:insert)

      action = mode.resolve(['d', 'w'])
      action.mode.should == mode
      action.invocation.should == :kill_word

      action = mode.resolve(['f', 'o', 'o'])
      action.mode.should == mode
      action.invocation.should == :insert
    end

    it 'can have minor modes' do
      major = MajorMode[:major]
      minoa = MinorMode[:minoa]
      minob = MinorMode[:minob]

      major.use(:minoa, :minob)
      major.minors.should == [minoa, minob]
    end

    it 'can replace a minor mode with another one' do
      major = MajorMode[:major]
      minoa = MinorMode[:minoa]
      minob = MinorMode[:minob]

      major.use(:minoa)
      major.minors.should == [minoa]

      major.forget(:minoa)
      major.minors.should == []

      major.use(:minob)
      major.minors.should == [minob]
    end

    it 'has a bindtag' do
      major = MajorMode[:spec]
      major.tag.name.should == 'spec-mode'
    end

    it 'can modify the parents chain of its minor modes' do
      major = MajorMode[:Fundamental]
      control = MinorMode[:control]
      count = MinorMode[:count]
      move = MinorMode[:move]
      move_count = MinorMode[:move_count]

      major.use :control
      control.inherits :move
      move_count.inherits :move, :count

      control.parents.should == [move]
      major.replace_minor(:move, :move_count)
      control.parents.should == [move_count]
      major.replace_minor(:move_count, :move)
      control.parents.should == [move]
    end
  end
end
