require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Changing text' do
      # change means: delete text and enter Insert mode
      behaves_like :destructive_key_spec

      key 'r{char}', 'replace N characters with {char}' do
        skip
      end

      key 'gr{char}', 'replace N characters without affecting layout' do
        skip
      end

      key 'R', 'enter Replace mode (repeat the entered text N times)' do
        skip
      end

      key 'gR', 'enter virtual Replace mode: Like Replace mode but without affecting layout' do
        skip
      end

      key '{visual}r{char}', 'in Visual block mode: Replace each char of the selected text with {char}' do
        skip
      end

      key 'c{motion}', 'change the text that is moved over with {motion}' do
        skip
      end

      key '{visual}c', 'change the highlighted text' do
        skip
      end

      keys 'cc', 'S', 'change N lines' do
        skip
      end

      key 'C', 'change to the end of the line (and N-1 more lines)' do
        skip
      end

      key 's', 'change N characters' do
        skip
      end

      key '{visual}c', 'in Visual block mode: Change each of the selected lines with the entered text' do
        skip
      end

      key '{visual}C', 'in Visual block mode: Change each of the selected lines until end-of-line with the entered text' do
        skip
      end

      key '~', 'switch case for N characters and advance cursor' do
        skip
      end

      key '{visual}~', 'switch case for highlighted text' do
        skip
      end

      key '{visual}u', 'make highlighted text lowercase' do
        skip
      end

      key '{visual}U', 'make highlighted text uppercase' do
        skip
      end

      key 'g~{motion}', 'switch case for the text that is moved over with {motion}' do
        skip
      end

      key 'gu{motion}', 'make the text that is moved over with {motion} lowercase' do
        skip
      end

      key 'gU{motion}', 'make the text that is moved over with {motion} uppercase' do
        skip
      end

      key '{visual}g?', 'perform rot13 encoding on highlighted text' do
        skip
      end

      key 'g?{motion}', 'perform rot13 encoding on the text that is moved over with {motion}' do
        skip
      end

      key '<Control-a>', 'add N to the number at or after the cursor' do
        skip
      end

      key '<Control-x>', 'subtract N from the number at or after the cursor' do
        skip
      end

      key '<{motion}', 'move the lines that are moved over with {motion} one shiftwidth left' do
        skip
      end

      key '<<', 'move N lines one shiftwidth left' do
        skip
      end

      key '>{motion}', 'move the lines that are moved over with {motion} one shiftwidth right' do
        skip
      end

      key '>>', 'move N lines one shiftwidth right' do
        skip
      end

      key 'gq{motion}', 'format the lines that are moved over with {motion} to "textwidth" length' do
        skip
      end

      key ':[range]ce[nter] [width]', 'center the lines in [range]' do
        skip
      end

      key ':[range]le[ft] [indent]', 'left-align the lines in [range] (with [indent])' do
        skip
      end

      key ':[range]ri[ght] [width]', 'right-align the lines in [range]' do
        skip
      end
    end
  end
end
