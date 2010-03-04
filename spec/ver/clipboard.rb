# Encoding: UTF-8
require_relative '../helper'

# This spec is incomplete, I want to specify copy/pasting of arbitary ruby
# objects, as far as they can be serialized.
# Have to read the ICCCM and about their conventions first.
# Obviously, Marshal would be very convenient, but I doubt it's best practice.

VER.spec do
  describe 'VER::Clipboard' do
    describe 'set' do
      before do
        Tk::Clipboard.clear
      end

      it 'copies an ASCII String as STRING' do
        string = "some string".encode(Encoding::ASCII)
        VER::Clipboard.set(string)
        Tk::Clipboard.get(VER.root, 'STRING').should == string
      end

      it "copies an ASCII String as UTF8_STRING" do
        string = "some string".encode(Encoding::ASCII)
        VER::Clipboard.set(string)
        Tk::Clipboard.get(VER.root, 'UTF8_STRING').should == string
      end

      it 'copies an UTF-8 String as UTF8_STRING' do
        string = "日本語".encode(Encoding::UTF_8)
        VER::Clipboard.set(string)
        Tk::Clipboard.get(VER.root, 'UTF8_STRING').should == string
      end

      it "doesn't copy an UTF-8 String as STRING" do
        string = "日本語".encode(Encoding::UTF_8)
        VER::Clipboard.set(string)
        lambda{
          Tk::Clipboard.get(VER.root, 'STRING')
        }.should.raise(RuntimeError).message.
         should.start_with(%(CLIPBOARD selection doesn't exist or form "STRING" not defined))
      end
    end

    describe 'get' do
      before do
        Tk::Clipboard.clear
      end

      it 'gets an ASCII String from STRING' do
        string = "some string".encode(Encoding::ASCII)
        Tk::Clipboard.set(string, type: 'STRING')
        got = VER::Clipboard.get('STRING')
        got.should == string
        got.encoding.should == Encoding::ASCII
      end

      it "gets an ASCII String from ASCII in UTF8_STRING" do
        string = "some string".encode(Encoding::ASCII)
        Tk::Clipboard.set(string, type: 'UTF8_STRING')
        got = VER::Clipboard.get('UTF8_STRING')
        got.should == string
        got.encoding.should == Encoding::ASCII
      end

      it 'gets an UTF-8 String from UTF-8 in UTF8_STRING' do
        string = "日本語".encode(Encoding::UTF_8)
        Tk::Clipboard.set(string, type: 'UTF8_STRING')
        got = VER::Clipboard.get('UTF8_STRING')
        got.should == string
        got.encoding.should == Encoding::UTF_8
      end
    end
  end
end
