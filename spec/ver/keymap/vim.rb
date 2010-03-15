require_relative '../../helper'

# Show the buffer to get accurate behaviour
VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Control mode movement' do
      behaves_like :with_buffer

      it 'goes to first column with <0>' do
        buffer.insert = '1.5'
        type '0'
        insert.should == '1.0'
      end

      it 'goes to end of buffer with <G>' do
        type 'G'
        insert.should == 'end - 1 chars'
      end

      it 'goes to last column with <dollar> ($)' do
        type '$'
        insert.should == '1.0 lineend'
      end

      it 'goes to last char on line with <End>' do
        type '<End>'
        insert.should == '1.0 lineend'
      end

      it 'goes to start of buffer with <g><g>' do
        buffer.insert = 'end'
        type 'gg'
        insert.should == '1.0'
      end

      it 'goes to arbitrary line with \d+<g><g>' do
        type '5gg'
        insert.line.should == 5
        type '10gg'
        insert.line.should == 10
        type '015gg'
        insert.line.should == 15
      end

      it 'goes to next char with <l> and <Right>' do
        type 'l'
        insert.should == '1.1'
        type '<Right>'
        insert.should == '1.2'
      end

      it 'goes to prev char with <h> and <Left>' do
        buffer.insert = '1.5'
        type 'h'
        insert.should == '1.4'
        type '<Left>'
        insert.should == '1.3'
      end

      it 'goes to next chunk with <W>' do
        type 'W'
        insert.index.should == '1.10'
      end

      it 'goes to next line with <j>, <Down>, and <Control-n>' do
        type 'j'
        buffer.count('1.0', 'insert', :displaylines).should == 1
        type '<Down>'
        buffer.count('1.0', 'insert', :displaylines).should == 2
        type '<Control-n>'
        buffer.count('1.0', 'insert', :displaylines).should == 3
      end

      # skip this for now
=begin
      it 'goes to next page with <Control-f> and <Next>' do
        type '<Control-f>'
        buffer.count('1.0', 'insert', :displaylines).should == 0
        insert.index = '1.0'
        type '<Next>'
        buffer.count('1.0', 'insert', :displaylines).should == 0
      end
=end

      it 'goes to next word with <w> and <Shift-Right>' do
        type 'w'
        insert.index.should == '1.10'
        type '<Shift-Right>'
        insert.index.should == '1.23'
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

      # we probably should skip that spec...
=begin
      it 'goes to prev page with <Control-b> and <Prior>' do
        insert.index = 'end'
        type '<Control-b>'
        insert.index.should == '42.0'
        insert.index = 'end'
        type '<Prior>'
        insert.index.should == '42.0'
      end
=end

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

      it 'searches char to the right' do
        type 'fm'
        insert.index.should == '1.29'
      end

      it 'searches char to the left' do
        insert.index = '1.0 lineend'
        type 'Fv'
        insert.index.should == '1.10'
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
