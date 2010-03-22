require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Undo/Redo commands' do
      behaves_like :destructive_key_spec

      key 'u', 'undo last N changes' do
        skip
      end

      key '<Control-r>', 'redo last N undone changes' do
        skip
      end

      key 'U', 'restore last changed line' do
        skip
      end
    end
  end
end
