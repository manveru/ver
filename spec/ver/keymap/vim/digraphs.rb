require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Digraphs' do
      behaves_like :destructive_key_spec

      key '<Control-k>{char1}{char2}', 'enter digraph' do
        skip
      end
    end
  end
end
