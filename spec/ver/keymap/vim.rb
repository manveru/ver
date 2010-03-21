require_relative '../../helper'

shared :common_key_spec do
  def keys(*names, desc)
    names.each do |name|
      title = "%-6s\t%s" % [name, desc]
      it(title){ yield(name) }
    end
  end
  alias key keys

  # Currently we skip specs that rely on specific window size or font.
  # Simply add a spec and put `skip` inside as a kind of TODO marker.
  def skip
    'skip spec until we find good way to implement it'.should.not.be.nil
  end
end

shared :key_spec do
  behaves_like :with_buffer
  behaves_like :common_key_spec
end

shared :destructive_key_spec do
  behaves_like :destructive_mode
  behaves_like :common_key_spec
end

# Show the buffer to get accurate behaviour
VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Control mode Left-Right motions' do
      behaves_like :key_spec

      keys 'h', '<BackSpace>', '<Left>', 'go one character left' do |key|
        buffer.insert = '1.5'
        type key
        insert.should == '1.4'
      end

      keys 'l', '<Right>', 'go one character right' do |key|
        type key
        insert.should == '1.1'
      end

      keys '0', '<Home>', 'goes to first character in the line' do |key|
        buffer.insert = '1.5'
        type key
        insert.should == '1.0'
      end

      key '^', 'goes to the first non-blank character in the line' do
        insert.index = '14.5'
        type '^'
        insert.index.should == '14.2'
      end

      keys '$', '<End>', 'goes to last character in the line (N-1 lines lower)' do |key|
        type key
        insert.index.should == '1.41'
        type "4#{key}"
        insert.index.should == '4.31'
        type "4#{key}"
        insert.index.should == '7.29'
      end

      key 'g0', 'to first character in display line' do |key|
        type key
        insert.index.should == '1.0'
      end

      key 'g^', 'to first non-blank character in display line' do
        skip
      end

      key 'g$', 'to last character in display line' do
        skip
      end

      key 'gm', 'to middle of display line' do
        skip
      end

      key '|', 'to column N (default: 1)' do
        type '|'
        insert.index.should == '1.0'
        insert.index = '1.5'
        type '|'
        insert.index.should == '1.0'
        type '5|'
        insert.index.should == '1.5'
      end

      key 'f{char}', 'to Nth occurance of {char} to the right' do
        type 'fe'
        insert.index.should == '1.3'
        type '2fe'
        insert.index.should == '1.28'
      end

      key 'F{char}', 'to Nth occurance of {char to the left' do
        insert.index = '1.0 lineend'
        type 'Fe'
        insert.index.should == '1.36'

        insert.index = '1.0 lineend'
        type '3Fe'
        insert.index.should == '1.8'
      end

      key 't{char}', 'till before Nth occurance of {char} to the right' do
        insert.index = '1.0'
        type 'te'
        insert.index.should == '1.2'

        insert.index = '1.0'
        type '3te'
        insert.index.should == '1.27'
      end

      key 'T{char}', 'till before Nth occurance of {char} to the left' do
        insert.index = '1.0 lineend'
        type 'Te'
        insert.index.should == '1.37'

        insert.index = '1.0 lineend'
        type '3Te'
        insert.index.should == '1.9'
      end

      key ';', 'repeats search for char' do
        type 'fe'
        insert.index.should == '1.3'
        type ';'
        insert.index.should == '1.8'
      end

      key ',,', 'repeats search for char in the opposite direction' do
        insert.index = '1.5'
        type 'fe'
        insert.index.should == '1.8'
        type ',,'
        insert.index.should == '1.3'
      end
    end

    describe 'Control mode Up-Down motions' do
      behaves_like :key_spec

      key 'k', '<Control-p>', '<Up>', 'go up N lines' do |key|
        insert.index = '10.10'
        type key
        insert.index.should == '9.10'
      end

      keys 'j', '<Control-j>', '<Control-n>', '<Down>', 'go down N lines' do |key|
        type key
        insert.index.should == '2.0'
        insert.index = '1.10'
        type key
        insert.index.should == '2.10'
      end

      key '-', 'up N lines, on the first non-blank character' do |key|
        insert.index = 'end'
        type key
        insert.index.should == '40.0'
        type "25#{key}"
        insert.index.should == '15.4'
      end

      key '+', '<Control-m>', '<Return>',
      'go down N lines, on the first non-blank character' do |key|
        type key
        insert.index.should == '2.0'
        type "13#{key}"
        insert.index.should == '15.4'
      end

      key '_', 'go down N-1 lines, on the first non-blank character' do
        insert.index = '2.10'
        type '_'
        insert.index.should == '2.0'
        type '2_'
        insert.index.should == '3.0'
        type '12_'
        insert.index.should == '14.2'
        type '2_'
        insert.index.should == '15.4'
      end

      key 'G', 'goto line N (default: last line), on the first non-blank character' do
        insert.index = '20.0'
        type 'G'
        insert.index.should == '41.0'
        type '2G'
        insert.index.should == '2.0'
        type '15G'
        insert.index.should == '15.4'
      end

      key 'gg', 'goes to line N (default: first line), on the first non-blank character' do
        insert.index = '20.0'
        type 'gg'
        insert.index.should == '1.0'
        type '2gg'
        insert.index.should == '2.0'
        type '015gg'
        insert.index.should == '15.4'
      end

      key 'N%', 'goto line N percentage down in the file. N must be given' do
        type '6%'
        insert.index.should == '3.0'
        type '12%'
        insert.index.should == '5.0'
        type '24%'
        insert.index.should == '10.0'
        type '48%'
        insert.index.should == '20.0'
        type '96%'
        insert.index.should == '40.0'
        type '100%'
        insert.index.should == '41.0'
      end

      keys 'gk', 'g<Up>', 'go up N display lines' do |key|
        skip
      end

      keys 'gj', 'g<Down>', 'go down N display lines' do |key|
        skip
      end
    end

    describe 'Control mode Text object motions' do
      behaves_like :key_spec

      key 'w', 'N words forward' do |key|
        type key
        insert.index.should == '1.10'
        type "20#{key}"
        insert.index.should == '4.28'
      end

      key 'W', 'N blank-separated WORDs forward' do |key|
        type key
        insert.index.should == '1.10'
        type "20#{key}"
        insert.index.should == '5.13'
      end

      key 'e', 'forward to the end of the Nth word' do |key|
        type key
        insert.index.should == '1.0'
      end

      key 'E', 'forward to the end of the Nth blank-separated WORD' do
        type key
        insert.index.should == '1.0'
      end

      key 'b', 'N words backward' do
        insert.index = 'end'
        type key
        insert.index.should == '1.0'
      end

      key 'B', 'N blank-separated WORDs backward' do
        insert.index = 'end'
        type key
        insert.index.should == '1.0'
      end

      key 'ga', 'backward to the end of the Nth word' do
        insert.index = 'end'
        type key
        insert.index.should == '1.0'
      end

      key 'gE', 'backward to the end of the Nth blank-separated WORD' do
        insert.index = 'end'
        type key
        insert.index.should == '1.0'
      end

      key ')', 'N sentences forward' do |key|
        skip
      end

      key '(', 'N sentences backward' do |key|
        skip
      end

      key '}', 'N paragraphs forward' do |key|
        skip
      end

      key '{', 'N paragraphs backward' do |key|
        skip
      end

      key ']]', 'N sections forward, at start of section' do |key|
        skip
      end

      key '[[', 'N sections backward, at start of section' do |key|
        skip
      end

      key '][', 'N sections forward, at end of section' do |key|
        skip
      end

      key '[]', 'N sections backward, at end of section' do |key|
        skip
      end

      key '[(', 'N times back to unclosed "("' do |key|
        skip
      end

      key '[{', 'N times back to unclosed "{"' do |key|
        skip
      end

      key '[m', 'N times back to start of method (for Java)' do |key|
        skip
      end

      key '[M', 'N times back to end of method (for Java)' do |key|
        skip
      end

      key '])', 'N times forward to unclosed ")"' do |key|
        skip
      end

      key ']{', 'N times forward to unclosed "}"' do |key|
        skip
      end

      key ']m', 'N times forward to start of method (for Java)' do |key|
        skip
      end

      key ']M', 'N times forward to end of method (for Java)' do |key|
        skip
      end

      key '[#', 'N times back to unclosed "#if" or "#else"' do |key|
        skip
      end

      key ']#', 'N times forward to unclosed "#else" or "#endif"' do |key|
        skip
      end

      key '[*', 'N times back to start of comment "/*"' do |key|
        skip
      end

      key ']*', 'N times forward to end of comment "*/"' do |key|
        skip
      end
    end

    describe 'Control mode marks and motions' do
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

    describe 'Special keys in Insert mode' do
      behaves_like :destructive_key_spec

      key '<Control-v>', 'insert character literally, or enter decimal byte value' do
        skip
      end

      keys '<Return>', '<Control-m>', '<Control-j>', 'begin new line' do |key|
        skip
      end

      key '<Control-e>', 'insert the character from below the cursor' do
        skip
      end

      key '<Control-y>', 'insert the character from abvoe the cursor' do
        skip
      end

      key '<Control-a>', 'insert previously inserted text' do
        skip
      end

      key '<Control-at>', 'insert previously inserted text and stop Insert mode' do
        skip
      end

      key '<Control-r>', 'nsert the contents of a register' do
        skip
      end

      key '<Control-n>', 'insert next match of identifier before the cursor' do
        skip
      end

      key '<Control-p>', 'insert previous match of identifier before the cursor' do
        skip
      end

      key '<Control-x>', 'complete the word before the cursor in various ways' do
        skip
      end

      key '<BackSpace>', '<Control-h>', 'delete the character before the cursor' do |key|
        skip
      end

      key '<Delete>', 'delete the character under the cursor' do
        skip
      end


      key '<Control-w>', 'delete word before the cursor' do
        skip
      end


      key '<Control-u>', 'delete all entered characters in the current line' do
        skip
      end


      key '<Control-t>', 'insert one shiftwidth of indent in front of the current line' do
        skip
      end


      key '<Control-d>', 'delete one shiftwidth of indent in front of the current line' do
        skip
      end


      key '0<Control-d>', 'delete all indent in the current line' do
        skip
      end


      key '^<Control-d>', 'delete all indent in the current line, restore indent in next line' do
        skip
      end

    end

    describe 'Digraphs' do
      behaves_like :destructive_key_spec

      key '<Control-k>{char1}{char2}', 'enter digraph' do
        skip
      end
    end

    describe 'Deleting text' do
      behaves_like :destructive_key_spec

      keys 'x', '<Delete>', 'delete N characters under and after the cursor' do
        skip
      end

      key 'X', 'delete N characters before the cursor' do
        skip
      end

      key 'd{motion}', 'delete the text that is moved over with {motion}' do
        skip
      end

      key '{visual}d', 'delete the highlighted text' do
        skip
      end

      key 'dd', 'delete N lines' do
        skip
      end

      key 'D', 'delete to the end of line (and N-1 more lines)' do
        skip
      end

      key 'J', 'join N-1 lines (delete <EOL>s)' do
        skip
      end

      key '{visual}J', 'join the highlighted lines' do
        skip
      end

      key 'gJ', 'like J but without inserting spaces' do
        skip
      end

      key '{visual}gJ', 'like {visual}J, but without inserting spaces' do
        skip
      end
    end

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

    describe 'Repeating commands' do
      behaves_like :destructive_key_spec

      key '.', 'repeat last change (with count replaced with N)' do
        skip
      end

      key 'q{a-z}', 'record typed characters into register {a-z}' do
        skip
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
        skip
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
        skip
      end

      key 'gs', 'goto sleep for N seconds' do
        skip
      end
    end

    describe 'Undo/Redo commands' do
      behaves_like :destructive_key_spec

      key 'u', 'undo last N changes' do
        skip
      end

      key '<Control-r>', 'redo last N undone changes' do
        skip
      end

      key 'U', 'restore last changed line' do
        skip
      end
    end

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

    describe 'Control mode changing' do
      behaves_like :destructive_mode

      it 'changes at end of line with <A>' do
        type 'A'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 41
        insert.index.should == '1.0 lineend'
        buffer.minor_mode?(:insert).should != nil
      end

      it 'changes at next char with <a>' do
        type 'a'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 41
        insert.index.should == '1.1'
        buffer.minor_mode?(:insert).should != nil
      end

      it 'changes at home of line with <I>' do
        insert.index = '1.10'
        type 'I'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 41
        insert.index.should == '1.0'
        buffer.minor_mode?(:insert).should != nil
      end

      it 'searches expression forward with <slash>' do
        type '/officiis<Return>'

        # Make sure input is handled correctly.
        # If the MiniBuffer wasn't invoked, we'll have garbage in the Buffer.
        buffer.value.chomp.should == BUFFER_VALUE

        # all matches should be tagged.
        ranges = buffer.tag(VER::Methods::Search::TAG).ranges
        ranges.should == [
          range( '2.11',  '2.19'),
          range('13.15', '13.23'),
          range('18.19', '18.27'),
          range('28.14', '28.22'),
        ]

        # must be at position of first match.
        insert.index.should == ranges.first.first

        # find all successive matches
        ranges.each do |range|
          insert.index.should == range.first
          type 'n'
        end

        # last match, so no movement
        insert.index.should == ranges.last.first

        # go back again through all matches
        ranges.reverse_each do |range|
          insert.index.should == range.first
          type 'N'
        end

        # first match, so no movement
        insert.index.should == ranges.first.first
      end

      it 'removes the search tag with <g><slash>' do
        tag = buffer.tag(VER::Methods::Search::TAG)
        tag.ranges.should.be.empty
        type '/officiis<Return>'
        tag.ranges.should.not.be.empty
        type 'g/'
        tag.ranges.should.be.empty
      end

      it 'searches the next word under the cursor with <asterisk>' do
        insert.index = '1.25'
        type '*'
        insert.index.should == '5.5'
      end
    end

    describe 'Matching brace related' do
      behaves_like :destructive_mode

      it 'goes to matching brace with <percent> (%)' do
        buffer.value = '(Veniam (vitae (ratione (facere))))'
        buffer.insert = '1.0'
        type '<percent>'
        insert.index.should == '1.34'
      end
    end

    describe 'Control mode deletion' do
      behaves_like :destructive_mode

      it 'changes movement with <c> prefix' do
        type 'cl'
        clipboard.should == 'I'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 40
        buffer.minor_mode?(:insert).should != nil
        insert.index.should == '1.0'
      end

      it 'changes to right end of next word with <c><w>' do
        type 'cw'
        clipboard.should == "Inventore"
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 32
        buffer.minor_mode?(:insert).should != nil
        insert.index.should == '1.0'
      end

      it 'changes a line with <c><c>' do
        type 'cc'
        clipboard.should == "Inventore voluptatibus dolorem assumenda.\n"
        buffer.count('1.0', 'end', :lines).should == 40
        buffer.minor_mode?(:insert).should != nil
        insert.index.should == '1.0'
      end

      it 'kills movement with <d> prefix' do
        insert.index = '1.1'
        type 'dl'
        clipboard.should == 'n'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 40
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.1'
      end

      it 'kills a line with <d><d>' do
        type 'dd'
        clipboard.should == "Inventore voluptatibus dolorem assumenda.\n"
        buffer.count('1.0', 'end', :lines).should == 40
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.0'
      end

      it 'changes to end of line with <C>' do
        insert.index = '1.1'
        type 'C'
        clipboard.should == "nventore voluptatibus dolorem assumenda."
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 1
        buffer.minor_mode?(:insert).should != nil
        insert.index.should == '1.1'
      end

      it 'kills to end of line with <D>' do
        insert.index = '1.1'
        type 'D'
        clipboard.should == "nventore voluptatibus dolorem assumenda."
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 1
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.1'
      end

      it 'kills next char with <x>' do
        insert.index = '1.1'
        type 'x'
        clipboard.should == 'n'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 40
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.1'
      end

      it 'kills previous char with <X>' do
        insert.index = '1.1'
        type 'X'
        clipboard.should == 'I'
        buffer.count('1.0 linestart', '1.0 lineend', :displaychars).should == 40
        buffer.minor_mode?(:insert).should == nil
        insert.index.should == '1.0'
      end
    end
  end
end
