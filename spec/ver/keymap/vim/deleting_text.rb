require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Deleting text' do
      behaves_like :destructive_key_spec

      keys 'x', '<Delete>', 'delete N characters under and after the cursor' do |key|
        type key, 9, 'l', 4, key
        buffer.get('1.0', '2.0').should == "nventore ptatibus dolorem assumenda.\n"
      end

      key 'X', 'delete N characters before the cursor' do |key|
        # should not delete anything at start of first line
        type 10, key
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda.
        VALUE

        # should not delete anything at start of second line
        type 'j', 10, key
        buffer.get('1.0', '3.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda.
Voluptates officiis quidem nemo est.
        VALUE

        # but should delete within the line
        type 9, 'l', 4, key
        buffer.get('1.0', '3.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda.
Volups officiis quidem nemo est.
        VALUE
      end

      key 'd{motion}', 'delete the text that is moved over with {motion}' do
        type 'dj'
        buffer.get('1.0', '3.0').should == <<-VALUE
Voluptates officiis quidem nemo est.
Qui similique quia voluptatem.
        VALUE

        # vim would result in:
        # Qui similique quia voluptatem.
        # Sit pariatur vel aperiam et ab.
      end

      key '{visual}d', 'delete the highlighted text' do |key|
        type 'vjd'
        buffer.get('1.0', '3.0').should == <<-VALUE
oluptates officiis quidem nemo est.
Qui similique quia voluptatem.
        VALUE
        buffer.minor_mode?(:select_char).should.be.nil
      end

      key '{visual}d', 'delete the highlighted text' do
        buffer.value = "one\ntwo"
        type 'ggVGd'
        buffer.value.should == "\n"
        VER::Register['*'].value.should == "one\ntwo\n"
      end

      key 'dd', 'delete N lines' do |key|
        type key
        buffer.get('1.0', '2.0').should == <<-VALUE
Voluptates officiis quidem nemo est.
        VALUE
        VER::Register['*'].value.should == <<-VALUE
Inventore voluptatibus dolorem assumenda.
        VALUE

        type 5, key
        buffer.get('1.0', '2.0').should == <<-VALUE
Quasi beatae sunt est et quo.
        VALUE
        VER::Register['*'].value.should == <<-VALUE
Voluptates officiis quidem nemo est.
Qui similique quia voluptatem.
Sit pariatur vel aperiam et ab.
Quam dolorem dignissimos perferendis.
Nostrum cumque quaerat nobis ut repudiandae vitae autem perferendis.
        VALUE
      end

      key 'D', 'delete to the end of line (and N-1 more lines)' do |key|
        type key
        buffer.get('1.0', '2.0').should == "\n"
        type 3, key
        # vim doesn't do the leading newline...
        # up/down motions always swallow whole lines.
        buffer.get('1.0', '3.0').should == "\nSit pariatur vel aperiam et ab.\n"
      end

      key 'J', 'join N-1 lines (delete <EOL>s)' do |key|
        # we behave like vim with :set nojoinspaces which i find more useful
        # who needs two spaces instead of one?
        type key
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Voluptates officiis quidem nemo est.
        VALUE
        insert.index.should == '1.42'

        type 3, key
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Voluptates officiis quidem nemo est. Qui similique quia voluptatem. Sit pariatur vel aperiam et ab.
        VALUE
        insert.index.should == '1.110'
      end

      key '{select_char}J', 'join the highlighted lines' do
        type 'vjJ'
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Voluptates officiis quidem nemo est.
        VALUE
        insert.index.should == '1.42'
      end

      key '{select_char}J', 'join the highlighted lines' do
        type 'v2jJ'
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Voluptates officiis quidem nemo est. Qui similique quia voluptatem.
        VALUE
        insert.index.should == '1.79'
      end

      key '{select_line}J', 'join the highlighted lines' do
        type 'VjJ'
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Voluptates officiis quidem nemo est.
        VALUE
        insert.index.should == '1.42'
      end


      key '{select_line}J', 'join the highlighted lines' do
        type 'V2jJ'
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Voluptates officiis quidem nemo est. Qui similique quia voluptatem.
        VALUE
        insert.index.should == '1.79'
      end

      key '{select_block}J', 'join the highlighted lines' do
        type '<Control-v>jJ'
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Voluptates officiis quidem nemo est.
        VALUE
        insert.index.should == '1.42'
      end

      key '{select_block}J', 'join the highlighted lines' do
        type '<Control-v>2jJ'
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda. Voluptates officiis quidem nemo est. Qui similique quia voluptatem.
        VALUE
        insert.index.should == '1.79'
      end

      key 'gJ', 'like J but without inserting spaces' do |key|
        type key
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda.Voluptates officiis quidem nemo est.
        VALUE
        insert.index.should == '1.41'

        type 3, key
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda.Voluptates officiis quidem nemo est.Qui similique quia voluptatem.Sit pariatur vel aperiam et ab.
        VALUE
        insert.index.should == '1.107'
      end

      key '{visual}gJ', 'like {visual}J, but without inserting spaces' do |key|
        type 'vjgJ'
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda.Voluptates officiis quidem nemo est.
        VALUE
        insert.index.should == '1.41'

        type 'v3jgJ'
        buffer.get('1.0', '2.0').should == <<-VALUE
Inventore voluptatibus dolorem assumenda.Voluptates officiis quidem nemo est.Qui similique quia voluptatem.Sit pariatur vel aperiam et ab.Quam dolorem dignissimos perferendis.Nostrum cumque quaerat nobis ut repudiandae vitae autem perferendis.
        VALUE
        insert.index.should == '1.175'
      end
    end
  end
end
