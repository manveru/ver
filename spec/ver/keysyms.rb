require_relative '../helper'

VER.spec do
  describe 'Event' do
    def expand(pattern)
      VER::Event.expand_pattern(pattern)
    end

    it 'expands pattern' do
      expand('<C-A-x>').should == '<Control-Alt-x>'
    end
  end
end
