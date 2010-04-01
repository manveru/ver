require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Special keys in Insert mode' do
      behaves_like :destructive_key_spec

      before do
        type 'i'
      end

      key '<Control-v>', 'insert character for ordinal equivalent' do |key|
        buffer.value = ''
        type key, '065'
        buffer.value.should == "A\n"
      end

      key '<Control-v>o', 'insert character for octal equivalent' do |key|
        buffer.value = ''
        type key, '101'
        buffer.value.should == "A\n"
      end

      key '<Control-v>O', 'insert character for octal equivalent' do |key|
        buffer.value = ''
        type key, '101'
        buffer.value.should == "A\n"
      end

      key '<Control-v>x', 'insert character for hexadecimal equivalent of length two' do |key|
        buffer.value = ''
        type key, '41'
        buffer.value.should == "A\n"
      end

      key '<Control-v>X', 'insert character for hexadecimal equivalent of length two' do |key|
        buffer.value = ''
        type key, '41'
        buffer.value.should == "A\n"
      end

      key '<Control-v>u', 'insert character for hexadecimal equivalent of length four' do |key|
        buffer.value = ''
        type key, '0041'
        buffer.value.should == "A\n"
      end

      key '<Control-v>U', 'insert character for hexadecimal equivalent of length eight' do |key|
        buffer.value = ''
        type key, '00000041'
        buffer.value.should == "A\n"
      end

      keys '<Return>', '<Control-m>', '<Control-j>', 'begin new line' do |key|
        buffer.value = ''
        type key
        buffer.value.should == "\n\n"
      end

      key '<Control-e>', 'insert the character from below the cursor' do |key|
        buffer.value = "\nsecond line"
        insert.index = '1.0'
        type key
        buffer.value.should == <<-VALUE
s
second line
        VALUE
        15.times{ type key }
        buffer.value.should == <<-VALUE
second line
second line
        VALUE
      end

      key '<Control-y>', 'insert the character from above the cursor' do |key|
        buffer.value = "first line\n"
        insert.index = '2.0'
        type key
        buffer.value.should == <<-VALUE
first line
f
        VALUE
        15.times{ type key }
        buffer.value.should == <<-VALUE
first line
first line
        VALUE
      end

      key '<Control-a>', 'insert previously inserted text' do
        skip
      end

      key '<Control-at>', 'insert previously inserted text and stop Insert mode' do
        skip
      end

      key '<Control-r>', 'insert the contents of a register' do
        skip
      end

      key '<Control-n>', 'insert next match of identifier before the cursor' do
        skip
      end

      key '<Control-p>', 'insert previous match of identifier before the cursor' do
        skip
      end

      key '<Control-x>', 'complete the word before the cursor in various ways' do
        skip
      end

      key '<BackSpace>', '<Control-h>', 'delete the character before the cursor' do |key|
        insert.index = '1.22'
        13.times{ type key }
        insert.get('linestart', 'lineend').should == "Inventore dolorem assumenda."
      end

      key '<Delete>', 'delete the character under the cursor' do |key|
        type key
        insert.get.should == 'n'
      end

      key '<Control-w>', 'delete word before the cursor' do |key|
        insert.index = '1.22'
        type key
        insert.get('linestart', 'lineend').should == "Inventore  dolorem assumenda."
      end

      key '<Control-u>', 'delete all entered characters in the current line' do |key|
        skip
      end

      key '<Control-t>', 'insert one shiftwidth of indent in front of the current line' do |key|
        insert.index = '16.16'
        type key
        buffer.get('13.0', '18.0').should == <<-VALUE
Fugiat tempore officiis ab.
  Aut culpa accusantium consequatur laboriosam pariatur.
    Cum autem explicabo dignissimos nemo.
        Omnis vero rerum et in fugiat et eos.
Ipsum commodi beatae maxime deserunt aut.
        VALUE
      end

      key '<Control-d>', 'delete one shiftwidth of indent in front of the current line' do |key|
        insert.index = '16.16'
        type key
        buffer.get('13.0', '18.0').should == <<-VALUE
Fugiat tempore officiis ab.
  Aut culpa accusantium consequatur laboriosam pariatur.
    Cum autem explicabo dignissimos nemo.
    Omnis vero rerum et in fugiat et eos.
Ipsum commodi beatae maxime deserunt aut.
        VALUE
      end

      key '0<Control-d>', 'delete all indent in the current line' do |key|
        skip # i don't think i'll implement that myself
      end

      key '^<Control-d>', 'delete all indent in the current line, restore indent in next line' do |key|
        skip # i don't think i'll implement that myself
      end
    end
  end
end
