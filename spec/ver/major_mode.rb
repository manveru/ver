require 'bacon'
Bacon.summary_on_exit

require 'ffi-tk'

require_relative '../../lib/ver/keymap'
require_relative '../../lib/ver/major_mode'
require_relative '../../lib/ver/minor_mode'
require_relative '../../lib/ver/action'

MajorMode = VER::MajorMode
MinorMode = VER::MinorMode
Action = VER::Action
Keymap = VER::Keymap

describe MajorMode do
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
    mode.map(:kill_word, ['d', 'w'])
    mode.map(:kill_line, ['d', 'd'])
    mode.resolve(['d', 'w']).should == Action.new(nil, :kill_word)
  end

  it 'creates an unambigous keymap' do
    mode = MajorMode[:spec]
    mode.map(:kill_word, ['d', 'w'])
    mode.map(:kill_line, ['d', 'd'])
    mode.keymap['d', 'w'].should == Action.new(nil, :kill_word)
    mode.keymap['d', 'd'].should == Action.new(nil, :kill_line)
  end

  it 'can inherit another major mode' do
    fund = MajorMode[:Fundamental]
    fund.map(:kill_word, ['d', 'w'])
    fund.map(:kill_line, ['d', 'd'])

    ruby = MajorMode[:Ruby]
    ruby.inherits(:Fundamental)
    ruby.map(:preview, ['Control-c', 'Control-c'])

    ruby.resolve(['d', 'd']).should == Action.new(nil, :kill_line)
    ruby.resolve(['d', 'w']).should == Action.new(nil, :kill_word)
    ruby.resolve(['<Control-c>', '<Control-c>']).
      should == Action.new(nil, :preview)

    fund.resolve(['d', 'd']).should == Action.new(nil, :kill_line)
    fund.resolve(['d', 'w']).should == Action.new(nil, :kill_word)
    fund.resolve(['<Control-c>', '<Control-c>']).
      should == Keymap::IMPOSSIBLE
  end

  it 'may have a fallback that is invoked on IMPOSSIBLE results' do
    mode = MajorMode[:spec]
    mode.map(:kill_word, ['d', 'w'])
    mode.missing(:insert)
    mode.resolve(['d', 'w']).should == Action.new(nil, :kill_word)
    mode.resolve(['f', 'o', 'o']).should == Action.new(nil, :insert)
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

  it 'binds all keys found in its keymap to the tag' do
    major = MajorMode[:spec]
    major.tag.bind.should == []
    major.map(:delete, ['d'])
    major.tag.bind.should == ['d']
  end

  it 'binds all keys found in its minor modes to the tag' do
    major = MajorMode[:major]
    major.map(:major1, ['m', '1'])
    minoa = MinorMode[:minoa]
    minoa.map(:minoa2, ['a', '2'])
    minob = MinorMode[:minob]
    minob.map(:minob3, ['b', '3'])

    major.use(:minoa, :minob)
    major.bound_keys.should == Set.new(%w[m a b 1 2 3])
    major.tag.bind.sort.should == %w[1 2 3 a b m]
  end

  it "won't synchronize with minor modes if they don't" do
    major = MajorMode[:major]
    minoa = MinorMode[:minoa]
    minob = MinorMode[:minob]
    major.use(:minoa, :minob)
    major.map(:major1, ['m', '1'])
    minoa.map(:minoa2, ['a', '2'])
    minob.map(:minob3, ['b', '3'])

    major.bound_keys.should == Set.new(%w[m 1])
    major.tag.bind.sort.should == %w[1 m]

    minoa.synchronize(major)
    major.bound_keys.should == Set.new(%w[m a 1 2])
    major.tag.bind.sort.should == %w[1 2 a m]

    minob.synchronize(major)
    major.bound_keys.should == Set.new(%w[m a b 1 2 3])
    major.tag.bind.sort.should == %w[1 2 3 a b m]
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
