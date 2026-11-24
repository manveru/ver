require_relative '../../helper'

VER.spec keymap: 'helix', hidden: false do
  describe 'Helix keymap' do
    behaves_like :destructive_mode

    before do
      buffer.value = "alpha beta gamma\nsecond line\nthird line"
      buffer.insert = '1.0'
    end

    def selection
      buffer.at_sel.ranges.map(&:get).join
    end

    def first_line
      buffer.get('1.0', '1.0 lineend')
    end

    def normal_mode?
      !buffer.minor_mode?(:control).nil?
    end

    it 'starts in normal mode and moves with counts, arrows, and goto keys' do
      normal_mode?.should == true
      type '3l<Left>j'
      insert.index.should == '2.2'
      type 'ge'
      insert.index.should == '3.0'
      type '2gg'
      insert.index.should == '2.0'
      type 'kglgh'
      insert.index.should == '1.0'
    end

    it 'only moves with G when given a line number' do
      type 'jvlG'
      insert.index.should == '2.1'
      selection.should == 'se'
      type '<Escape>3G'
      insert.index.should == '3.0'
      type 'gg'
      insert.index.should == '1.0'
    end

    it 'moves to the last character with gl or End and stays on empty lines' do
      buffer.value = "abc\n\ndef"
      buffer.insert = '1.0'
      type 'gld'
      buffer.value.should == "ab\n\ndef\n"
      type 'jgl'
      insert.index.should == '2.0'
      type 'j<End>d'
      buffer.value.should == "ab\n\nde\n"
    end

    it 'enters insert mode and returns to normal with Escape' do
      type 'iX<Return>Y<Escape>'
      buffer.value.should == "X\nYalpha beta gamma\nsecond line\nthird line\n"
      normal_mode?.should == true
      type 'l'
      insert.index.should == '2.2'
    end

    it 'selects a word before deleting it' do
      type 'w'
      selection.should == 'alpha '
      type 'd'
      buffer.value.should == "beta gamma\nsecond line\nthird line\n"
      clipboard.should == 'alpha '
      selection.should.be.empty
    end

    it 'moves right from the last selected character after a word motion' do
      type 'wld'
      first_line.should == 'alpha eta gamma'
    end

    %w[2wd 2ed gl2bd].each do |keys|
      it "deletes only the word reached by #{keys}" do
        type keys
        first_line.should == 'alpha gamma'
      end
    end

    it 'treats non-ASCII letters as part of a word' do
      buffer.value = 'über  東京 fin'
      buffer.insert = '1.0'
      type 'wd'
      buffer.value.should == "東京 fin\n"
    end

    it 'routes Tk key events through the active modes' do
      %w[w c Z <Escape>].each do |key|
        Tk::Event.generate(buffer, key, when: :now)
        Tk.update
      end
      first_line.should == 'Zbeta gamma'
      normal_mode?.should == true
    end

    it 'keeps the selected word when entering extend mode' do
      type 'evll'
      selection.should == 'alpha b'
      type '<Escape>'
      normal_mode?.should == true
      selection.should == 'alpha b'
      type ';'
      selection.should.be.empty
      insert.index.should == '1.6'
    end

    it 'can extend left and then shrink the same selection' do
      type '3lvhh'
      selection.should == 'lph'
      type 'l'
      selection.should == 'ph'
    end

    it 'returns to normal mode after deleting so the next motion moves the cursor' do
      type 'vwd'
      normal_mode?.should == true
      type 'ld'
      first_line.should == 'bta gamma'
    end

    it 'returns to normal mode after yanking or replacing from the register' do
      type 'vlly'
      normal_mode?.should == true
      selection.should == 'alp'
      clipboard_set('Z')
      type 'ggvllR'
      normal_mode?.should == true
      first_line.should == 'Zha beta gamma'
    end

    it 'finds characters across lines and can stop before a match' do
      type 'ts'
      selection.should == "alpha beta gamma\n"
      type 'fs'
      selection.should == "\ns"
      type 'Fa'
      selection.should == "a\ns"
    end

    it 'finds or stops before a newline with Return and keypad Enter' do
      buffer.value = "abc\ndef"
      buffer.insert = '1.0'
      type 'f<Return>'
      selection.should == "abc\n"
      type 'ggt<KP_Enter>'
      selection.should == 'abc'
    end

    it 'skips an adjacent match when repeating a till motion' do
      buffer.value = 'ab-c-d'
      buffer.insert = '1.0'
      type 't-t-d'
      buffer.value.should == "a-d\n"
    end

    it 'changes text inside double quotes without removing the quotes' do
      buffer.value = 'say "old" now'
      buffer.insert = '1.0'
      type '6lmi"'
      selection.should == 'old'
      type 'cnew<Escape>'
      buffer.value.should == "say \"new\" now\n"
    end

    it 'changes text around double quotes including the quotes' do
      buffer.value = 'say "old" now'
      buffer.insert = '1.0'
      type '6lma"'
      selection.should == '"old"'
      type 'cnew<Escape>'
      buffer.value.should == "say new now\n"
    end

    it 'uses the nearest literal quotes on either side of the cursor' do
      buffer.value = 'say "old\"quote" now'
      buffer.insert = '1.0'
      type '6lmi"cnew<Escape>'
      buffer.value.should == "say \"new\"quote\" now\n"

      buffer.value = 'say "one" and "two" now'
      buffer.insert = '1.0'
      type '10lmi"cnew<Escape>'
      buffer.value.should == "say \"one\"new\"two\" now\n"
    end

    it 'keeps the selection if the quote under the cursor has no partner' do
      buffer.value = 'say "old now'
      buffer.insert = '1.0'
      type '3lvlmi"'
      selection.should == ' "'
      insert.index.should == '1.4'
    end

    it 'selects from either quote and skips escaped quotes inside the pair' do
      buffer.value = 'say "old\"quote" now'
      buffer.insert = '1.4'
      type 'mi"'
      selection.should == 'old\"quote'
      buffer.insert = '1.15'
      type 'mi"'
      selection.should == 'old\"quote'
    end

    it 'uses the count when looking for both quotes' do
      buffer.value = 'say "one" and "two" now'
      buffer.insert = '1.0'
      type '10l2mi"'
      selection.should == 'one" and "two'
    end

    it 'also selects inside single quotes and backticks' do
      buffer.value = "say 'old' and `other`"
      buffer.insert = '1.6'
      type "mi'"
      selection.should == 'old'
      buffer.insert = '1.16'
      type 'mi`'
      selection.should == 'other'
    end

    it 'distinguishes a punctuation word from a whitespace-delimited WORD' do
      buffer.value = 'a foo-bar z'
      buffer.insert = '1.0'
      type '5lmiw'
      selection.should == '-'
      type 'miW'
      selection.should == 'foo-bar'
    end

    it 'includes trailing whitespace when selecting around a word' do
      buffer.value = 'a foo bar'
      buffer.insert = '1.0'
      type '3lmawcX<Escape>'
      buffer.value.should == "a Xbar\n"
    end

    it 'selects counted paragraphs without the final separator line' do
      buffer.value = "first\nsecond\n\nthird\nfourth\n\nlast"
      buffer.insert = '1.0'
      type 'j2mip'
      selection.should == "first\nsecond\n\nthird\nfourth\n"
      type 'd'
      buffer.value.should == "\nlast\n"
    end

    it 'includes the separator when selecting around a paragraph' do
      buffer.value = "first\nsecond\n\nthird"
      buffer.insert = '1.0'
      type 'jmapd'
      buffer.value.should == "third\n"
    end

    it 'can select a paragraph from a separator line or trailing blank lines' do
      buffer.value = "first\nsecond\n\nthird\nfourth\n\nlast"
      buffer.insert = '1.0'
      type '2jmipd'
      buffer.value.should == "first\nsecond\n\n\nlast\n"

      buffer.value = "first\nsecond\n\nthird\n\n"
      buffer.insert = '1.0'
      type '5jmipd'
      buffer.value.should == "\n\n"
    end

    it 'selects the enclosing pair of the specified brackets' do
      buffer.value = 'foo(bar(baz) end)'
      buffer.insert = '1.0'
      type '9lmi)cX<Escape>'
      buffer.value.should == "foo(bar(X) end)\n"
    end

    it 'counts the bracket under the cursor when selecting outer pairs' do
      buffer.value = '((a))'
      buffer.insert = '1.0'
      type 'l2mi('
      selection.should == '(a)'
      buffer.insert = '1.3'
      type '2mi)'
      selection.should == '(a)'
    end

    it 'can expand from the nearest bracket pair to a surrounding pair' do
      buffer.value = 'foo([baz] end)'
      buffer.insert = '1.0'
      type '6lmam'
      selection.should == '[baz]'
      type 'mam'
      selection.should == '([baz] end)'
      type 'cX<Escape>'
      buffer.value.should == "fooX\n"
    end

    it 'selects the nearest bracket pair from either delimiter' do
      buffer.value = 'f((a))'
      buffer.insert = '1.2'
      type 'mim'
      selection.should == 'a'
      buffer.insert = '1.4'
      type 'mim'
      selection.should == 'a'
    end

    it 'ignores angle brackets in closest-pair scans but permits them explicitly' do
      buffer.value = 'if (a < b) { x -> y }'
      buffer.insert = '1.13'
      type 'mim'
      selection.should == ' x -> y '

      buffer.value = '<tag>'
      buffer.insert = '1.2'
      type 'mi<less>'
      selection.should == 'tag'
    end

    it 'can use a custom character as a delimiter' do
      buffer.value = 'a |foo| b'
      buffer.insert = '1.0'
      type '5lmi|cX<Escape>'
      buffer.value.should == "a |X| b\n"
    end

    it 'can cancel the text object prompt and use another command' do
      type 'mi<Escape>ed'
      buffer.value.should == " beta gamma\nsecond line\nthird line\n"
    end

    it 'selects complete lines with x and extends with another x' do
      type 'xx'
      selection.should == "alpha beta gamma\nsecond line\n"
      type 'd'
      clipboard.should == "alpha beta gamma\nsecond line\n"
      buffer.value.should == "third line\n"
    end

    it 'changes the selection in insert mode' do
      type 'ecALPHA<Escape>'
      buffer.value.should == "ALPHA beta gamma\nsecond line\nthird line\n"
      clipboard.should == 'alpha'
      normal_mode?.should == true
    end

    it 'changes whole lines into one line and undoes the edit in one step' do
      buffer.value = "one\ntwo\nthree"
      buffer.insert = '1.0'
      buffer.undoer = VER::Undo::Tree.new(buffer)
      type '2xcX<Escape>'
      buffer.value.should == "X\nthree\n"
      type 'u'
      buffer.value.should == "one\ntwo\nthree\n"
    end

    it 'deletes the last line without leaving an empty line' do
      buffer.value = "one\ntwo"
      buffer.insert = '1.0'
      type 'gexd'
      buffer.value.should == "one\n"
      clipboard.should == "two\n"
    end

    it 'can delete a selection without changing the register' do
      clipboard_set('keep')
      type 'w<Alt-d>'
      clipboard.should == 'keep'
      first_line.should == 'beta gamma'
    end

    it 'consumes a named register on delete or change without yanking' do
      VER::Register['a'].value = 'named'
      clipboard_set('clipboard')
      type '"a<Alt-d>'
      clipboard.should == 'clipboard'
      type 'y'
      clipboard.should == 'l'
      type '"a<Alt-c><Escape>y'
      clipboard.should == 'p'
      VER::Register['a'].value.should == 'named'
    end

    it 'yanks a selection and pastes after it' do
      type 'ey'
      clipboard.should == 'alpha'
      selection.should == 'alpha'
      type 'p'
      first_line.should == 'alphaalpha beta gamma'
      selection.should == 'alpha'
    end

    it 'pastes linewise text after the last selected line' do
      type 'xygep'
      buffer.value.should == "alpha beta gamma\nsecond line\nthird line\nalpha beta gamma\n"
    end

    it 'leaves the original selection and exits select mode after pasting' do
      buffer.value = 'abcde'
      buffer.insert = '1.0'
      type 'yvllp'
      buffer.value.should == "abcade\n"
      normal_mode?.should == true
      selection.should == 'abc'
      type 'ld'
      buffer.value.should == "abcde\n"
    end

    it 'undoes only the most recent paste' do
      buffer.value = 'abc'
      buffer.insert = '1.0'
      buffer.undoer = VER::Undo::Tree.new(buffer)
      type 'yppu'
      buffer.value.should == "aabc\n"
    end

    it 'inserts before or appends after the selection' do
      type 'eiX<Escape>lea'
      buffer.minor_mode?(:insert).should.not.be.nil
      type 'Y<Escape>'
      first_line.should == 'XalphaY beta gamma'
    end

    it 'keeps the selection and appended text together on leaving insert mode' do
      buffer.value = 'abc'
      buffer.insert = '1.0'
      type 'aX<Escape>'
      selection.should == 'aX'
      type 'd'
      buffer.value.should == "bc\n"
    end

    it 'opens a line below or above the selection' do
      type 'xxoBelow<Escape>OAbove<Escape>'
      buffer.value.should == "alpha beta gamma\nsecond line\nAbove\nBelow\nthird line\n"
    end

    it 'replaces each selected character with r' do
      type 'erZ'
      first_line.should == 'ZZZZZ beta gamma'
      selection.should == 'ZZZZZ'
    end

    it 'replaces a character with a newline using Return' do
      buffer.value = 'axb'
      buffer.insert = '1.0'
      type 'lr<Return>'
      buffer.value.should == "a\nb\n"
    end

    it 'replaces whole graphemes and editable line breaks' do
      buffer.value = "a\u0301b\ncd\nef"
      buffer.insert = '1.0'
      type 'rX'
      buffer.value.should == "Xb\ncd\nef\n"
      type '2xrY'
      buffer.value.should == "YYYYYYef\n"
    end

    it 'uses Tab literally and ignores Backspace as a replacement character' do
      buffer.value = 'abc'
      buffer.insert = '1.0'
      type 'r<BackSpace>r<Tab>'
      buffer.value.should == "\tbc\n"
    end

    it 'selects the entire buffer with percent' do
      type '%'
      selection.should == buffer.value
    end

    it 'selects search results and wraps when repeating a search' do
      buffer.value = 'one two one'
      buffer.insert = '1.0'
      type '/one<Return>'
      selection.should == 'one'
      insert.index.should == '1.10'
      type 'n'
      insert.index.should == '1.2'
      type 'N'
      insert.index.should == '1.10'
    end

    it 'selects adjacent regex matches individually' do
      buffer.value = 'aaa'
      buffer.insert = '1.0'
      type '/a<Return>'
      selection.should == 'a'
      insert.index.should == '1.1'
      type 'n'
      insert.index.should == '1.2'
    end

    it 'searches backward before the current selection and repeats forward with n' do
      buffer.value = 'one two one two one'
      buffer.insert = '1.0'
      type 'gl?one<Return>nd'
      buffer.value.should == "one two one two \n"
    end

    it 'undoes and redoes a selection edit' do
      buffer.undoer = VER::Undo::Tree.new(buffer)
      type 'wd'
      type 'u'
      first_line.should == 'alpha beta gamma'
      type 'U'
      first_line.should == 'beta gamma'
    end

    it 'undoes deleting the whole buffer without adding a final newline' do
      buffer.undoer = VER::Undo::Tree.new(buffer)
      original = buffer.value
      type '%d'
      buffer.value.should == "\n"
      type 'u'
      buffer.value.should == original
    end

    it 'keeps edits on both sides of a cursor move in the same insert undo group' do
      buffer.value = 'abc'
      buffer.insert = '1.0'
      buffer.undoer = VER::Undo::Tree.new(buffer)
      type 'iX<Right>Y<Escape>u'
      buffer.value.should == "abc\n"
      type 'U'
      buffer.value.should == "XaYbc\n"
    end

    it 'opens the command prompt and cancels back to normal mode' do
      type ':'
      minibuf.asking.should.be.true
      type '<Escape>'
      minibuf.asking.should.be.false
      normal_mode?.should == true
    end

    it 'opens and dismisses the file picker with Space f and Escape' do
      Dir.mktmpdir do |directory|
        buffer.project_root = Pathname(directory)
        buffer.project_root.join('helix.txt').write('example')
        type '<space>f'
        picker = Tk.pathname_to_widget(Tk::Focus.focus)
        Tk::Event.generate(picker, '<Escape>', when: :now)
        Tk.update
        picker.is_a?(VER::Executor::ExFuzzyFileFinder).should.be.true
        Tk.pathname_to_widget(Tk::Focus.focus).equal?(buffer).should.be.true
      ensure
        buffer.project_root = nil
      end
    end

    it 'writes the current buffer with the write command' do
      Dir.mktmpdir do |directory|
        path = Pathname(directory) / 'helix.txt'
        path.write("original\n")
        buffer.options.auto_chdir = false
        buffer.open(path)
        type 'iX<Escape>:w<Return>'
        path.read.should == "Xoriginal\n"
      end
    end
  end
end
