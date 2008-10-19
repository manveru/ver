require 'lib/ver/cursor'
require 'lib/ver/buffer'
require 'lib/ver/buffer/memory'
require 'bacon'

# Bacon.extend(Bacon::TestUnitOutput)
Bacon.summary_on_exit

=begin
$buffer_content = <<BUFFER.strip
This is a little example.
We will attempt to provide a large variety of buffer strutures in this one.

Like empty lines, or long lines.
Even lines
differing in length vastly, as to achive a better feeling of what we can do with it and how to improve.
BUFFER
=end

$buffer_content = <<EXAMPLE.strip
require 'lib/ver/cursor'
require 'lib/ver/buffer'
require 'lib/ver/buffer/memory'
require 'bacon'

# Bacon.extend(Bacon::TestUnitOutput)
Bacon.summary_on_exit

=begin
EXAMPLE

describe 'Cursor' do
  def new_buffer
    VER::MemoryBuffer.new(:test, $buffer_content.dup)
  end

  def cursor(pos)
    cursor = VER::Cursor.new(new_buffer, pos)
  end

  move, start = :up, 150

  should "debug #{move}" do
    buffer = new_buffer
    cursor = VER::Cursor.new(buffer, start)
    old = start
    puts '', buffer[0..-1], ''

    $buffer_content.count("\n").times do |n|
      puts "= #{n} =".center(80, "=")
      old = cursor.pos
      char = buffer[cursor.pos, 1]
      p :here => char
      buffer[cursor.pos, 1] = 'X' unless char == "\n"
      # buffer[cursor.pos, 1] = 'O' if char == "\n"
      puts '', buffer[0..-1], ''
      cursor.send(move)
      break if cursor.pos == old
    end

    1.should == 1
  end

=begin
  should 'not go up on first line' do
    cursor = cursor(5)
    cursor.up
    cursor.pos.should == 5
  end

  should 'go straight up on second line' do
    cursor = cursor(30)
    cursor.up
    cursor.pos.should == 4
  end

  should 'go up on empty line' do
    cursor = cursor(102)
    cursor.up
    cursor.pos.should == 26
  end

  should 'go up to empty line' do
    cursor = cursor(103)
    cursor.up
    cursor.pos.should == 102
  end

  should 'go up from indented pos to empty line' do
    cursor = cursor(120)
    cursor.up
    cursor.pos.should == 102
  end

  should 'go down on first line' do
    cursor = cursor(4)
    cursor.down
    cursor.pos.should == 30
  end

  should 'go down to empty line' do
    cursor = cursor(26)
    cursor.down
    cursor.pos.should == 102
  end

  should 'go down from empty line' do
    cursor = cursor(102)
    cursor.down
    cursor.pos.should == 103
  end

  should 'go down indented' do
    cursor = cursor(110)
    cursor.down
    cursor.pos.should == 144
  end

  should 'go down to last line' do
    cursor = cursor(139)
    cursor.down
    cursor.pos.should == 149
  end

  should 'not go down from last line' do
    cursor = cursor(200)
    cursor.down
    cursor.pos.should == 200
  end

  should 'go down several lines' do
    cursor = cursor(106)
    cursor.down
    cursor.down
    cursor.pos.should == 150
  end
=end
end
