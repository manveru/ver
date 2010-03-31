require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Repeating commands' do
      behaves_like :destructive_key_spec

      key '.', 'repeat last change (with count replaced with N)' do
        type '3dl', '7.'
        insert.get('linestart', 'lineend').should == "voluptatibus dolorem assumenda."
      end

      key 'q{a-z}', 'record typed characters into register {a-z}' do
        type 'qa', 'iHello <Escape>', 'q'
        type '@a'
        insert.get('linestart', 'lineend').should ==
          "Hello Hello Inventore voluptatibus dolorem assumenda."
      end

      key 'q{A-Z}', 'record typed characters, append to register {a-z}' do
        skip
      end

      key 'q', 'stop recording' do
        skip
      end

      key '@{a-z}', 'execute the contents of register {a-z} (N times)' do
        skip
      end

      key '@@', 'repeat previous @{a-z}' do
        type 'qa', 'iHello <Escape>', 'q'
        type '@a', '@@'
        insert.get('linestart', 'lineend').should ==
          "Hello Hello Hello Inventore voluptatibus dolorem assumenda."
      end

      key ':[range]g[lobal]/{pattern}/[cmd]', 'Execute Ex command [cmd] (default ":p") on the lines within [range] where {pattern} matches.' do
        skip
      end

      key ':[range]g[lobal]!/{pattern}/[cmd]', 'Execute Ex [cmd] (default ":p") on the lines within [range] where {pattern} does NOT match.' do
        skip
      end

      key ':so[urce] {file}', 'Read Ex commands from {file}.' do
        skip
      end

      key ':so[urce]! {file}', 'Eval Ruby code in {file}.' do
        skip
      end

      key ':sl[eep] [sec]', 'do nothing for [sec] seconds' do
        skip # not gonna add it
      end

      key 'gs', 'goto sleep for N seconds' do
        skip # not gonna add it
      end
    end
  end
end
