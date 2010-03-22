require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Complex changes' do
      behaves_like :destructive_key_spec

      key '!{motion}{command}<Return>', 'filter the lines that are moved over through {command}' do
        skip
      end

      key '!!{command}<Return>', 'filter N lines through {command}' do
        skip
      end

      key '{visual}!{command}<Return>', 'filter the highlighted lines through {command}' do
        skip
      end

      key '[range]! {command}<Return>', 'filter [range] ines through {command}' do
        skip
      end

      key '={motion}', 'filter the lines that are moved over through "equalprg"' do
        skip
      end

      key '==', 'filter N lines through "equalprg"' do
        skip
      end

      key '{visual}=', 'filter the highlighted lines through "equalprg"' do
        skip
      end

      key ':[range]s[ubstitute]/{pattern}/{string}/[g][c]', 'substitute {pattern} by {string} in [range] lines; with [g], replace all occurences of {pattern}; with [c], confirm each replacement' do
        skip
      end

      key ':[range]s[subsitute] [g][c]', 'repeat previous :s with new range and options' do
        skip
      end

      key '&', 'Repeat :s on current line without options' do
        skip
      end

      key ':[range]ret[ab][!] [tabstop]', 'set "tabstop" to new value and adjust white space accordingly' do
        skip
      end
    end
  end
end
