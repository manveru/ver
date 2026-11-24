require_relative '../../helper'

VER.spec keymap: 'emacs', hidden: false do
  describe 'Keymap for Emacs' do
    describe 'movement' do
      behaves_like :with_buffer

      it 'goes to first column with <Home> and <Control-a>' do
        insert.index = '1.0 lineend'
        type '<Home>'
        insert.index.should == '1.0 linestart'
        insert.index = '1.0 lineend'
        type '<Control-a>'
        insert.index.should == '1.0 linestart'
      end

      it 'goes to end of line with <End> and <Control-e>' do
        insert.index = '1.0'
        type '<End>'
        insert.index.should == '1.0 lineend'
        insert.index = '1.0'
        type '<Control-e>'
        insert.index.should == '1.0 lineend'
      end
    end

    describe 'deletion' do
      behaves_like :destructive_mode

      it 'deletes the next char with <Control-d>' do
        type '<Control-d>'
        buffer.get('1.0', '1.0 lineend').should == 'nventore voluptatibus dolorem assumenda.'
      end

      it 'kills to end of line with <Control-k>' do
        insert.index = '1.9'
        type '<Control-k>'
        buffer.get('1.0', '1.0 lineend').should == 'Inventore'
      end
    end
  end
end
