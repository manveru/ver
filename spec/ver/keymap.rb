require 'bacon'
Bacon.summary_on_exit

require_relative '../../lib/ver/keymap'

describe Keymap = VER::Keymap do
  it 'maps objects to a key' do
    km = Keymap.new
    km['t'] = 'our t'
    km['t'].should == 'our t'
  end

  it 'maps objects to a sequence of keys' do
    km = Keymap.new
    km['d', 'd'] = 'our d'
    km['d', 'd'].should == 'our d'
  end

  it 'creates deeper nestings' do
    km = Keymap.new
    km['a', 'b', 'c', 'd'] = :foo
    km['a', 'b', 'c', 'd'].should == :foo
  end

  it 'branches as needed' do
    km = Keymap.new
    km['a', 'b', 'c', 'd'] = 'abcd'
    km['a', 'b', 'c', 'e'] = 'abce'
    km['a', 'b', 'c', 'd'].should == 'abcd'
    km['a', 'b', 'c', 'e'].should == 'abce'
  end

  it "indicates when the given key-sequence doesn't match yet" do
    km = Keymap.new
    km['a', 'b', 'c', 'd'] = 'abcd'
    km['a', 'b'].should == Keymap::INCOMPLETE
  end

  it "indicates when the given key-sequence will never match" do
    km = Keymap.new
    km['a', 'b', 'c', 'd'] = 'abcd'
    km['x', 'y'].should == Keymap::IMPOSSIBLE
  end

  it 'performs a merge with another keymap' do
    kma = Keymap.new
    kma['a'] = 'kma a'

    kmb = Keymap.new
    kmb['b'] = 'kmb b'

    kmab = kma.merge(kmb)
    kmab['a'].should == 'kma a'
    kmab['b'].should == 'kmb b'
  end

  it "doesn't overwrite existing sequences on merge" do
    kma = Keymap.new
    kma['a'] = 'kma a'

    kmb = Keymap.new
    kmb['a'] = 'kmb a'
    kmb['b'] = 'kmb b'

    kmab = kma.merge(kmb)
    kmab['a'].should == 'kma a'
    kmab['b'].should == 'kmb b'
  end

  it 'overrides existing sequences on assignment' do
    km = Keymap.new
    km['a'] = 'km a1'
    km['a'].should == 'km a1'
    km['a'] = 'km a2'
    km['a'].should == 'km a2'
  end
end
