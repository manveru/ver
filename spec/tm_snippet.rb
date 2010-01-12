require 'bacon'
Bacon.summary_at_exit

require 'strscan'

# TODO: transformations
class Snippet
  LITERAL_BACKTICK  = /\\`/
  LITERAL_DOLLAR    = /\\\$/
  LITERAL_BACKSLASH = /\\/
  PLAIN_TEXT = /[^\\`$]+/
  TAB_STOP = /\$(\d+)/
  NESTED_TAB_STOP = /^\$\{(?<id>\d+):(?<nested>((?<pg>\$\{(?:\\\$\{|\\\}|[^\\}$]|\g<pg>)*\})|(?:\\\}|\\\$\{|[^$}]))+)\}/

  variable = /[A-Z_]+/
  regexp = /(?:\\\/|[^\/\\]+)*/
  format = /(?:\\\/|[^\/\\]+)*/
  options = /[g]*/
  SUBSTITUTE_VARIABLE = /\$(#{variable})/
  SUBSTITUTE_VARIABLE_WITH_DEFAULT = /\$\{(#{variable}):([^}]+)\}/
  SUBSTITUTE_VARIABLE_WITH_REGEXP = /\$\{(#{variable})\/(#{regexp})\/(#{format})\/(#{options})\}/
  SUBSTITUTE_SHELL_CODE = /`((?:\\`|[^`\\]+)*)`/

  attr_accessor :env

  def initialize(snippet, env = {})
    @snippet = snippet
    @env = env
  end

  def to_s
    parse(@snippet, out = [])
    out.join
  end

  def result
    parse(@snippet, out = [])
    out
  end

  def apply_on(widget)
    parse(@snippet, out = [])
    apply_out_on(widget, out)
    # jump_to_home(widget)
    # self.class.jump_to_next_mark(widget)
  end

  def jump_to_home(widget)
    return unless widget.mark_names.include?(:ver_snippet_home)
    widget.mark_set(:insert, :ver_snippet_home)
    widget.mark_unset(:ver_snippet_home)
  end

  def self.jump_to_next_mark(widget)
    marks = widget.mark_names.select{|mark|
      mark =~ /^ver_snippet_(\d+|home)$/
    }.compact.sort

    return unless mark = marks.first

    widget.mark_set('insert', mark)
    widget.mark_unset(mark)
  end

  private

  def parse(string, out)
    scanner = StringScanner.new(string)
    spos = nil

    until scanner.eos?
      spos = scanner.pos

      step(scanner, out)

      if spos == scanner.pos
        raise scanner.inspect
      end
    end
  end

  def step(s, out)
    if s.scan LITERAL_BACKTICK
      out << '`'
    elsif s.scan LITERAL_DOLLAR
      out << '$'
    elsif s.scan LITERAL_BACKSLASH
      out << '\\'
    elsif s.scan SUBSTITUTE_VARIABLE
      out << @env[s[1]]
    elsif s.scan SUBSTITUTE_VARIABLE_WITH_DEFAULT
      key = s[1]
      if @env.key?(key)
        out << @env[key]
      else
        out << sub(s[2])
      end
    elsif s.scan SUBSTITUTE_VARIABLE_WITH_REGEXP
      variable, regexp, format, options = s[1], s[2], s[3], s[4]
      regexp = Regexp.new(regexp)
      format.gsub!(/\$(\d+)/, '\\\\\1')

      if env.key?(variable)
        value = env[variable]
        out << value.gsub(regexp, format)
      end
    elsif s.scan SUBSTITUTE_SHELL_CODE
      code = s[1]
      code.gsub!(/\\`/, '`')
      out << `#{code}`.chomp
    elsif s.scan TAB_STOP
      number = s[1].to_i
      out << number
    elsif s.scan NESTED_TAB_STOP
      number = s[1].to_i
      out << [number, *sub(s[2])]
    elsif s.scan PLAIN_TEXT
      out << s[0]
    end
  end

  def sub(s)
    out = []
    parse(s, out)
    out
  end

  def apply_out_on(widget, out)
    out.each do |atom|
      case atom
      when String
        widget.insert(:insert, atom)
      when Numeric
        atom = 'home' if atom == 0
        mark = "ver_snippet_#{atom}"
        widget.mark_set(mark, 'insert')
        widget.mark_gravity(mark, 'left')
      when Array
        number, *content = atom
        tag = "ver_snippet_#{number}"
        widget.insert(:insert, content, tag)
      end
    end
  end
end

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
