require_relative '../../helper'

shared :key_spec do
  behaves_like :with_buffer

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
  end
end

__END__

    describe 'Control mode Text object motions' do
      behaves_like :key_spec

      it 'goes to next word with <w> and <Shift-Right>' do
        type 'w'
        insert.index.should == '1.10'
        type '<Shift-Right>'
        insert.index.should == '1.23'
      end

      it 'goes to next chunk with <W>' do
        type 'W'
        insert.index.should == '1.10'
      end


      it 'goes to next chunk end with <E>' do
        type 'E'
        insert.index.should == '1.8'
      end

      it 'goes to next word end with <e>' do
        type 'e'
        insert.index.should == '1.8'
      end

      it 'goes to prev chunk with <B>' do
        insert.index = 'end'
        type 'B'
        insert.index.should == '41.29'
      end

      it 'goes to prev line with <k>, <Up>, and <Control-p>' do
        insert.index = 'end'
        type 'k'
        buffer.count('insert', 'end', :displaylines).should == 2
        type '<Up>'
        buffer.count('insert', 'end', :displaylines).should == 3
        type '<Control-p>'
        buffer.count('insert', 'end', :displaylines).should == 4
      end

      it 'goes to prev word with <b> and <Shift-Left>' do
        insert.index = '1.0 lineend'
        type 'b'
        insert.index.should == '1.40'
        type '<Shift-Left>'
        insert.index.should == '1.31'
      end

      it 'goes to start of line with <Home>' do
        insert.index = '1.10'
        type '<Home>'
        insert.index.should == '1.0'
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
