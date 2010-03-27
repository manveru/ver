require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Changing text' do
      # change means: delete text and enter Insert mode
      behaves_like :destructive_key_spec

      key 'r{char}', 'replace N characters with {char}' do
        type 'ra'
        insert.index.should == '1.0'
        buffer.get('insert linestart', 'insert lineend').should ==
          "anventore voluptatibus dolorem assumenda."

        type '5ra'
        insert.index.should == '1.4'
        buffer.get('insert linestart', 'insert lineend').should ==
          "aaaaatore voluptatibus dolorem assumenda."

        # replacing with a number should not influence the numeric argument of
        # the command that follows.
        type 'r3l'
        insert.index.should == '1.5'
        buffer.get('1.0', '3.0').should == <<-VALUE
aaaa3tore voluptatibus dolorem assumenda.
Voluptates officiis quidem nemo est.
        VALUE
      end
      key 'R', 'enter Replace mode (repeat the entered text N times)' do
        type 'R'
        buffer.minor_mode?(:replace).should.not.be.nil
        type 'Adventures are waiting for you'
        buffer.minor_mode?(:replace).should.not.be.nil
        buffer.get('1.0', '1.0 lineend').should ==
          "Adventures are waiting for you assumenda."
        type '<Escape>'
        buffer.minor_mode?(:replace).should.be.nil
        buffer.get('1.0', '1.0 lineend').should ==
          "Adventures are waiting for you assumenda."

        type '03R'
        buffer.minor_mode?(:replace).should.not.be.nil
        type 'go go gadget replacing '
        buffer.minor_mode?(:replace).should.not.be.nil
        buffer.get('1.0', '1.0 lineend').should ==
          "go go gadget replacing for you assumenda."
        type '<Escape>'
        buffer.minor_mode?(:replace).should.be.nil
        buffer.get('1.0', '1.0 lineend').should ==
          "go go gadget replacing go go gadget replacing go go gadget replacing go go gadget replacing for you assumenda."
      end

      key '{visual}r{char}', 'in Visual block mode: Replace each char of the selected text with {char}' do
        type '3l<Control-v>3j5lrx'
        buffer.get('1.0', '6.0').should == <<-VALUE
Invxxxxxx voluptatibus dolorem assumenda.
Volxxxxxxs officiis quidem nemo est.
Quixxxxxxique quia voluptatem.
Sitxxxxxxtur vel aperiam et ab.
Quam dolorem dignissimos perferendis.
        VALUE
      end

      key 'c{motion}', 'change the text that is moved over with {motion}' do
        type '3cl'
        buffer.minor_mode?(:insert).should.not.be.nil
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil
        buffer.get('1.0', '1.0 lineend').should == "entore voluptatibus dolorem assumenda."

        # this is a rabbit-hole, don't fix until it becomes annoying.
        # type 'c3l'
        # buffer.minor_mode?(:insert).should.not.be.nil
        # type '<Escape>'
        # buffer.minor_mode?(:insert).should.be.nil
        # buffer.get('1.0', '1.0 lineend').should == "ore voluptatibus dolorem assumenda."
      end

      key '{visual}c', 'change the highlighted text' do
        type 'v2l3lc'
        buffer.minor_mode?(:insert).should.not.be.nil
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil
        buffer.get('1.0', '2.0').should == "ore voluptatibus dolorem assumenda.\n"
      end

      keys 'cc', 'S', 'change N lines' do |key|
        type "#{key}"
        buffer.minor_mode?(:insert).should.not.be.nil
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil
        insert.index.should == '1.0'
        buffer.get('1.0', '3.0').should == "\nVoluptates officiis quidem nemo est.\n"

        type "3#{key}"
        buffer.minor_mode?(:insert).should.not.be.nil
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil
        insert.index.should == '1.0'
        buffer.get('1.0', '3.0').should == "\nSit pariatur vel aperiam et ab.\n"
      end

      key 'C', 'change to the end of the line (and N-1 more lines)' do |key|
        buffer.insert = '1.5'
        type key
        buffer.minor_mode?(:insert).should.not.be.nil
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil
        insert.index.should == '1.5'
        buffer.get('1.0', '3.0').should == "Inven\nVoluptates officiis quidem nemo est.\n"

        buffer.insert = '2.5'
        type 3, key
        buffer.minor_mode?(:insert).should.not.be.nil
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil
        insert.index.should == '2.5'
        buffer.get('1.0', '4.0').should == "Inven\nVolup\nQuam dolorem dignissimos perferendis.\n"
      end

      key 's', 'change N characters' do |key|
        type key, 'Winds of change: I'
        buffer.minor_mode?(:insert).should.not.be.nil
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil
        buffer.get('1.0', '2.0').should == "Winds of change: Inventore voluptatibus dolorem assumenda.\n"

        type 0, 28, key, 'Winds of change: V'
        buffer.minor_mode?(:insert).should.not.be.nil
        type '<Escape>'
        buffer.minor_mode?(:insert).should.be.nil
        buffer.get('1.0', '2.0').should == "Winds of change: Voluptatibus dolorem assumenda.\n"
      end

      key '{visual}c', 'in Visual block mode: Change each of the selected lines with the entered text' do
        type '3l<Control-v>3j5lcfoo<Return>'
        buffer.get('1.0', '7.0').should == <<-VALUE
