require_relative '../../helper'

content = <<CONTENT
line one
  line two
    line three
CONTENT

before = lambda{
  @buffer = VER::Buffer.new(VER.layout)
  @buffer.value = content
  @insert = @buffer.at_insert
}
after = lambda{ @buffer.destroy }

VER.spec do
  describe 'VER::Buffer::Insert' do
    before(&before)
    after(&after)

    it 'goes to previous char' do
      @insert.index = '1.6'
      @insert.prev_char
      @insert.should == '1.5'
      @insert.prev_char(2)
      @insert.should == '1.3'
    end

    it 'goes to next char' do
      @insert.index = '1.0'
      @insert.next_char
      @insert.should == '1.1'
      @insert.next_char(2)
      @insert.should == '1.3'
    end

    it 'goes to start of line' do
      @insert.index = '2.7'
      @insert.start_of_line
      @insert.should == '2.0'
    end

    it 'goes to home of line' do
      @insert.index = '2.7'
      @insert.home_of_line
      @insert.should == '2.2'
    end

    it 'goes to end of line' do
      @insert.index = '2.7'
      @insert.last_char
      @insert.should == '2.10'
    end

    it 'goes to line' do
      @insert.index = '1.1'
      @insert.first_line(2)
      @insert.index.should == '2.2'
    end

    it 'goes to char' do
      @insert.index = '1.0'
      @insert.go_char(1)
      @insert.should == '1.1'
    end

    it 'goes to start of buffer' do
      @insert.index = '2.2'
      @insert.start_of_buffer
      @insert.should == '1.0'
    end

    it 'goes to next word' do
      @buffer.value = "one line"
      @insert.index = '1.0'
      @insert.next_word
      @insert.should == '1.4'
      @insert.next_word
      @insert.should == '1.8'
    end

    it 'goes to previous word' do
      @buffer.value = "one line"
      @insert.index = '1.8'
      @insert.prev_word
      @insert.should == '1.4'
      @insert.prev_word
      @insert.should == '1.0'
    end

    it 'goes to next chunk' do
      @buffer.value = "'one' 'line'"
      @insert.index = '1.0'
      @insert.next_chunk
      @insert.should == '1.6'
      @insert.next_chunk
      @insert.should == '1.12'
    end

    it 'goes to previous chunk' do
      @buffer.value = "'one' 'line'"
      @insert.index = '1.12'
      @insert.prev_chunk
      @insert.should == '1.6'
      @insert.prev_chunk
      @insert.should == '1.0'
    end

    it 'inserts tab' do
      @insert.index = '2.2'
      @insert.insert_tab
      @insert.should == '2.3'
      @insert.get('- 1 chars').should == "\t"
    end

    it 'inserts newline without autoindent' do
      @buffer.options.autoindent = false
      @insert.index = '2.6'
      @insert.insert_newline
      @insert.should == '3.0'
      @insert.get('- 1 lines linestart', '- 1 lines lineend').should == "  line"
      @insert.get('linestart', 'lineend').should == " two"
    end

    it 'inserts newline with autoindent at lineend' do
      @buffer.options.autoindent = true
      @insert.index = '2.0 lineend'
      @insert.insert_newline
      @insert.should == '3.2'
      @insert.get('- 1 lines linestart', '- 1 lines lineend').should == "  line two"
      @insert.get('linestart', 'lineend').should == "  "
    end

    it 'inserts newline with autoindent within line' do
      @buffer.options.autoindent = true
      @insert.index = '2.6'
      @insert.insert_newline
      @insert.should == '3.2'
      @insert.get('- 1 lines linestart', '- 1 lines lineend').should == "  line"
      @insert.get('linestart', 'lineend').should == "  two"
    end

    it 'inserts newline below without autoindent' do
      @buffer.options.autoindent = false
      @insert.index = '2.6'
      @insert.insert_newline_below
      @insert.should == '3.2'
      @insert.get('- 1 lines linestart', '- 1 lines lineend').should == "  line two"
      @insert.get('linestart', 'lineend').should == ""
      @buffer.minor_mode?(:insert).should.not.be.nil
    end

    it 'inserts newline below with autoindent' do
      @buffer.options.autoindent = true
      @insert.index = '2.6'
      @insert.insert_newline_below
      @insert.should == '3.2'
      @insert.get('- 1 lines linestart', '- 1 lines lineend').should == "  line two"
      @insert.get('linestart', 'lineend').should == "  "
      @buffer.minor_mode?(:insert).should.not.be.nil
    end

    it 'inserts newline above with autoindent at buffer start' do
      @buffer.options.autoindent = true
      @insert.index = '1.1'
      @insert.insert_newline_above
      @insert.index.should == '1.0'
      @insert.get('+ 1 lines linestart', '+ 1 lines lineend').should == "line one"
      @insert.get('linestart', 'lineend').should == ""
      @buffer.minor_mode?(:insert).should.not.be.nil
    end

    it 'inserts newline above without autoindent at buffer start' do
      @buffer.options.autoindent = false
      @insert.index = '1.1'
      @insert.insert_newline_above
      @insert.index.should == '1.0'
      @insert.get('+ 1 lines linestart', '+ 1 lines lineend').should == "line one"
      @insert.get('linestart', 'lineend').should == ""
      @buffer.minor_mode?(:insert).should.not.be.nil
    end

    it 'inserts newline above with autoindent from line two' do
      @buffer.options.autoindent = false
      @insert.index = '2.1'
      @insert.insert_newline_above
      @insert.index.should == '2.0'
      @insert.get('+ 1 lines linestart', '+ 1 lines lineend').should == "  line two"
      @insert.get('linestart', 'lineend').should == ""
      @buffer.minor_mode?(:insert).should.not.be.nil
    end

    it 'deletes previous char using virtual movement' do
      @insert.index = '1.1'
      @insert.virtual(&:prev_char).delete
      @insert.get('linestart', 'lineend').should == "ine one"
    end

    it 'deletes next char using virtual movement' do
      @insert.index = '1.1'
      @insert.virtual(&:next_char).delete
      @insert.get('linestart', 'lineend').should == "lne one"
    end

    it 'deletes next char using virtual movement with argument' do
      @insert.index = '1.1'
      @insert.virtual(2, &:next_char).delete
      @insert.get('linestart', 'lineend').should == "le one"
    end

    it 'jumps to matching brace in (foo)' do
      @buffer.value = "(foo)"
      @insert.index = '1.0' # -> (foo

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == ')'
      @insert.should == '1.4' # foo) <-

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '(foo)'
      @insert.should == '1.0' # -> (foo
    end

    it 'jumps to matching braces in (foo (bar))' do
      @buffer.value = "(foo (bar))"
      @insert.index = '1.0' # -> (foo

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == ')'
      @insert.should == '1.10' # bar)) <-

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '(foo (bar))'
      @insert.should == '1.0' # -> (foo

      @insert.index = '1.5' # (bar
      @buffer.get('insert', 'insert lineend').should == '(bar))'

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '))'
      @insert.should == '1.9' # bar) <-

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '(bar))'
      @insert.should == '1.5' # -> (bar
    end

    it 'jumps to matching braces in (a (b (c (d))))' do
      @buffer.value = "(a (b (c (d))))"
      @insert.index = '1.0'
      @buffer.get('insert', 'insert lineend').should == '(a (b (c (d))))'


      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == ')'
      @insert.should == '1.14'

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '(a (b (c (d))))'
      @insert.should == '1.0'


      @insert.index = '1.3'
      @buffer.get('insert', 'insert lineend').should == '(b (c (d))))'

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '))'
      @insert.should == '1.13'

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '(b (c (d))))'
      @insert.should == '1.3'


      @insert.index = '1.6'
      @buffer.get('insert', 'insert lineend').should == '(c (d))))'

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == ')))'
      @insert.should == '1.12'

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '(c (d))))'
      @insert.should == '1.6'


      @insert.index = '1.9'
      @buffer.get('insert', 'insert lineend').should == '(d))))'

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '))))'
      @insert.should == '1.11'

      @insert.matching_brace
      @buffer.get('insert', 'insert lineend').should == '(d))))'
      @insert.should == '1.9'
    end
  end
end
