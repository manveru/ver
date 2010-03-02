require_relative '../../../lib/ver/vendor/eval_completer'
require 'bacon'
Bacon.summary_at_exit

describe 'VER::EvalCompleter' do
  def complete(input, *args)
    VER::EvalCompleter.complete(input, *args).sort
  end

  it 'completes Symbol name' do
    complete(':syml').should == %w[:symlink :symlink?].sort
  end

  it 'completes Symbol methods' do
    complete(':sym.id2').should == %w[:sym.id2name]
  end

  it 'completes Array methods' do
    complete('[1,2].tra').should == %w[[1,2].transpose]
  end

  it 'completes Regexp methods' do
    complete('/foo/.ca').should == %w[/foo/.casefold?]
  end

  it 'completes Bacon methods' do
    complete('Bacon.su').should == %w[
      Bacon.summary_at_exit
      Bacon.summary_on_exit
    ]
  end

  it 'completes local variables' do
    my_var = nil
    complete('my', binding).should == %w[my_var]
  end

  it 'completes local variable methods' do
    my_var = []
    complete('my_var.map.trans', binding).should == %w[my_var.map.transpose]
  end

  it 'completes Proc method' do
    complete('proc{}.ca').should == %w[proc{}.call]
  end

  it 'completes Hash method' do
    complete('{a: :b}.sort_').should == ['{a: :b}.sort_by']
  end

  it 'completes absolute constant' do
    complete('::K').should == %w[::Kernel ::KeyError]
  end

  it 'completes constant' do
    complete('Enumerator::G').should == %w[Enumerator::Generator]
  end

  it 'completes class method' do
    complete('Encoding.ali').should == %w[Encoding.aliases]
  end

  it 'completes nested class method' do
    complete('Encoding::UTF_8.dum').should == %w[Encoding::UTF_8.dummy?]
  end

  it 'completes numeric method' do
    complete('0d1.ch').should == %w[0d1.chr]
    complete('0b1.ch').should == %w[0b1.chr]
    complete('0o1.ch').should == %w[0o1.chr]
    complete('1.5.fin').should == %w[1.5.finite?]
    complete('5e1.fin').should == %w[5e1.finite?]
    complete('5E1.fin').should == %w[5E1.finite?]
  end

  it 'completes hex-numeric method' do
    complete('0xf.ch').should == %w[0xf.chr]
  end

  it 'completes global variables' do
    complete('$V').should == %w[$VERBOSE]
    $CRAZY_SPEC_VARIABLE = nil
    complete('$CRAZY').should == %w[$CRAZY_SPEC_VARIABLE]
  end
end

# if Readline.respond_to?("basic_word_break_characters=")
#   Readline.basic_word_break_characters= " \t\n\"\\'`><=;|&{("
# end
# Readline.completion_append_character = nil
# Readline.completion_proc = IRB::InputCompletor::CompletionProc
