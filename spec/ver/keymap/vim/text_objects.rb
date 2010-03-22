require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Text objects (only in Visual mode or after an operator)' do
      behaves_like :key_spec

      key 'aw', 'Select "a word"' do
        skip
      end

      key 'aw', 'Select "a word"' do
        skip
      end

      key 'iw', 'Select "inner word"' do
        skip
      end

      key 'aW', 'Select "a |WORD|"' do
        skip
      end

      key 'iW', 'Select "inner |WORD|"' do
        skip
      end

      key 'as', 'Select "a sentence"' do
        skip
      end

      key 'is', 'Select "inner sentence"' do
        skip
      end

      key 'ap', 'Select "a paragraph"' do
        skip
      end

      key 'ip', 'Select "inner paragraph"' do
        skip
      end

      key 'ab', 'Select "a block" (from "[(" to "])")' do
        skip
      end

      key 'ib', 'Select "inner block" (from "[(" to "])")' do
        skip
      end

      key 'aB', 'Select "a Block" (from "[{" to "]}")' do
        skip
      end

      key 'iB', 'Select "inner Block" (from "[{" to "]}")' do
        skip
      end

      key 'a>', 'Select "a <> block"' do
        skip
      end

      key 'i>', 'Select "inner <> block"' do
        skip
      end

      key 'at', 'Select "a tag block" (from <aaa> to </aaa>)' do
        skip
      end

      key 'it', 'Select "inner tag block" (from <aaa> to </aaa>)' do
        skip
      end

      key "a'" 'Select "a single quoted string"' do
        skip
      end

      key "i'" 'Select "inner single quoted string"' do
        skip
      end

      key 'a"' 'Select "a double quoted string"' do
        skip
      end

      key 'i"' 'Select "inner double quoted string"' do
        skip
      end

      key 'a`', 'Select "a backward quoted string"' do
        skip
      end

      key 'i`', 'Select "inner backward quoted string"' do
        skip
      end
    end
  end
end
