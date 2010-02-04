require_relative '../helper'

MajorMode = VER::MajorMode
MinorMode = VER::MinorMode
Action = VER::Action
Keymap = VER::Keymap
WMM = VER::WidgetMajorMode

VER.spec do
  describe VER::WidgetMajorMode do
    before do
      MajorMode.clear
      MinorMode.clear
    end

    it 'associates a widget with a major mode' do
      entry = Tk::Entry.new
      major = MajorMode[:entry]
      major.map(:get, ['g'])

      wmm = WMM.new(entry, major)
      wmm.widget.should == entry
      wmm.major.should == major
      action_mode, action = wmm.resolve(['g'])
      action_mode.should == major
      action.method.should == :get

      entry.destroy
    end

    it 'inserts the major tag into the widget bindtags' do
      entry = Tk::Entry.new
      major = MajorMode[:entry]
      major.map(:get, ['g'])

      wmm = WMM.new(entry, major)
      entry.bindtags[1].should == major.tag.name
      entry.destroy
    end

    it 'binds all the keys of its major and minor modes' do
      entry = Tk::Entry.new
      major = MajorMode[:entry]
      major.map(:get, ['g'])

      wmm = WMM.new(entry, major)
      (wmm.tag.bind & %w[g]).should == %w[g]

      entry.destroy
    end

    it 'binds all keys found in its minor modes to the tag' do
      entry = Tk::Entry.new
      major = MajorMode[:major]
      minoa = MinorMode[:minoa]
      minob = MinorMode[:minob]
      major.use(:minoa, :minob)

      major.map(:major1, ['m', '1'])
      minoa.map(:minoa2, ['a', '2'])
      minob.map(:minob3, ['b', '3'])

      wmm = WMM.new(entry, major)
      (wmm.tag.bind.sort & %w[1 2 3 a b m]).should == %w[1 2 3 a b m]

      entry.destroy
    end
  end
end