Invfoo voluptatibus dolorem assumenda.
Volfoos officiis quidem nemo est.
Quifooique quia voluptatem.
Sitfootur vel aperiam et ab.
Quam dolorem dignissimos perferendis.
Nostrum cumque quaerat nobis ut repudiandae vitae autem perferendis.
        VALUE
      end

      key '{visual}C', 'in Visual block mode: Change each of the selected lines until end-of-line with the entered text' do
        type '3l<Control-v>3j5lCfoo<Return>'
        buffer.get('1.0', '7.0').should == <<-VALUE
Invfoo
Volfoo
Quifoo
Sitfoo
Quam dolorem dignissimos perferendis.
Nostrum cumque quaerat nobis ut repudiandae vitae autem perferendis.
        VALUE
      end

      key '~', 'switch case for N characters and advance cursor' do |key|
        type key
        buffer.get('1.0', '2.0').should == "inventore voluptatibus dolorem assumenda.\n"
        type 8, key
        buffer.get('1.0', '2.0').should == "iNVENTORE voluptatibus dolorem assumenda.\n"
      end

      key '{visual}~', 'switch case for highlighted text' do |key|
        type 'v8l~'
        buffer.get('1.0', '2.0').should == "iNVENTORE voluptatibus dolorem assumenda.\n"
      end

      key '{visual}u', 'make highlighted text lowercase' do
        type 'v8lu'
        buffer.get('1.0', '2.0').should == "inventore voluptatibus dolorem assumenda.\n"
        buffer.minor_mode?(:select_char).should.be.nil
      end

      key '{visual}U', 'make highlighted text uppercase' do
        type 'v8lU'
        buffer.get('1.0', '2.0').should == "INVENTORE voluptatibus dolorem assumenda.\n"
        buffer.minor_mode?(:select_char).should.be.nil
      end

      key 'g~{motion}', 'switch case for the text that is moved over with {motion}' do
        type 'g~j'
        buffer.get('1.0', '3.0').should == <<-VALUE
iNVENTORE VOLUPTATIBUS DOLOREM ASSUMENDA.
Voluptates officiis quidem nemo est.
        VALUE
        buffer.minor_mode?(:select_char).should.be.nil
      end

      key 'gu{motion}', 'make the text that is moved over with {motion} lowercase' do
        type 'guj'
        buffer.get('1.0', '3.0').should == <<-VALUE
inventore voluptatibus dolorem assumenda.
Voluptates officiis quidem nemo est.
        VALUE
        buffer.minor_mode?(:select_char).should.be.nil
      end

      key 'gU{motion}', 'make the text that is moved over with {motion} uppercase' do
        type 'gUj'
        buffer.get('1.0', '3.0').should == <<-VALUE
INVENTORE VOLUPTATIBUS DOLOREM ASSUMENDA.
Voluptates officiis quidem nemo est.
        VALUE
        buffer.minor_mode?(:select_char).should.be.nil
      end

      key '{visual}g?', 'perform rot13 encoding on highlighted text' do
        type 'vjg?'
        buffer.get('1.0', '3.0').should == <<-VALUE
Vairagber ibyhcgngvohf qbyberz nffhzraqn.
Ioluptates officiis quidem nemo est.
        VALUE
        buffer.minor_mode?(:select_char).should.be.nil
      end

      key 'g?{motion}', 'perform rot13 encoding on the text that is moved over with {motion}' do
        type 'g?j'
        buffer.get('1.0', '3.0').should == <<-VALUE
