# Encoding: UTF-8
require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Digraphs' do
      behaves_like :destructive_key_spec

      key '<Control-k>a:', 'insert ä by digraph' do |key|
        type 'i'
        type key
        buffer.get('1.0').should == "ä"
      end

      key '<Control-k>:o', 'insert ö by digraph' do |key|
        type 'i'
        type key
        buffer.get('1.0').should == "ö"
      end

      key '<Control-k>si', 'insert し by digraph' do |key|
        type 'i'
        type key
        buffer.get('1.0').should == 'し'
      end

      key '<Control-k>A5', 'insert ぁ by digraph' do |key|
        type 'i'
        type key
        buffer.get('1.0').should == 'ぁ'
      end

      key '<Control-k>a5', 'insert あ by digraph' do |key|
        type 'i'
        type key
        buffer.get('1.0').should == 'あ'
      end

      key '<Control-k>A6', 'insert ア by digraph' do |key|
        type 'i'
        type key
        buffer.get('1.0').should == 'ア'
      end

      key '<Control-k>a6', 'insert ァ by digraph' do |key|
        type 'i'
        type key
        buffer.get('1.0').should == 'ァ'
      end
    end
  end
end
