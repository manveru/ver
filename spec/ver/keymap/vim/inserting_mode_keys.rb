require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Insert mode keys' do
      behaves_like :destructive_key_spec

      key '<Escape>', 'end Insert mode, back to Normal mode' do
        skip
      end

      key '<Control-c>', 'like <Escape>, but do not use an abbreviation' do
        skip
      end

      key '<Control-o>{command}', 'execute {command} and return to Insert mode' do
        skip
      end

      key '<Up>', 'move cursor up' do
        skip
      end

      key '<Down>', 'move cursor down' do
        skip
      end

      key '<Left>', 'move cursor left' do
        skip
      end

      key '<Right>', 'move cursor right' do
        skip
      end

      key '<Shift-Left>', 'one word left' do
        skip
      end

      key '<Shift-Right>', 'one word right' do
        skip
      end

      key '<End>', 'cursor after last character in the line' do
        skip
      end

      key '<Home>', 'cursor to first character in the line' do
        skip
      end
    end
  end
end
