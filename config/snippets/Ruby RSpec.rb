# Encoding: UTF-8

{"shkof" => 
  {scope: "source.ruby.rspec",
   name: "should_not be_kind_of",
   content: "${1:target}.should_not be_a_kind_of(${2:klass})\n$0"},
 "shr" => 
  {scope: "source.ruby.rspec",
   name: "should_receive",
   content: "${1:mock}${1/^.+$/./}should_receive(:${2:message})"},
 "atl" => 
  {scope: "source.ruby.rspec",
   name: "at_least",
   content: "at_least(${1:n}).times"},
 "ant" => 
  {scope: "source.ruby.rspec",
   name: "and_throw",
   content: "and_throw(${1:sym})"},
 "she" => 
  {scope: "source.ruby.rspec",
   name: "should eql",
   content: "${1:target}.should eql(${2:value})\n$0"},
 "bef" => 
  {scope: "source.ruby.rspec",
   name: "before",
   content: "before(${1::each}) do\n  $0\nend"},
 "shne" => 
  {scope: "source.ruby.rspec",
   name: "should_not equal",
   content: "${1:target}.should_not equal(${2:value})\n$0"},
 "shp" => 
  {scope: "source.ruby.rspec",
   name: "should predicate",
   content: "${1:target}.should ${2:be_${3:predicate}} $4\n$0"},
 "des" => 
  {scope: "source.ruby.rspec",
   name: "describe (String)",
   content: 
    "describe \"${1:description}\" do\n  it \"should ${2:description}\" do\n    $0\n  end\nend"},
 "anrb" => 
  {scope: "source.ruby.rspec",
   name: "and_return with block",
   content: "and_return { $1 }"},
 "aft" => 
  {scope: "source.ruby.rspec",
   name: "after",
   content: "after(${1::each}) do\n  $0\nend"},
 "moc" => 
  {scope: "source.ruby.rspec",
   name: "mock",
   content: 
    "${1:var} = mock(\"${2:mock_name}\"${3:, :null_object => true})\n$0"},
 "anr" => 
  {scope: "source.ruby.rspec",
   name: "and_raise",
   content: "and_raise(${1:exception})"},
 "it" => 
  {scope: "source.ruby.rspec",
   name: "it",
   content: "it \"${2:should ${1:description}}\" ${3:do\n  $0\nend}"},
 "shbs" => 
  {scope: "source.ruby.rspec",
   name: "should be_success",
   content: "response.should be_success\n$0"},
 "shham" => 
  {scope: "source.ruby.rspec",
   name: "should have_at_most",
   content: "${1:target}.should have_at_most(${2:num}).${3:things}\n$0"},
 "ord" => {scope: "source.ruby.rspec", name: "ordered", content: "ordered"},
 "anra" => 
  {scope: "source.ruby.rspec",
   name: "and_return with args",
   content: "and_return(${1:value})"},
 "any" => 
  {scope: "source.ruby.rspec",
   name: "and_yield",
   content: "and_yield(${1:values})"},
 "shh" => 
  {scope: "source.ruby.rspec",
   name: "should have",
   content: "${1:target}.should have(${2:num}).${3:things}\n$0"},
 "tw" => {scope: "source.ruby.rspec", name: "twice", content: "twice"},
 "shrt" => 
  {scope: "source.ruby.rspec",
   name: "should render_template",
   content: "response.should render_template(:${1:template})\n$0"},
 "ex" => 
  {scope: "source.ruby.rspec",
   name: "exactly",
   content: "exactly(${1:n}).times"},
 "shhal" => 
  {scope: "source.ruby.rspec",
   name: "should have_at_least",
   content: "${1:target}.should have_at_least(${2:num}).${3:things}\n$0"},
 "shbc" => 
  {scope: "source.ruby.rspec",
   name: "should be_close",
   content: "${1:target}.should be_close(${2:result}, ${3:tolerance})\n$0"},
 "desc" => 
  {scope: "source.ruby.rspec",
   name: "describe (Controller)",
   content: 
    "require File.dirname(__FILE__) + '/../spec_helper'\n\ndescribe ${1:controller} do\n  $0\nend"},
 "shnp" => 
  {scope: "source.ruby.rspec",
   name: "should_not predicate",
   content: "${1:target}.should_not ${2:be_${3:predicate}} $4\n$0"},
 "shhr" => 
  {scope: "source.ruby.rspec",
   name: "should have_records",
   content: "${1:target}.should have(${2:x}).records\n$0"},
 "wia" => 
  {scope: "source.ruby.rspec", name: "with args", content: "with(${1:args})"},
 "shnb" => 
  {scope: "source.ruby.rspec",
   name: "should_not be",
   content: "${1:target}.should_not be(${2:result})\n$0"},
 "shn=" => 
  {scope: "source.ruby.rspec",
   name: "should_not ==",
   content: "${1:target}.should_not == ${2:value}\n$0"},
 "shnr" => 
  {scope: "source.ruby.rspec",
   name: "should_not_receive",
   content: "${1:mock}${1/^.+$/./}should_not_receive(:${2:message})"},
 "shb" => 
  {scope: "source.ruby.rspec",
   name: "should be",
   content: "${1:target}.should be(${2:result})\n$0"},
 "dest" => 
  {scope: "source.ruby.rspec",
   name: "describe (type)",
   content: 
    "describe ${1:Type} do\n  it \"should ${2:description}\" do\n    $0\n  end\nend"},
 "sh=" => 
  {scope: "source.ruby.rspec",
   name: "should ==",
   content: "${1:target}.should == ${2:value}\n$0"},
 "shnbs" => 
  {scope: "source.ruby.rspec",
   name: "should_not be_success",
   content: "response.should_not be_success\n$0"},
 "shnrt" => 
  {scope: "source.ruby.rspec",
   name: "should_not respond_to",
   content: "${1:target}.should_not respond_to(:${2:sym})\n$0"},
 "shs" => 
  {scope: "source.ruby.rspec",
   name: "should satisfy",
   content: "${1:target}.should satisfy { |obj| $2 }\n$0"},
 "st" => 
  {scope: "source.ruby.rspec",
   name: "Story",
   content: 
    "Story \"${1:title}\", %{\n  As a${2:role}\n  I want ${3:feature}\n  So that ${4:value}  \n} do\nend"},
 "shnbc" => 
  {scope: "source.ruby.rspec",
   name: "should_not be_close",
   content: 
    "${1:target}.should_not be_close(${2:result}, ${3:tolerance})\n$0"},
 "sht" => 
  {scope: "source.ruby.rspec",
   name: "should throw",
   content: "lambda { $1 }.should throw_symbol(:${2:symbol})\n$0"},
 "dests" => 
  {scope: "source.ruby.rspec",
   name: "describe (type, string)",
   content: 
    "describe ${1:Type}, \"${2:description}\" do\n  it \"should ${3:description}\" do\n    $0\n  end\nend"},
 "shbr" => 
  {scope: "source.ruby.rspec",
   name: "should be_redirect",
   content: "response.should be_redirect\n$0"},
 "shnt" => 
  {scope: "source.ruby.rspec",
   name: "should_not throw",
   content: "lambda { $1 }.should_not throw_symbol(:${2:symbol})\n$0"},
 "shbio" => 
  {scope: "source.ruby.rspec",
   name: "should be_instance_of",
   content: "${1:target}.should be_instance_of(${2:klass})\n$0"},
 "resh" => 
  {scope: "source.ruby.rspec",
   name: "Require spec_helper",
   content: "require File.dirname(__FILE__) + '/../spec_helper'"},
 "shre" => 
  {scope: "source.ruby.rspec",
   name: "should raise_error",
   content: "lambda { $1 }.should raise_error(${2:error})\n$0"},
 "shnre" => 
  {scope: "source.ruby.rspec",
   name: "should_not raise_error",
   content: "lambda { $1 }.should_not raise_error(${2:error})\n$0"},
 "shm" => 
  {scope: "source.ruby.rspec",
   name: "should =~",
   content: "${1:target}.should =~ /${2:regexp}/\n$0"},
 "desrc" => 
  {scope: "source.ruby.rspec",
   name: "describe (RESTful Controller)",
   content: 
    "describe ${1:controller}, \"${2:GET|POST|PUT|DELETE} ${3:/some/path}${4: with some parameters}\" do\n  $0\nend"},
 "shnm" => 
  {scope: "source.ruby.rspec",
   name: "should_not =~",
   content: "${1:target}.should_not =~ /${2:regexp}/\n$0"},
 "mat" => 
  {scope: "source.ruby.rspec",
   name: "Custom Matcher",
   content: 
    "class ${1:ReverseTo}\n  def initialize($3)\n    @$3 = $3\n  end\n\n  def matches?(actual)\n    @actual = actual\n    # Satisfy expectation here. Return false or raise an error if it's not met.\n    ${0:@actual.reverse.should == @$3}\n    true\n  end\n\n  def failure_message\n    \"expected \#{@actual.inspect} to $2 \#{@$3.inspect}, but it didn't\"\n  end\n\n  def negative_failure_message\n    \"expected \#{@actual.inspect} not to $2 \#{@$3.inspect}, but it did\"\n  end\nend\n\ndef ${2:reverse_to}(${3:expected})\n  $1.new($3)\nend"},
 "shbko" => 
  {scope: "source.ruby.rspec",
   name: "should be_kind_of",
   content: "${1:target}.should be_a_kind_of(${2:klass})\n$0"},
 "conn" => 
  {scope: "source.ruby.rspec",
   name: "controller_name",
   content: "controller_name :${1:controller}"},
 "shnbr" => 
  {scope: "source.ruby.rspec",
   name: "should_not be_redirect",
   content: "response.should_not be_redirect\n$0"},
 "annot" => 
  {scope: "source.ruby.rspec",
   name: "any_number_of_times",
   content: "any_number_of_times"},
 "atm" => 
  {scope: "source.ruby.rspec",
   name: "at_most",
   content: "at_most(${1:n}).times"},
 "shns" => 
  {scope: "source.ruby.rspec",
   name: "should_not satisfy",
   content: "${1:target}.should_not satisfy { |obj| $2 }\n$0"},
 "itsbl" => 
  {scope: "source.ruby.rspec",
   name: "it_should_behave_like",
   content: "it_should_behave_like ${2:\"$1\"}$0"},
 "on" => {scope: "source.ruby.rspec", name: "once", content: "once"}}
