require_relative '../helper'

VER.spec do
  describe 'Buffer instance methods' do
    buffer = VER::Buffer.new(Tk::Toplevel.new)
    buffer.open(:Scratch)

    it 'deletes trailing whitespace' do
      buffer.value = <<-TEXT.chomp
some   
lines   
      TEXT

      buffer.touch!('1.0', 'end')
      buffer.handle_pending_syntax_highlights
      buffer.delete_trailing_whitespace
      buffer.value.should == <<-TEXT
some
lines
      TEXT
    end
  end
end
