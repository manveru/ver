require 'bacon'
Bacon.summary_on_exit

require 'ffi-tk'

require_relative '../../../lib/ver/widget_event'
require_relative '../../../lib/ver/keymap'
require_relative '../../../lib/ver/major_mode'
require_relative '../../../lib/ver/methods/indent'

class SpecText < Tk::Text
  attr_accessor :syntax

  def load_preferences
    true
  end

  def preferences
    eval(File.read("config/preferences/#{syntax}.rb"))
  end
end

# NOTE: do _not_ remove trailing whitespace in this file, it's essential.

describe VER::Methods::Indent do
  describe 'insert indented newline' do
    Indent = VER::Methods::Indent

    def fake_input(text, string)
      string.each_line.with_index do |line, index|
        puts " #{line.lstrip.inspect} ".center(80, '-') if $DEBUG
        Indent.insert_newline(text) unless index == 0
        text.insert :insert, line.chomp.lstrip
        puts text.value.gsub(/^( +)(.*)$/, "\e[41m\\1\e[0m\\2") if $DEBUG
      end
    end

    def check(syntax, code)
      text = SpecText.new
      text.syntax = syntax
      fake_input(text, code)
      if $DEBUG
        puts " <result> ".center(80, '*')
        puts text.value.gsub(/^( +)(.*)$/, "\e[41m\\1\e[0m\\2")
        puts " </result> ".center(80, '*')
        puts " <original> ".center(80, '*')
        puts code.gsub(/^( +)(.*)$/, "\e[41m\\1\e[0m\\2")
        puts " </original> ".center(80, '*')
      end
      text.value.chomp.should == code.chomp
    ensure
      text.destroy
    end

    it 'indents by simple rules' do
      # the end will be ok once next newline is entered
      check(:Ruby, <<-RUBY)
class Foo
  def bar
  end
  end
      RUBY
    end

    it 'indents deeper' do
      check(:Ruby, <<-RUBY)
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
      check(:Ruby, <<-RUBY)
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
      check(:Ruby, <<-RUBY)
class Foo
  def bar
      RUBY
    end

    it 'indents next line at start of buffer' do
      check(:Ruby, <<-RUBY)
class Foo
  
      RUBY
    end

    it 'indents an empty case statement' do
      check(:Ruby, <<-RUBY)
case foo
when bar
when foobar
else
end
      RUBY
    end

    it 'indents a filled case statement' do
      check(:Ruby, <<-RUBY)
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
      # the end will be ok once next newline is entered
      check(:Ruby, <<-RUBY)
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
      # the end will be ok once next newline is entered
      check(:Ruby, <<-RUBY)
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
      # the end will be ok once next newline is entered
      check(:Ruby, <<-RUBY)
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
      # the end will be ok once next newline is entered
      check(:Ruby, <<-RUBY)
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
      # the end will be ok once next newline is entered
      check(:Ruby, <<-RUBY)
module VER
  major_mode :Fundamental do
    stuff do
    end
    
RUBY
    end

    it 'indents nested module/class/method' do
      # the end will be ok once next newline is entered
      check(:Ruby, <<-'RUBY')
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

    it 'indents after a nested block' do
      # the end will be ok once next newline is entered
      check(:newLisp, <<-LISP)
(if (= 1 2)
  (+ 1 3))
LISP
    end
  end
end
