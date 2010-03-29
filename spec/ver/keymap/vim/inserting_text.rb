require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Inserting text' do
      behaves_like :destructive_key_spec

      key 'a', 'append text after the cursor (N times)' do |key|
        buffer.minor_mode?(:insert).should.be.nil
        type key
        buffer.minor_mode?(:insert).should.not.be.nil
        type ' Hello, World! '
        buffer.minor_mode?(:insert).should.not.be.nil
        insert.get('linestart', 'lineend').should ==
        "I Hello, World! nventore voluptatibus dolorem assumenda."
      end

      key 'A', 'append text at the end of the line (N times)' do |key|
        buffer.minor_mode?(:insert).should.be.nil
        type key
        buffer.minor_mode?(:insert).should.not.be.nil
        type ' Hello, World! '
        buffer.minor_mode?(:insert).should.not.be.nil
        insert.get('linestart', 'lineend').should ==
        "Inventore voluptatibus dolorem assumenda. Hello, World! "
      end

      keys 'i', '<Insert>', 'insert text before the cursor (N times)', do |key|
        buffer.minor_mode?(:insert).should.be.nil
        type key
        buffer.minor_mode?(:insert).should.not.be.nil
        type ' Hello, World! '
        buffer.minor_mode?(:insert).should.not.be.nil
        insert.get('linestart', 'lineend').should ==
        " Hello, World! Inventore voluptatibus dolorem assumenda."
      end

      key 'I', 'insert text before the first non-blank in the line (N times)' do |key|
        buffer.minor_mode?(:insert).should.be.nil
        type key
        buffer.minor_mode?(:insert).should.not.be.nil
        type ' Hello, World! '
        buffer.minor_mode?(:insert).should.not.be.nil
        insert.get('linestart', 'lineend').should ==
        " Hello, World! Inventore voluptatibus dolorem assumenda."
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil

        insert.index = '15.0'
        type key, 'Hello, World! '
        insert.get('linestart', 'lineend').should ==
        "    Hello, World! Cum autem explicabo dignissimos nemo."
      end

      key 'gI', 'insert text in column 1 (N times)' do |key|
        buffer.minor_mode?(:insert).should.be.nil
        type key
        buffer.minor_mode?(:insert).should.not.be.nil
        type ' Hello, World! '
        buffer.minor_mode?(:insert).should.not.be.nil
        insert.get('linestart', 'lineend').should ==
        " Hello, World! Inventore voluptatibus dolorem assumenda."
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil

        insert.index = '15.0'
        type key, 'Hello, World!'
        insert.get('linestart', 'lineend').should ==
        "Hello, World!    Cum autem explicabo dignissimos nemo."
      end

      key 'o', 'open a new line below the current line, append text (N times)' do |key|
        type key
        insert.index.should == '2.0'
        insert.get('linestart', 'lineend').should == ''
        buffer.minor_mode?(:insert).should.not.be.nil
      end

      key 'O', 'open a new line above the current line, append text (N times)' do |key|
        type key
        insert.index.should == '1.0'
        insert.get('linestart', 'lineend').should == ''
        buffer.minor_mode?(:insert).should.not.be.nil
      end

      key '{visual}I', 'insert the same text in front of all the selected lines' do
        type 'vjIHi <Return>'
        buffer.get('1.0', '4.0').should == <<-VALUE
Hi Inventore voluptatibus dolorem assumenda.
Hi Voluptates officiis quidem nemo est.
Qui similique quia voluptatem.
        VALUE
      end

      key '{visual}A', 'append the same text after all the selected lines' do
        type 'vjA Hi<Return>'
        buffer.get('1.0', '4.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Hi
Voluptates officiis quidem nemo est. Hi
Qui similique quia voluptatem.
        VALUE
      end

      # |:startinsert|  :star[tinsert][!]  start Insert mode, append when [!] used
      # |:startreplace| :startr[eplace][!]  start Replace mode, at EOL when [!] used
    end
  end
end
