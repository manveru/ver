require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Insert mode keys' do
      behaves_like :destructive_key_spec

      before do
        type 'i'
      end

      key '<Escape>', 'end Insert mode, back to Normal mode' do |key|
        buffer.minor_mode?(:insert).should.not.nil
        type key
        buffer.minor_mode?(:insert).should.be.nil
      end

      key '<Control-c>', 'like <Escape>, but do not use an abbreviation' do |key|
        skip # we have no support for abbreviations, we do snippets.
      end

      key '<Control-o>{command}', 'execute {command} and return to Insert mode' do
        type '<Control-o>'
        buffer.minor_mode?(:insert).should.be.not.nil
        type 'l'
        buffer.minor_mode?(:insert).should.be.not.nil
        insert.index.should == '1.1'
      end

      key '<Up>', 'move cursor up' do |key|
        insert.index = 'end'
        type key
        insert.index.should == '40.40'
        type '<Right>', key
        insert.index.should == '39.27'
      end

      key '<Down>', 'move cursor down' do |key|
        type key
        insert.index.should == '2.0'
        type '<Right>', key
        insert.index.should == '3.1'
      end

      key '<Left>', 'move cursor left one character at a time until linestart' do |key|
        type key
        insert.index.should == '1.0'

        insert.index = '2.10'
        type key
        insert.index.should == '2.9'
        type key
        insert.index.should == '2.8'
      end

      key '<Right>', 'move cursor right one character at a time until lineend' do |key|
        type key
        insert.index.should == '1.1'
        type key
        insert.index.should == '1.2'

        insert.index = '1.41'
        type key
        insert.index.should == '1.41'
        type key
        insert.index.should == '1.41'
      end

      key '<Shift-Left>', 'one word left' do |key|
        insert.index = 'end'
        %w[41.39 41.29 41.23 41.15 41.12 41.0 40.42].each do |index|
          type key
          insert.index.should == index
        end
      end

      key '<Shift-Right>', 'one word right' do |key|
        %w[1.10 1.23 1.31 1.40 2.0 2.11].each do |index|
          type key
          insert.index.should == index
        end
      end

      key '<End>', 'cursor after last character in the line' do |key|
        type key
        insert.index.should == '1.41'
        insert.index = '41.0'
        type key
        insert.index.should == '41.40'
      end

      key '<Home>', 'cursor to first character in the line' do |key|
        # first line
        type key
        insert.index.should == '1.0'
        type key
        insert.index.should == '1.0'

        # make sure it also works on indented lines
        insert.index = '16.10'
        type key
        insert.index.should == '16.0'
        type key
        insert.index.should == '16.0'

        # and on last line
        insert.index = 'end'
        type key
        insert.index.should == '41.0'
        type key
        insert.index.should == '41.0'
      end
    end
  end
end
