require_relative '../../helper'

VER.spec keymap: 'vim', hidden: false do
  VER.plugin :smart_autoindent
  VER.load_plugins

  describe 'VER::Methods::SmartAutoindent' do
    behaves_like :with_buffer

    before do
      buffer.syntax = VER::Syntax.new('Ruby')
      buffer.options.autoindent = true
      buffer.options.shiftwidth = 2
      buffer.value = ''
      buffer.undoer = VER::Undo::Tree.new(buffer)
    end

    describe 'insert indented newline' do
      def check(code)
        code.each_line do |line|
          buffer.insert(:insert, line.chomp.lstrip)
          VER::Methods::Insert.newline(buffer)
        end
        buffer.get('1.0', 'insert linestart').should == code
      end

      it 'indents by simple rules' do
        check(<<-RUBY)
class Foo
  def bar
  end
end
        RUBY
      end

      it 'indents deeper' do
        check(<<-RUBY)
class Foo
  def bar
    if foo
      bar
    else
      foobar
    end
  end
end
        RUBY
      end

      it 'indents with empty lines' do
        check(<<-RUBY)
class Foo
  def bar
    return 1 if foo

    x = foobar * 2
    y = foobar / 2

    # maybe some comment here
    # that should not affect anything

    return x * y
  end
end
        RUBY
      end

      it 'indents partial already' do
        check(<<-RUBY)
class Foo
  def bar
        RUBY
      end

      it 'indents next line at start of buffer' do
        buffer.value = 'class Foo'
        type 'A<Control-m>'
        buffer.value.should == "class Foo\n  \n"
      end

      it 'indents an empty case statement' do
        check(<<-RUBY)
case foo
when bar
when foobar
else
end
        RUBY
      end

      it 'indents a filled case statement' do
        check(<<-RUBY)
case foo
when bar
  stuff
when foobar
  more stuff
else
  other stuff
end
        RUBY
      end

      it 'indents an if/elsif/else statement' do
        check(<<-RUBY)
if 1 == 2
  a
elsif 2 == 3
  b
elsif 4 == 5
  c
else
  d
end
        RUBY
      end

      it 'indents some block structures' do
        check(<<-RUBY)
[1,2,3].each do |element|
  p element
end

[1,2,3].each{|element|
  p element
}

loop do
  puts "Hello, World!"
end

while ok
  puts "I'm fine"
end
        RUBY
      end

      it 'indents begin/rescue/else/end' do
        check(<<-RUBY)
begin
  foo
rescue
  bar
else
  foobar
end
        RUBY
      end

      it 'indents rescue in a method' do
        check(<<-RUBY)
class Foo
  def bar
    some stuff
  rescue => ex
    p ex
  else
    p :ok
  end
end
        RUBY
      end

      it 'indents after a nested block' do
        buffer.value = "module VER\n  if ready\n    work\n  end"
        buffer.insert = '4.0'
        type 'A<Return>next_work'
        buffer.value.should == "module VER\n  if ready\n    work\n  end\n  next_work\n"
      end

      it 'indents nested module/class/method' do
        check(<<-'RUBY')
# the best editor since ed
module VER
  # a module for modules with methods
  module Methods
    # the module handles indentation
    module Indent
      class << self
        # just a newline for fun and profit, and it needs so many specs?
        def insert_newline(text)
          stuff.each do |thing|
            for thang in thing do
              p thang
            end
          end
        end

        # another method to make this look nicer
        def another_method
          stuff
        rescue => exception
          case exception.message
          when 'hi'
            puts "hi there too"
          else
            size = exception.backtrace.inject 0 do |sum, line|
              sum + line.size
            end
            puts("Whoa, an exception with #{size} chars" \
            ", wouldn't you die to know what it was?")
          end
        end
      end
    end
  end
end
        RUBY
      end

      it 'indents a Lisp expression using an increase-only rule' do
        buffer.syntax = VER::Syntax.new('newLisp')
        check(<<-LISP)
(if (= 1 2)
  (+ 1 3))
LISP
      end

      it 'splits at the cursor and undoes the split in one step' do
        buffer.value = "if ready\n  end # done"
        buffer.insert = '2.5'
        type 'i'
        Tk::Event.generate(buffer, '<Return>', when: :now)
        Tk.update
        buffer.value.should == "if ready\nend\n# done\n"
        buffer.at_insert.index.should == '3.0'
        buffer.undo
        buffer.value.should == "if ready\n  end # done\n"
        buffer.redo
        buffer.value.should == "if ready\nend\n# done\n"
      end

      it 'uses the prefix before the cursor and the configured shiftwidth' do
        buffer.options.shiftwidth = 4
        buffer.value = 'items = [1, 2, 3]'
        buffer.insert = '1.9'
        type 'i<Control-j>'
        buffer.value.should == "items = [\n    1, 2, 3]\n"
        buffer.at_insert.index.should == '2.4'
      end

      it 'dedents a tab-indented closer by one shiftwidth' do
        buffer.options.tabstop = 4
        buffer.value = "  if ready\n\tend"
        buffer.insert = '2.1'
        type 'A<Return>'
        buffer.value.should == "  if ready\n  end\n  \n"
        buffer.at_insert.index.should == '3.2'
      end

      it 'indents an open Slate block using the bundled preference' do
        buffer.syntax = VER::Syntax.new('Slate')
        check("[\n  value\n]\n")
      end

      it 'copies existing indentation in a syntax without indentation rules' do
        buffer.syntax = VER::Syntax.new('Plain Text')
        buffer.value = "\t  one two"
        buffer.insert = '1.6'
        type 'i<Return>'
        buffer.value.should == "\t  one\n\t  two\n"
        buffer.at_insert.index.should == '2.3'
      end

      it 'leaves following whitespace intact when autoindent is disabled' do
        buffer.options.autoindent = false
        buffer.value = "  one two"
        buffer.insert = '1.5'
        type 'i<Return>'
        buffer.value.should == "  one\n two\n"
        buffer.at_insert.index.should == '2.0'
      end

      it 'opens above a closing line and below an opening line' do
        buffer.value = "if ready\nend"
        buffer.insert = '2.0'
        type 'O'
        buffer.value.should == "if ready\n  \nend\n"
        buffer.at_insert.index.should == '2.2'
        buffer.undo
        buffer.value.should == "if ready\nend\n"

        type '<Escape>'
        buffer.insert = '1.0'
        type 'o'
        buffer.value.should == "if ready\n  \nend\n"
        buffer.at_insert.index.should == '2.2'
        buffer.minor_mode?(:insert).should.not.be.nil
      end

      it 'opens above the first line without moving its text' do
        buffer.value = "  work"
        buffer.insert = '1.4'
        type 'O'
        buffer.value.should == "  \n  work\n"
        buffer.at_insert.index.should == '1.2'
      end
    end
  end
end
