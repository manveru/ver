require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'External commands' do
      behaves_like :destructive_key_spec

      key ':sh[ell]', 'start a shell' do
        skip
      end

      key '!{command}', 'execute {command} with a shell' do
        skip
      end

      key 'K', 'lookup keyword under the cursor with "keywordprg" program (default: "man")' do
        skip
      end
    end
  end
end
