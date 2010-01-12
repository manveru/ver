require 'bacon'
Bacon.summary_at_exit

require_relative '../lib/ver/methods/snippet.rb'

Snippet = VER::Snippet

describe 'TM Snippet' do
  describe 'Plain Text' do
    should 'handle text without any special chars' do
      s = Snippet.new('Hello, World!')
      s.to_s.should == 'Hello, World!'
    end

    should 'handle escaped `' do
      s = Snippet.new('execute \`foo\`')
      s.to_s.should == 'execute `foo`'
    end

    should 'handle escaped $' do
      s = Snippet.new('set \$var')
      s.to_s.should == 'set $var'
    end

    should 'handle literal \\' do
      s = Snippet.new('the special \\')
      s.to_s.should == 'the special \\'
    end
  end

  describe 'Variables' do
    should 'substitute simple env var' do
      s = Snippet.new('\\textbf{$VER_SPEC_STRING}')
      s.env = {'VER_SPEC_STRING' => 'foo'}
      s.to_s.should == '\\textbf{foo}'
    end

    should "have fallback if given var doesn't exist" do
      s = Snippet.new('\\textbf{${NOT_HERE:not here}}')
      s.to_s.should == '\\textbf{not here}'
    end

    should 'use variables in the default value' do
      s = Snippet.new('\\textbf{${NOT_HERE:$HERE}}')
      s.env = {'HERE' => 'fallback'}
      s.to_s.should == '\\textbf{fallback}'
    end

    should 'support regular expression substitution' do
      s = Snippet.new('${TM_SELECTED_TEXT/^.+$/o $0/g}')
      s.env = {'TM_SELECTED_TEXT' => "some\nlines\nhere\n"}
      s.to_s.should == "o some\no lines\no here\n"
    end
  end

  describe 'Shell Code' do
    should 'interpolate shell code within backticks' do
      s = Snippet.new('<a href="`echo hi`.html">$TM_SELECTED_TEXT</a>')
      s.env = {'TM_SELECTED_TEXT' => "the way to foo"}
      s.to_s.should == '<a href="hi.html">the way to foo</a>'
    end

    should 'handle escaped backticks within the code' do
      s = Snippet.new('<a href="`echo foo\`echo bar\``.html">$TM_SELECTED_TEXT</a>')
      s.env = {'TM_SELECTED_TEXT' => "the way to foo"}
      s.to_s.should == '<a href="foobar.html">the way to foo</a>'
    end
  end

  describe 'Tab Stops' do
    should 'insert tab stops in the result' do
      s = Snippet.new(<<-SNIPPET.chomp)
<div>
  $0
</div>
      SNIPPET
      s.result.should == ["<div>\n  ", 0, "\n</div>"]
    end

    should 'insert multiple tab stops in the result' do
      s = Snippet.new(<<-SNIPPET.chomp)
<div$1>
  $0
</div>
      SNIPPET
      s.result.should == ["<div", 1, ">\n  ", 0, "\n</div>"]
    end

    should 'handle nested tab stops' do
      s = Snippet.new(<<-SNIPPET.chomp)
<div${1: id='${2:some_id}'}>
  $0
</div>
      SNIPPET
      s.result.should == ["<div", [1, " id='", [2, "some_id"], "'"], ">\n  ", 0, "\n</div>"]
    end
  end

  describe 'Mirrors' do
    should 'mirror once' do
      s = Snippet.new(<<-SNIPPET.chomp)
\begin{${1:enumerate}}
  $0
\end{$1}
      SNIPPET
      s.result.should == ["\begin{", [1, "enumerate"], "}\n  ", 0, "\n\end{", 1, "}"]
    end
  end

  describe 'Apply on widget' do
    require 'ffi-tk'

    def snippet_apply(snippet, env = {})
      text = Tk::Text.new
      s = Snippet.new(snippet, env)
      s.apply_on(text)
      dump = text.dump(:all, '1.0', 'end')
      dump.reject!{|type, name, index|
        next unless type == 'mark'
        name == 'current' || name == 'insert'
      }
      dump.pop if dump.last[0, 2] == ["text", "\n"] # remove last newline
      dump
    ensure
      text.destroy
    end

    should 'apply plain text snippet' do
      snippet_apply('foo').should == [
        ["text", "foo", "1.0"],
      ]
    end

    should 'insert a single tab stop' do
      snippet_apply('<h1>$0</h1>').should == [
        ["text", "<h1>", "1.0"],
        ["mark", "ver_snippet_home", "1.4"],
        ["text", "</h1>", "1.4"],
      ]
    end

    should 'insert two tab stops' do
      dump = snippet_apply(<<-SNIPPET.chomp)
<code lang='$1'>
  $0
</code>
      SNIPPET
      dump.should == [
        ["text", "<code lang='", "1.0"],
        ["mark", "ver_snippet_1", "1.12"],
        ["text", "'>\n", "1.12"],
        ["text", "  ", "2.0"],
        ["mark", "ver_snippet_home", "2.2"],
        ["text", "\n", "2.2"],
        ["text", "</code>", "3.0"]
      ]
    end

    should 'insert a tab stop with default value' do
      dump = snippet_apply(<<-SNIPPET.chomp)
<code lang='${1:ruby}'>
  $0
</code>
      SNIPPET
      dump.should == [
        ["text", "<code lang='", "1.0"],
        ["tagon", "ver_snippet_1", "1.12"],
        ["text", "\"ruby\"", "1.12"],
        ["tagoff", "ver_snippet_1", "1.18"],
        ["text", "'>\n", "1.18"],
        ["text", "  ", "2.0"],
        ["mark", "ver_snippet_home", "2.2"],
        ["text", "\n", "2.2"],
        ["text", "</code>", "3.0"]
      ]
    end
  end
end
