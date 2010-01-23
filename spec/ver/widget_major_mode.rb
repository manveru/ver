require 'bacon'
Bacon.summary_on_exit

require 'ffi-tk'

require_relative '../../lib/ver/keymap'
require_relative '../../lib/ver/common_mode'
require_relative '../../lib/ver/major_mode'
require_relative '../../lib/ver/minor_mode'
require_relative '../../lib/ver/action'

MajorMode = VER::MajorMode
MinorMode = VER::MinorMode
Action = VER::Action
Keymap = VER::Keymap
WMM = VER::WidgetMajorMode

describe VER::WidgetMajorMode do
  before do
    MajorMode.clear
  end

  it 'associates a widget with a major mode' do
    entry = Tk::Entry.new
    major = MajorMode[:entry]
    major.map(:get, ['g'])

    wmm = WMM.new(entry, major)
    wmm.widget.should == entry
    wmm.major.should == major
    wmm.resolve(['g']).should == Action.new(nil, :get)
  end

  it 'inserts the major tag into the widget bindtags' do
    entry = Tk::Entry.new
    major = MajorMode[:entry]
    major.map(:get, ['g'])

    wmm = WMM.new(entry, major)
    entry.bindtags[1].should == major.tag.name
  end
end
