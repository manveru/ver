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

__END__

# Show the buffer to get accurate behaviour
VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
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
