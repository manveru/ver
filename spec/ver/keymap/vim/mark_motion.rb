require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Mark motions' do
      behaves_like :key_spec

      key 'm{a-zA-Z}', 'mark current position with mark {a-zA-Z}' do
        skip
      end

      key '`{a-z}', 'go to mark {a-z} within current file' do
        skip
      end

      key '`{A-Z}', 'go to mark {A-Z} in any file' do
        skip
      end

      key '`{0-9}', 'go to the position where Vim was previously exited' do
        skip
      end

      key '``', 'go to the position before the last jump' do
        skip
      end

      key '`"', 'go to the position when last editing this file' do
        skip
      end

      key '`[', 'go to the start of the previously operated or put text' do
        skip
      end

      key '`]', 'go to the end of the previously operated or put text' do
        skip
      end

      key '`<', 'go to the start of the (previous) Visual area' do
        skip
      end

      key '`>', 'go to the end of the (previous) Visual area' do
        skip
      end

      key '`.', 'go to the position of the last change in this file' do
        skip
      end

      key '`{a-zA-Z0-9[]\'"<>.}', 'same as `, but on the first non-blank in the line' do
        skip
      end

      key ':marks', 'print the active marks' do
        skip
      end

      key '<Control-o>', 'go to Nth older position in jump list' do
        skip
      end

      key '<Control-i>', 'go to Nth newer position in jump list' do
        skip
      end

      key ':ju[mps]', 'print the jump list' do
        skip
      end
    end
  end
end
