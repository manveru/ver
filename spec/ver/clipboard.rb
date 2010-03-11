# Encoding: UTF-8
require_relative '../helper'

# This spec is incomplete, I want to specify copy/pasting of arbitary ruby
# objects, as far as they can be serialized.
# Have to read the ICCCM and about their conventions first.
# Obviously, Marshal would be very convenient, but I doubt it's best practice.

shared :clipboard_spec do
  before do
    Tk::Clipboard.clear
  end
end

VER.spec do
  describe 'VER::Clipboard' do
    describe 'dwim=' do
      behaves_like :clipboard_spec

      it 'copies an ASCII String as STRING' do
        string = "some string".encode(Encoding::ASCII)
        VER::Clipboard.dwim = string
        Tk::Clipboard.get(VER.root, 'STRING').should == string
      end

      it "copies an ASCII String as UTF8_STRING" do
        string = "some string".encode(Encoding::ASCII)
        VER::Clipboard.dwim = string
        Tk::Clipboard.get(VER.root, 'UTF8_STRING').should == string
      end

      it 'copies an UTF-8 String as UTF8_STRING' do
        string = "日本語".encode(Encoding::UTF_8)
        VER::Clipboard.dwim = string
        Tk::Clipboard.get(VER.root, 'UTF8_STRING').should == string
      end

      it "doesn't copy an UTF-8 String as STRING" do
        string = "日本語".encode(Encoding::UTF_8)
        VER::Clipboard.dwim = string
        lambda{
          Tk::Clipboard.get(VER.root, 'STRING')
        }.should.raise(RuntimeError).message.
         should.start_with(%(CLIPBOARD selection doesn't exist or form "STRING" not defined))
      end

      it 'puts an object into the clipboard' do
        obj = ["hi there", (24..42), :Symbol, Class]
        VER::Clipboard.dwim = obj
        got = Tk::Clipboard.get(VER.root, 'RUBY_MARSHAL')
        got_obj = Marshal.load(got.unpack('m0').first)
        got_obj.should == obj
      end
    end

    describe 'dwim' do
      behaves_like :clipboard_spec

      it 'gets an ASCII String from STRING' do
        string = "some string".encode(Encoding::ASCII)
        Tk::Clipboard.set(string, type: 'STRING')
        got = VER::Clipboard.dwim
        got.should == string
        got.encoding.should == Encoding::ASCII
      end

      it "gets an ASCII String from ASCII in UTF8_STRING" do
        string = "some string".encode(Encoding::ASCII)
        Tk::Clipboard.set(string, type: 'UTF8_STRING')
        got = VER::Clipboard.dwim
        got.should == string
        got.encoding.should == Encoding::ASCII
      end

      it 'gets an UTF-8 String from UTF-8 in UTF8_STRING' do
        string = "日本語".encode(Encoding::UTF_8)
        Tk::Clipboard.set(string, type: 'UTF8_STRING')
        got = VER::Clipboard.dwim
        got.should == string
        got.encoding.should == Encoding::UTF_8
      end

      it 'puts an object into the clipboard' do
        obj = ["hi there", (24..42), :Symbol, Class]
        marshal = [Marshal.dump(obj)].pack('m0')
        Tk::Clipboard.set(marshal, type: 'RUBY_MARSHAL')
        got = VER::Clipboard.dwim
        got.should == obj
      end
    end
  end
end
