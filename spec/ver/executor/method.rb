# frozen_string_literal: true

require_relative '../../helper'

VER.spec keymap: 'vim', hidden: false do
  describe 'Method executor' do
    behaves_like :with_buffer

    it 'opens from :: and runs the selected action on the buffer' do
      type '::'
      label = Tk.pathname_to_widget(Tk::Focus.focus)
      label.is_a?(VER::Executor::ExLabel).should.be.true
      label.value = 'method'
      label.update_only
      label.tree_selection_value.should.equal 'method'
      Tk::Event.generate(label, '<Return>', when: :now)
      Tk.update

      picker = Tk.pathname_to_widget(Tk::Focus.focus)
      picker.is_a?(VER::Executor::ExMethod).should.be.true
      picker.value = 'next_char'
      picker.update_only
      picker.tree_selection_value.should.equal 'next_char'
      Tk::Event.generate(picker, '<Return>', when: :now)
      Tk.update

      Tk.pathname_to_widget(Tk::Focus.focus).equal?(buffer).should.be.true
      insert.index.should == '1.1'
    end
  end
end
