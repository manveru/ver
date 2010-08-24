require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Copying and moving text' do
      behaves_like :destructive_key_spec

      before do
        VER::Clipboard.clear
      end

      key '"{char}', 'use register {char} for the next delete, yank, or put' do
        buffer.register.should == VER::Register['*']
        type '"a'
        buffer.register.should == VER::Register['a']
        type 'yy'
        buffer.register.should == VER::Register['*']
      end

      key ':reg<Return>', 'show the contents of all registers' do
        skip # this is implemented, kinda
      end

      key ':reg {arg}', 'show the contents of registers mentioned in {arg}' do
        type '"ayy'
        type ':reg a<Return>'
        minibuf.messages.last.should == %q("a: "Inventore voluptatibus dolorem assumenda.\n")
      end

      key 'y{motion}', 'yank the text moved over with {motion} into a register' do
        type 'yl'
        VER::Register['*'].value.should == 'I'
        type '"ayl'
        VER::Register['a'].value.should == 'I'
      end

      key '{visual}y', 'yank the highlighted text into a register' do
        type 'vly'
        VER::Register['*'].value.should == 'In'
        type 'vl"ay'
        VER::Register['a'].value.should == 'In'
        type 'Vj"ay'
        VER::Register['a'].value.should == <<-VALUE
Inventore voluptatibus dolorem assumenda.
Voluptates officiis quidem nemo est.
        VALUE
      end

      key 'yy', 'yank N lines into a register' do
        type 'yy'
        VER::Register['*'].value.should == "Inventore voluptatibus dolorem assumenda.\n"
        type '"ayy'
        VER::Register['a'].value.should == "Inventore voluptatibus dolorem assumenda.\n"
        type '"b2yy'
        VER::Register['b'].value.should ==
          "Inventore voluptatibus dolorem assumenda.\nVoluptates officiis quidem nemo est.\n"
      end

      key 'Y', 'yank N lines into a register' do
        type 'Y'
        VER::Register['*'].value.should == "Inventore voluptatibus dolorem assumenda.\n"
        type '"aY'
        VER::Register['a'].value.should == "Inventore voluptatibus dolorem assumenda.\n"
        type '"b2Y'
        VER::Register['b'].value.should ==
          "Inventore voluptatibus dolorem assumenda.\nVoluptates officiis quidem nemo est.\n"
      end

      key 'p', 'put a register after the cursor position (N times)' do
        # let's go with an empty buffer for this one
        buffer.value = ''

        # first we make sure it pastes after insert mark for normal strings.
        VER::Register['a'] = "ad"
        type '0"ap'
        buffer.value.should == <<-VALUE
ad
        VALUE
        insert.index.should == '1.2'

        VER::Register['a'] = "bc"
        type '0"ap'
        buffer.value.should == <<-VALUE
abcd
        VALUE
        insert.index.should == '1.3'

        # then we make sure it pastes at end of line for strings that end with newlines.
        VER::Register['a'] = "ef\n"
        type '0"ap'
        buffer.value.should == <<-VALUE
abcd
ef
        VALUE
        insert.index.should == '2.0'

        VER::Register['a'] = "gh\n"
        type '0"ap'
        buffer.value.should == <<-VALUE
abcd
ef
gh
        VALUE
        insert.index.should == '3.0'


        # and finally try that again with count
        buffer.value = ''
        VER::Register['a'] = "ab"
        type '0"a2p'
        buffer.value.should == <<-VALUE
abab
        VALUE
        insert.index.should == '1.4'

        VER::Register['a'] = "cd"
        type '0"a2p'
        buffer.value.should == <<-VALUE
acdcdbab
        VALUE
        insert.index.should == '1.5'

        VER::Register['a'] = "ef\n"
        type '0"a2p'
        buffer.value.should == <<-VALUE
acdcdbab
ef
ef
        VALUE
        insert.index.should == '3.0'

        VER::Register['a'] = "gh\n"
        type '0"a2p'
        buffer.value.should == <<-VALUE
acdcdbab
ef
ef
gh
gh
        VALUE
        insert.index.should == '5.0'

        VER::Register['a'] = "ij"
        type 'gg$"ap'
        buffer.value.should == <<-VALUE
acdcdbabij
ef
ef
gh
gh
        VALUE

        VER::Register['a'] = "kl"
        type 'ggl"ap'
        buffer.value.should == <<-VALUE
ackldcdbabij
ef
ef
gh
gh
        VALUE
      end

      key 'P', 'put a register before the cursor position (N times)' do
        # let's go with an empty buffer for this one
        buffer.value = ''

        # first we make sure it pastes after insert mark for normal strings.
        VER::Register['a'] = "cd"
        type '0"aP'
        buffer.value.should == <<-VALUE
cd
        VALUE
        insert.index.should == '1.2'

        VER::Register['a'] = "ab"
        type '0"aP'
        buffer.value.should == <<-VALUE
abcd
        VALUE
        insert.index.should == '1.2'

        # then we make sure it pastes at end of line for strings that end with newlines.
        VER::Register['a'] = "ef\n"
        type '0"aP'
        buffer.value.should == <<-VALUE
ef
abcd
        VALUE
        insert.index.should == '1.0'

        VER::Register['a'] = "gh\n"
        type '0"aP'
        buffer.value.should == <<-VALUE
gh
ef
abcd
        VALUE
        insert.index.should == '1.0'


        # and finally try that again with count
        buffer.value = ''
        VER::Register['a'] = "ab"
        type '0"a2P'
        buffer.value.should == <<-VALUE
abab
        VALUE
        insert.index.should == '1.4'

        VER::Register['a'] = "cd"
        type '0"a2P'
        buffer.value.should == <<-VALUE
cdcdabab
        VALUE
        insert.index.should == '1.4'

        VER::Register['a'] = "ef\n"
        type '0"a2P'
        buffer.value.should == <<-VALUE
ef
ef
cdcdabab
        VALUE
        insert.index.should == '1.0'

        VER::Register['a'] = "gh\n"
        type '0"a2P'
        buffer.value.should == <<-VALUE
gh
gh
ef
ef
cdcdabab
        VALUE
        insert.index.should == '1.0'
      end

      key ']p', 'like p, but adjust indent to current line' do
        buffer.value = <<-VALUE.chomp
line one
  line two
        VALUE
        type '1GYj]p2]p'
        buffer.value.should == <<-VALUE
line one
  line two
  line one
  line one
  line one
        VALUE
      end

      key '[p', 'like P, but adjust indent to current line' do
        buffer.value = <<-VALUE.chomp
line one
  line two
        VALUE
        type '1GYj[p2[p'
        buffer.value.should == <<-VALUE
line one
  line one
  line one
  line one
  line two
        VALUE
      end

      key 'gp', 'like p, but leave cursor after the new text' do
        skip # until someone complains
      end

      key 'gP', 'like P, but leave cursor after the new text' do
        skip # until someone complains
      end
    end
  end
end
