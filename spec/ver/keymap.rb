require_relative '../helper'

VER.spec do
  describe VER::Keymap do
    Keymap = VER::Keymap

    before do
      @keymap = Keymap.new
    end

    def keymap
      @keymap
    end

    it 'maps objects to a key' do
      keymap['t'] = 'our t'
      keymap['t'].should == 'our t'
    end

    it 'maps objects to a sequence of keys' do
      keymap['d', 'd'] = 'our d'
      keymap['d', 'd'].should == 'our d'
    end

    it 'creates deeper nestings' do
      keymap['a', 'b', 'c', 'd'] = :foo
      keymap['a', 'b', 'c', 'd'].should == :foo
    end

    it 'branches as needed' do
      keymap['a', 'b', 'c', 'd'] = 'abcd'
      keymap['a', 'b', 'c', 'e'] = 'abce'
      keymap['a', 'b', 'c', 'd'].should == 'abcd'
      keymap['a', 'b', 'c', 'e'].should == 'abce'
    end

    it "indicates when the given key-sequence doesn't match yet" do
      keymap['a', 'b', 'c', 'd'] = 'abcd'
      keymap['a', 'b'].should.be.kind_of Keymap::Results::Incomplete
    end

    it "indicates when the given key-sequence will never match" do
      keymap['a', 'b', 'c', 'd'] = 'abcd'
      keymap['x', 'y'].should.be.kind_of Keymap::Results::Impossible
    end

    it 'performs a merge with another keymap' do
      keymap1 = Keymap.new
      keymap1['a'] = 'keymap1 a'

      keymap2 = Keymap.new
      keymap2['b'] = 'keymap2 b'

      keymap1b = keymap1.merge(keymap2)
      keymap1b['a'].should == 'keymap1 a'
      keymap1b['b'].should == 'keymap2 b'
    end

    it "doesn't overwrite existing sequences on merge" do
      keymap1 = Keymap.new
      keymap1['a'] = 'keymap1 a'

      keymap2 = Keymap.new
      keymap2['a'] = 'keymap2 a'
      keymap2['b'] = 'keymap2 b'

      keymap1b = keymap1.merge(keymap2)
      keymap1b['a'].should == 'keymap1 a'
      keymap1b['b'].should == 'keymap2 b'
    end

    it 'overrides existing sequences on assignment' do
      keymap['a'] = 'keymap a1'
      keymap['a'].should == 'keymap a1'
      keymap['a'] = 'keymap a2'
      keymap['a'].should == 'keymap a2'
    end
  end
end
