require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Control mode various motions motions' do
      behaves_like :key_spec

      key '%', 'find the next brace, bracket, comment, or "#if"/ "#else"/"#endif" in this line and go to its match' do |key|
        skip
      end

      key 'H', 'go to the Nth line in the window, on the first non-blank' do |key|
        skip
      end

      key 'M', 'go to the middle line in the window, on the first non-blank' do |key|
        skip
      end

      key 'L', 'go to the Nth line from the bottom, on the first non-blank' do |key|
        skip
      end

      key 'go', 'go to Nth byte in the buffer' do |key|
        skip
      end

      key ':[range]go[to] [off]', 'go to [off] byte in the buffer' do |key|
        skip
      end
    end
  end
end
