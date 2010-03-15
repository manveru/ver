require_relative '../../helper'

BUFFER_VALUE = <<'VALUE'.freeze
Inventore voluptatibus dolorem assumenda.
Voluptates officiis quidem nemo est.
Qui similique quia voluptatem.
Sit pariatur vel aperiam et ab.
Quam dolorem dignissimos perferendis.
Nostrum cumque quaerat nobis ut repudiandae vitae autem perferendis.
Quasi beatae sunt est et quo.
Et eum qui perferendis excepturi molestias reiciendis.
Sed voluptatum quis eaque vitae sed a et.
Velit earum eius cupiditate saepe blanditiis aspernatur dolorem voluptas.
In quam quo repellat.
Iusto repudiandae delectus omnis ut autem.
Fugiat tempore officiis ab.
Aut culpa accusantium consequatur laboriosam pariatur.
Cum autem explicabo dignissimos nemo.
Omnis vero rerum et in fugiat et eos.
Ipsum commodi beatae maxime deserunt aut.
Maxime earum harum officiis libero laborum.
Aut et porro nam voluptas praesentium quaerat.
Enim blanditiis delectus voluptate aliquid placeat.
Repudiandae quae corrupti quaerat quisquam omnis ratione.
Tempore dicta rem maxime nam aperiam consequatur nobis.
Aut nam omnis ullam.
Quia at quas minima quis.
Numquam dolore similique et autem porro alias asperiores.
Culpa neque qui unde voluptas.
Sed id minus ut consequatur nihil aut itaque dolore.
Alias maiores officiis quasi facilis dolor inventore.
Omnis provident itaque neque.
Rerum vel tenetur qui dicta sit omnis modi aut.
Rerum laudantium et ipsa id natus dolores qui.
Nulla est nihil eius et.
Sint quibusdam est molestiae.
Praesentium non quo omnis aliquam eaque est.
Culpa sunt voluptatem ut dolores porro eius molestias esse.
Nesciunt quo dignissimos debitis illo est omnis maiores.
Sint cupiditate quo id perspiciatis voluptas qui quo.
Suscipit ut incidunt atque animi minus optio esse harum.
Molestiae sint iusto quasi.
Quo delectus ipsa quia iste ullam corporis.
Perferendis ut dolores error voluptatem.
VALUE

shared :with_buffer do
  before do
    create_buffer
    buffer.insert = '1.0'
    buffer.major_mode = VER::MajorMode[:Fundamental]
    @insert = buffer.at_insert
    Tk.update
  end

  def create_buffer
    return if $ver_spec_buffer
    $ver_spec_buffer = VER.layout.create_buffer
    VER.layout.add_buffer(buffer)
    buffer.value = BUFFER_VALUE
  end

  def buffer
    $ver_spec_buffer
  end

  def insert
    @insert
  end

  def reset
    buffer.value = BUFFER_VALUE
  end

  def type(string)
    Tk.update
    buffer.type(string)
    Tk.update
  end

  def minibuf
    buffer.minibuf
  end

  def clipboard
    VER::Clipboard.dwim
  end

  def clipboard_set(string)
    VER::Clipboard.dwim = string
  end
end

shared :destructive_mode do
  behaves_like :with_buffer

  before do
    buffer.value = BUFFER_VALUE
    buffer.insert = '1.0'
    VER::Clipboard.clear
  end
end

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
        buffer.count('1.0', 'end', :lines).should == 41
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
        buffer.count('1.0', 'end', :lines).should == 41
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