Vairagber ibyhcgngvohf qbyberz nffhzraqn.
Voluptates officiis quidem nemo est.
        VALUE

        # if we were vim, we actually would have this:
        # Vairagber ibyhcgngvohf qbyberz nffhzraqn.
        # Ibyhcgngrf bssvpvvf dhvqrz arzb rfg.
        #
        # need to take another look at how we handle motions spanning lines.

        buffer.minor_mode?(:select_char).should.be.nil
      end

      key '<Control-a>', 'add N to the number at or after the cursor' do |key|
        buffer.value = '0'
        type key
        buffer.value.should == "1\n"
        insert.index.should == '1.3'

        type 100, key
        buffer.value.should == "101\n"
        insert.index.should == '1.3'

        type 999_899, key
        buffer.value.should == "1000000\n"
        insert.index.should == '1.7'
      end

      key '<Control-a>', 'add N to 0xd at or after the cursor' do |key|
        buffer.value = '0x0'
        type key
        buffer.value.should == "0x1\n"
        insert.index.should == '1.3'

        type 100, key
        buffer.value.should == "0x65\n"
        insert.index.should == '1.4'

        type 999_899, key
        buffer.value.should == "0xf4240\n"
        insert.index.should == '1.7'
      end


      key '<Control-a>', 'add N to 0bd at or after the cursor' do |key|
        buffer.value = '0b0'
        type key
        buffer.value.should == "0b1\n"
        insert.index.should == '1.3'

        type 100, key
        buffer.value.should == "0b1100101\n"
        insert.index.should == '1.9'

        type 999_899, key
        buffer.value.should == "0b11110100001001000000\n"
        insert.index.should == '1.22'
      end


      key '<Control-a>', 'add N to ded at or after the cursor' do |key|
        buffer.value = '0e0'
        type key
        buffer.value.should == "1e+00\n"
        insert.index.should == '1.5'

        type 100, key
        buffer.value.should == "1e+02\n"
        insert.index.should == '1.5'

        type 999_899, key
        buffer.value.should == "1e+06\n"
        insert.index.should == '1.5'
      end

      key '<Control-a>', 'add N to d.de+d at or after the cursor' do |key|
        buffer.value = '0.0e0'
        type key
        buffer.value.should == "1.0e+00\n"
        insert.index.should == '1.7'

        type 2e42, key
        buffer.value.should == "4.5e+01\n"
        insert.index.should == '1.7'

        type 2e42, key
        buffer.value.should == "8.9e+01\n"
        insert.index.should == '1.7'
      end

      key '<Control-a>', 'add N to d.d at or after the cursor' do |key|
        buffer.value = '0.0'
        type key
        buffer.value.should == "1.0\n"
        insert.index.should == '1.3'

        type 100, key
        buffer.value.should == "101.0\n"
        insert.index.should == '1.5'

        type 999_899, key
        buffer.value.should == "1000000.0\n"
        insert.index.should == '1.9'
      end

      key '<Control-a>', 'add N to 0d at or after the cursor' do |key|
        buffer.value = '01'
        type key
        buffer.value.should == "02\n"
        insert.index.should == '1.3'

        type 100, key
        buffer.value.should == "0146\n"
        insert.index.should == '1.4'

        type 999_899, key
        buffer.value.should == "03641101\n"
        insert.index.should == '1.8'
      end

      key '<Control-x>', 'substract N from the number at or after the cursor' do |key|
        buffer.value = '0'
        type key
        buffer.value.should == "-1\n"
        insert.index.should == '1.4'

        type 100, key
        buffer.value.should == "-101\n"
        insert.index.should == '1.4'

        type 999_899, key
        buffer.value.should == "-1000000\n"
        insert.index.should == '1.8'
      end

      key '<Control-x>', 'substract N from 0xd at or after the cursor' do |key|
        buffer.value = '0x0'
        type key
        buffer.value.should == "-0x1\n"
        insert.index.should == '1.4'

        type 100, key
        buffer.value.should == "-0x65\n"
        insert.index.should == '1.5'

        type 999_899, key
        buffer.value.should == "-0xf4240\n"
        insert.index.should == '1.8'
      end

      key '<Control-x>', 'substract N from 0bd at or after the cursor' do |key|
        buffer.value = '0b0'
        type key
        buffer.value.should == "-0b1\n"
        insert.index.should == '1.4'

        type 100, key
        buffer.value.should == "-0b1100101\n"
        insert.index.should == '1.10'

        type 999_899, key
        buffer.value.should == "-0b11110100001001000000\n"
        insert.index.should == '1.23'
      end

      key '<Control-x>', 'substract N from ded at or after the cursor' do |key|
        buffer.value = '0e0'
        type key
        buffer.value.should == "-1e+00\n"
        insert.index.should == '1.6'

        type 100, key
        buffer.value.should == "-1e+02\n"
        insert.index.should == '1.6'

        type 999_899, key
        buffer.value.should == "-1e+06\n"
        insert.index.should == '1.6'
      end

      key '<Control-x>', 'substract N from d.de+d at or after the cursor' do |key|
        buffer.value = '0.0e0'
        type key
        buffer.value.should == "-1.0e+00\n"
        insert.index.should == '1.8'

        type 2e42, key
        buffer.value.should == "-4.5e+01\n"
        insert.index.should == '1.8'

        type 2e42, key
        buffer.value.should == "-8.9e+01\n"
        insert.index.should == '1.8'
      end

      key '<Control-x>', 'substract N from d.d at or after the cursor' do |key|
        buffer.value = '0.0'
        type key
        buffer.value.should == "-1.0\n"
        insert.index.should == '1.4'

        type 100, key
        buffer.value.should == "-101.0\n"
        insert.index.should == '1.6'

        type 999_899, key
        buffer.value.should == "-1000000.0\n"
        insert.index.should == '1.10'
      end

      key '<Control-x>', 'substract N from 0d at or after the cursor' do |key|
        buffer.value = '0100'
        type key
        buffer.value.should == "077\n"
        insert.index.should == '1.3'

        buffer.value = '-01'
        type 100, key
        buffer.value.should == "-0145\n"
        insert.index.should == '1.5'

        type 999_899, key
        buffer.value.should == "-03641100\n"
        insert.index.should == '1.9'
      end

      key 'gr{char}', 'replace N characters without affecting layout' do
        skip # obsucre and not that useful, queue
      end

      key 'gR', 'enter virtual Replace mode: Like Replace mode but without affecting layout' do
        skip # obsucre and not that useful, queue
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
  end
end
