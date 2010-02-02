require_relative '../../helper'

VER.spec do
  describe VER::Methods::Move do
    text = VER.buffers.values.first.text
    text.delete('1.0', 'end')
    text.insert('end', "First line\nSecond line\nThird line")

    it 'moves to start of buffer' do
      text.index(:insert).should == text.index('3.10')
      VER::Methods::Move.start_of_text(text)
      text.index(:insert).should == text.index('1.0')
    end

    it 'moves to next line' do
      VER::Methods::Move.next_line(text)
      text.index(:insert).should == text.index('1.0 + 1 displaylines')
    end

    it 'moves to previous line' do
      VER::Methods::Move.prev_line(text)
      text.index(:insert).should == text.index('1.0')
    end

    it 'moves to next char' do
      VER::Methods::Move.next_char(text)
      text.index(:insert).should == text.index('1.1')
    end

    it 'moves to prev char' do
      VER::Methods::Move.prev_char(text)
      text.index(:insert).should == text.index('1.0')
    end

    it 'moves to next word' do
      text.value = 'one two'
      text.mark_set(:insert, '1.0')
      text.get('insert', 'insert lineend').should == 'one two'

      VER::Methods::Move.next_word(text)
      text.get('insert', 'insert lineend').should == 'two'

      VER::Methods::Move.next_word(text)
      text.get('insert', 'insert lineend').should == ''
    end

    it 'moves to previous word' do
      text.value = 'one two'
      text.mark_set(:insert, 'end')
      text.get('insert', 'insert lineend').should == ''

      VER::Methods::Move.prev_word(text)
      text.get('insert', 'insert lineend').should == 'two'

      VER::Methods::Move.prev_word(text)
      text.get('insert', 'insert lineend').should == 'one two'

      VER::Methods::Move.prev_word(text)
      text.get('insert', 'insert lineend').should == 'one two'
    end

    it 'jumps to matching brace in (foo)' do
      text.value = "(foo)"
      text.mark_set(:insert, '1.0') # -> (foo

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == ')'
      text.index(:insert).should == text.index('1.4') # foo) <-

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '(foo)'
      text.index(:insert).should == text.index('1.0') # -> (foo
    end

    it 'jumps to matching braces in (foo (bar))' do
      text.value = "(foo (bar))"
      text.mark_set(:insert, '1.0') # -> (foo

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == ')'
      text.index(:insert).should == text.index('1.10') # bar)) <-

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '(foo (bar))'
      text.index(:insert).should == text.index('1.0') # -> (foo

      text.mark_set(:insert, '1.5') # (bar
      text.get('insert', 'insert lineend').should == '(bar))'

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '))'
      text.index(:insert).should == text.index('1.9') # bar) <-

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '(bar))'
      text.index(:insert).should == text.index('1.5') # -> (bar
    end

    it 'jumps to matching braces in (a (b (c (d))))' do
      text.value = "(a (b (c (d))))"
      text.mark_set(:insert, '1.0')
      text.get('insert', 'insert lineend').should == '(a (b (c (d))))'


      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == ')'
      text.index(:insert).should == text.index('1.14')

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '(a (b (c (d))))'
      text.index(:insert).should == text.index('1.0')


      text.mark_set(:insert, '1.3')
      text.get('insert', 'insert lineend').should == '(b (c (d))))'

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '))'
      text.index(:insert).should == text.index('1.13')

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '(b (c (d))))'
      text.index(:insert).should == text.index('1.3')


      text.mark_set(:insert, '1.6')
      text.get('insert', 'insert lineend').should == '(c (d))))'

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == ')))'
      text.index(:insert).should == text.index('1.12')

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '(c (d))))'
      text.index(:insert).should == text.index('1.6')


      text.mark_set(:insert, '1.9')
      text.get('insert', 'insert lineend').should == '(d))))'

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '))))'
      text.index(:insert).should == text.index('1.11')

      VER::Methods::Move.matching_brace(text, 1)
      text.get('insert', 'insert lineend').should == '(d))))'
      text.index(:insert).should == text.index('1.9')
    end
  end
end
