require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Left-Right motions' do
      behaves_like :key_spec

      keys 'h', '<BackSpace>', '<Left>', 'go one character left' do |key|
        buffer.insert = '1.5'
        type key
        insert.should == '1.4'
      end

      keys 'l', '<Right>', 'go one character right' do |key|
        type key
        insert.should == '1.1'
      end

      keys '0', '<Home>', 'goes to first character in the line' do |key|
        buffer.insert = '1.5'
        type key
        insert.should == '1.0'
      end

      key '^', 'goes to the first non-blank character in the line' do
        insert.index = '14.5'
        type '^'
        insert.index.should == '14.2'
      end

      keys '$', '<End>', 'goes to last character in the line (N-1 lines lower)' do |key|
        type key
        insert.index.should == '1.41'
        type "4#{key}"
        insert.index.should == '4.31'
        type "4#{key}"
        insert.index.should == '7.29'
      end

      key 'g0', 'to first character in display line' do |key|
        type key
        insert.index.should == '1.0'
      end

      key 'g^', 'to first non-blank character in display line' do
        skip
      end

      key 'g$', 'to last character in display line' do
        skip
      end

      key 'gm', 'to middle of display line' do
        skip
      end

      key '|', 'to column N (default: 1)' do
        type '|'
        insert.index.should == '1.0'
        insert.index = '1.5'
        type '|'
        insert.index.should == '1.0'
        type '5|'
        insert.index.should == '1.5'
      end

      key 'f{char}', 'to Nth occurance of {char} to the right' do
        type 'fe'
        insert.index.should == '1.3'
        type '2fe'
        insert.index.should == '1.28'
      end

      key 'F{char}', 'to Nth occurance of {char to the left' do
        insert.index = '1.0 lineend'
        type 'Fe'
        insert.index.should == '1.36'

        insert.index = '1.0 lineend'
        type '3Fe'
        insert.index.should == '1.8'
      end

      key 't{char}', 'till before Nth occurance of {char} to the right' do
        insert.index = '1.0'
        type 'te'
        insert.index.should == '1.2'

        insert.index = '1.0'
        type '3te'
        insert.index.should == '1.27'
      end

      key 'T{char}', 'till before Nth occurance of {char} to the left' do
        insert.index = '1.0 lineend'
        type 'Te'
        insert.index.should == '1.37'

        insert.index = '1.0 lineend'
        type '3Te'
        insert.index.should == '1.9'
      end

      key ';', 'repeats search for char' do
        type 'fe'
        insert.index.should == '1.3'
        type ';'
        insert.index.should == '1.8'
      end

      key ',,', 'repeats search for char in the opposite direction' do
        insert.index = '1.5'
        type 'fe'
        insert.index.should == '1.8'
        type ',,'
        insert.index.should == '1.3'
      end
    end
  end
end
