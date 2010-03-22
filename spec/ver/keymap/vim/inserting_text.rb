require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Inserting text' do
      behaves_like :destructive_key_spec

      key 'a', 'append text after the cursor (N times)' do
        skip
      end

      key 'A', 'append text at the end of the line (N times)' do
        skip
      end

      keys 'i', '<Insert>', 'insert text before the cursor (N times)', do |key|
        skip
      end

      key 'I', 'insert text before the first non-blank in the line (N times)' do
        skip
      end

      key 'gI', 'insert text in column 1 (N times)' do
        skip
      end

      key 'o', 'open a new line below the current line, append text (N times)' do
        skip
      end

      key 'O', 'open a new line above the current line, append text (N times)' do
        skip
      end

      # in Visual block mode:
      # |v_b_I|    I	insert the same text in front of all the selected lines
      # |v_b_A|	   A	append the same text after all the selected lines
      #
      # |:startinsert|  :star[tinsert][!]  start Insert mode, append when [!] used
      # |:startreplace| :startr[eplace][!]  start Replace mode, at EOL when [!] used
    end
  end
end
