require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Deleting text' do
      behaves_like :destructive_key_spec

      keys 'x', '<Delete>', 'delete N characters under and after the cursor' do
        skip
      end

      key 'X', 'delete N characters before the cursor' do
        skip
      end

      key 'd{motion}', 'delete the text that is moved over with {motion}' do
        skip
      end

      key '{visual}d', 'delete the highlighted text' do
        skip
      end

      key 'dd', 'delete N lines' do
        skip
      end

      key 'D', 'delete to the end of line (and N-1 more lines)' do
        skip
      end

      key 'J', 'join N-1 lines (delete <EOL>s)' do
        skip
      end

      key '{visual}J', 'join the highlighted lines' do
        skip
      end

      key 'gJ', 'like J but without inserting spaces' do
        skip
      end

      key '{visual}gJ', 'like {visual}J, but without inserting spaces' do
        skip
      end
    end
  end
end
