require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Copying and moving text' do
      behaves_like :destructive_key_spec

      key '"{char}', 'use register {char} for the next delete, yank, or put' do
        skip
      end

      key ':reg', 'show the contents of all registers' do
        skip
      end

      key ':reg {arg}', 'show the contents of registers mentioned in {arg}' do
        skip
      end

      key 'y{motion}', 'yank the text moved over with {motion} into a register' do
        skip
      end

      key '{visual}y', 'yank the highlighted text into a register' do
        skip
      end

      key 'yy', 'yank N lines into a register' do
        skip
      end

      key 'Y', 'yank N lines into a register' do
        skip
      end

      key 'p', 'put a register after the cursor position (N times)' do
        skip
      end

      key 'P', 'put a register before the cursor position (N times)' do
        skip
      end

      key ']p', 'like p, but adjust indent to current line' do
        skip
      end

      key '[p', 'like P, but adjust indent to current line' do
        skip
      end

      key 'gp', 'like p, but leave cursor after the new text' do
        skip
      end

      key 'gP', 'like P, but leave cursor after the new text' do
        skip
      end
    end
  end
end
