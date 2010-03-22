require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Up-Down motions' do
      behaves_like :key_spec

      key 'k', '<Control-p>', '<Up>', 'go up N lines' do |key|
        insert.index = '10.10'
        type key
        insert.index.should == '9.10'
      end

      keys 'j', '<Control-j>', '<Control-n>', '<Down>', 'go down N lines' do |key|
        type key
        insert.index.should == '2.0'
        insert.index = '1.10'
        type key
        insert.index.should == '2.10'
      end

      key '-', 'up N lines, on the first non-blank character' do |key|
        insert.index = 'end'
        type key
        insert.index.should == '40.0'
        type "25#{key}"
        insert.index.should == '15.4'
      end

      key '+', '<Control-m>', '<Return>',
      'go down N lines, on the first non-blank character' do |key|
        type key
        insert.index.should == '2.0'
        type "13#{key}"
        insert.index.should == '15.4'
      end

      key '_', 'go down N-1 lines, on the first non-blank character' do
        insert.index = '2.10'
        type '_'
        insert.index.should == '2.0'
        type '2_'
        insert.index.should == '3.0'
        type '12_'
        insert.index.should == '14.2'
        type '2_'
        insert.index.should == '15.4'
      end

      key 'G', 'goto line N (default: last line), on the first non-blank character' do
        insert.index = '20.0'
        type 'G'
        insert.index.should == '41.0'
        type '2G'
        insert.index.should == '2.0'
        type '15G'
        insert.index.should == '15.4'
      end

      key 'gg', 'goes to line N (default: first line), on the first non-blank character' do
        insert.index = '20.0'
        type 'gg'
        insert.index.should == '1.0'
        type '2gg'
        insert.index.should == '2.0'
        type '015gg'
        insert.index.should == '15.4'
      end

      key 'N%', 'goto line N percentage down in the file. N must be given' do
        type '6%'
        insert.index.should == '3.0'
        type '12%'
        insert.index.should == '5.0'
        type '24%'
        insert.index.should == '10.0'
        type '48%'
        insert.index.should == '20.0'
        type '96%'
        insert.index.should == '40.0'
        type '100%'
        insert.index.should == '41.0'
      end

      keys 'gk', 'g<Up>', 'go up N display lines' do |key|
        skip
      end

      keys 'gj', 'g<Down>', 'go down N display lines' do |key|
        skip
      end
    end
  end
end
