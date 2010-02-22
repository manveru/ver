# Encoding: UTF-8

{"ope" => 
  {scope: "source.ruby",
   name: "open(\"path/or/url\", \"w\") { |io| .. }",
   content: 
    "open(${1:\"${2:path/or/url/or/pipe}\"}${3/(^[rwab+]+$)|.*/(?1:, \")/}${3:w}${3/(^[rwab+]+$)|.*/(?1:\")/}) { |${4:io}| $0 }"},
 "eac-" => 
  {scope: "source.ruby",
   name: "each_char { |chr| .. }",
   content: "each_char { |${1:chr}| $0 }"},
 "fin" => 
  {scope: "source.ruby",
   name: "find { |e| .. }",
   content: "find { |${1:e}| $0 }"},
 "sel" => 
  {scope: "source.ruby",
   name: "select { |e| .. }",
   content: "select { |${1:e}| $0 }"},
 "Md" => 
  {scope: "source.ruby",
   name: "Marshal.dump(.., file)",
   content: 
    "File.open(${1:\"${2:path/to/file}.dump\"}, \"wb\") { |${3:file}| Marshal.dump(${4:obj}, ${3:file}) }"},
 "clafn" => 
  {scope: "source.ruby",
   name: "class_from_name()",
   content: 
    "split(\"::\").inject(Object) { |par, const| par.const_get(const) }"},
 "ste" => 
  {scope: "source.ruby",
   name: "step(2) { |e| .. }",
   content: 
    "step(${1:2}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:n}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "ts" => 
  {scope: "source.ruby",
   name: "require \"tc_..\" ..",
   content: 
    "require \"test/unit\"\n\nrequire \"tc_${1:test_case_file}\"\nrequire \"tc_${2:test_case_file}\"\n"},
 "asnn" => 
  {scope: "source.ruby",
   name: "assert_not_nil(..)",
   content: 
    "assert_not_nil`snippet_paren.rb`${0:instance}`snippet_paren.rb end`"},
 "eawi" => 
  {scope: "source.ruby",
   name: "each_with_index { |e, i| .. }",
   content: "each_with_index { |${1:e}, ${2:i}| $0 }"},
 "asns" => 
  {scope: "source.ruby",
   name: "assert_not_same(..)",
   content: 
    "assert_not_same`snippet_paren.rb`${1:unexpected}, ${0:actual}`snippet_paren.rb end`"},
 "if" => 
  {scope: "source.ruby",
   name: "if … end",
   content: "if ${1:condition}\n\t$0\nend"},
 "eak" => 
  {scope: "source.ruby",
   name: "each_key { |key| .. }",
   content: "each_key { |${1:key}| $0 }"},
 "eav" => 
  {scope: "source.ruby",
   name: "each_value { |val| .. }",
   content: "each_value { |${1:val}| $0 }"},
 "mod" => 
  {scope: "source.ruby",
   name: "module .. ClassMethods .. end",
   content: 
    "module ${1:${TM_FILENAME/(?:\\A|_)([A-Za-z0-9]+)(?:\\.rb)?/(?2::\\u$1)/g}}\n\tmodule ClassMethods\n\t\t$0\n\tend\n\t\n\tmodule InstanceMethods\n\t\t\n\tend\n\t\n\tdef self.included(receiver)\n\t\treceiver.extend         ClassMethods\n\t\treceiver.send :include, InstanceMethods\n\tend\nend"},
 "asnt" => 
  {scope: "source.ruby",
   name: "assert_nothing_thrown { .. }",
   content: "assert_nothing_thrown { $0 }"},
 "fl" => 
  {scope: "source.ruby",
   name: "flunk(..)",
   content: 
    "flunk`snippet_paren.rb`\"${0:Failure message.}\"`snippet_paren.rb end`"},
 "Comp" => 
  {scope: "source.ruby",
   name: "include Comparable ..",
   content: "include Comparable\n\ndef <=>(other)\n\t$0\nend"},
 "case" => 
  {scope: "source.ruby",
   name: "case … end",
   content: "case ${1:object}\nwhen ${2:condition}\n\t$0\nend"},
 "unif" => 
  {scope: "source.ruby",
   name: "unix_filter { .. }",
   content: "ARGF.each_line$1 do |${2:line}|\n\t$0\nend"},
 "gsu" => 
  {scope: "source.ruby",
   name: "gsub(/../) { |match| .. }",
   content: 
    "gsub(/${1:pattern}/) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:match}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "map" => 
  {scope: "source.ruby",
   name: "map { |e| .. }",
   content: "map { |${1:e}| $0 }"},
 "sca" => 
  {scope: "source.ruby",
   name: "scan(/../) { |match| .. }",
   content: "scan(/${1:pattern}/) { |${2:match}| $0 }"},
 "optp" => 
  {scope: "source.ruby",
   name: "option_parse { .. }",
   content: 
    "require \"optparse\"\n\noptions = {${1::default => \"args\"}}\n\nARGV.options do |opts|\n\topts.banner = \"Usage:  \#{File.basename(\\$PROGRAM_NAME)} [OPTIONS]${2/^\\s*$|(.*\\S.*)/(?1: )/}${2:OTHER_ARGS}\"\n\t\n\topts.separator \"\"\n\topts.separator \"Specific Options:\"\n\t\n\t$0\n\t\n\topts.separator \"Common Options:\"\n\t\n\topts.on( \"-h\", \"--help\",\n\t         \"Show this message.\" ) do\n\t\tputs opts\n\t\texit\n\tend\n\t\n\tbegin\n\t\topts.parse!\n\trescue\n\t\tputs opts\n\t\texit\n\tend\nend\n"},
 "eap" => 
  {scope: "source.ruby",
   name: "each_pair { |name, val| .. }",
   content: "each_pair { |${1:name}, ${2:val}| $0 }"},
 "any" => 
  {scope: "source.ruby",
   name: "any? { |e| .. }",
   content: "any? { |${1:e}| $0 }"},
 "asio" => 
  {scope: "source.ruby",
   name: "assert_instance_of(..)",
   content: 
    "assert_instance_of`snippet_paren.rb`${1:ExpectedClass}, ${0:actual_instance}`snippet_paren.rb end`"},
 "Yd-" => 
  {scope: "source.ruby",
   name: "YAML.dump(.., file)",
   content: 
    "File.open(${1:\"${2:path/to/file}.yaml\"}, \"w\") { |${3:file}| YAML.dump(${4:obj}, ${3:file}) }"},
 "cla" => 
  {scope: "source.ruby",
   name: "class << self .. end",
   content: "class << ${1:self}\n\t$0\nend"},
 "usai" => 
  {scope: "source.ruby",
   name: "usage_if()",
   content: 
    "if ARGV.$1\n\tabort \"Usage:  \#{\\$PROGRAM_NAME} ${2:ARGS_GO_HERE}\"\nend"},
 "asnm" => 
  {scope: "source.ruby",
   name: "assert_no_match(..)",
   content: 
    "assert_no_match`snippet_paren.rb`/${1:unexpected_pattern}/, ${0:actual_string}`snippet_paren.rb end`"},
 "File" => 
  {scope: "source.ruby",
   name: "File.read(\"..\")",
   content: "File.read(${1:\"${2:path/to/file}\"})"},
 "defmm" => 
  {scope: "source.ruby",
   name: "def method_missing .. end",
   content: "def method_missing(meth, *args, &blk)\n\t$0\nend"},
 "w" => 
  {scope: "source.ruby",
   name: "attr_writer ..",
   content: "attr_writer :${0:attr_names}"},
 "ea" => 
  {scope: "source.ruby",
   name: "each { |e| .. }",
   content: "each { |${1:e}| $0 }"},
 "{" => 
  {scope: "source.ruby - string - comment",
   name: "Insert { |variable| … }",
   content: 
    "{ ${1/(^(?<var>\\s*[a-z_][a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${1:variable}${1/(^(?<var>\\s*[a-z_][a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}${2:$TM_SELECTED_TEXT} "},
 "sorb" => 
  {scope: "source.ruby",
   name: "sort_by { |e| .. }",
   content: "sort_by { |${1:e}| $0 }"},
 "deft" => 
  {scope: "source.ruby",
   name: "def test_ .. end",
   content: "def test_${1:case_name}\n\t$0\nend"},
 "unless" => 
  {scope: "source.ruby",
   name: "unless … end",
   content: "unless ${1:condition}\n\t$0\nend"},
 "cl" => 
  {scope: "source.ruby",
   name: "classify { |e| .. }",
   content: "classify { |${1:e}| $0 }"},
 "min" => 
  {scope: "source.ruby",
   name: "min { |a, b| .. }",
   content: "min { |a, b| $0 }"},
 "Dir" => 
  {scope: "source.ruby",
   name: "Dir[\"..\"]",
   content: "Dir[${1:\"${2:glob/**/*.rb}\"}]"},
 "mapwi-" => 
  {scope: "source.ruby",
   name: "map_with_index { |e, i| .. }",
   content: "enum_with_index.map { |${1:e}, ${2:i}| $0 }"},
 "Hash" => 
  {scope: "source.ruby",
   name: "Hash.new { |hash, key| hash[key] = .. }",
   content: "Hash.new { |${1:hash}, ${2:key}| ${1:hash}[${2:key}] = $0 }"},
 "deli" => 
  {scope: "source.ruby",
   name: "delete_if { |e| .. }",
   content: "delete_if { |${1:e}| $0 }"},
 "tim" => 
  {scope: "source.ruby",
   name: "times { |n| .. }",
   content: 
    "times { ${1/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${1:n}${1/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "lam" => 
  {scope: "source.ruby",
   name: "lambda { |args| .. }",
   content: 
    "lambda { ${1/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${1:args}${1/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "rw" => 
  {scope: "source.ruby",
   name: "attr_accessor ..",
   content: "attr_accessor :${0:attr_names}"},
 "asne" => 
  {scope: "source.ruby",
   name: "assert_not_equal(..)",
   content: 
    "assert_not_equal`snippet_paren.rb`${1:unexpected}, ${0:actual}`snippet_paren.rb end`"},
 "ran" => 
  {scope: "source.ruby", name: "randomize()", content: "sort_by { rand }"},
 "asnr" => 
  {scope: "source.ruby",
   name: "assert_nothing_raised(..) { .. }",
   content: "assert_nothing_raised(${1:Exception}) { $0 }"},
 "sor" => 
  {scope: "source.ruby",
   name: "sort { |a, b| .. }",
   content: "sort { |a, b| $0 }"},
 "Forw-" => 
  {scope: "source.ruby",
   name: "extend Forwardable",
   content: "extend Forwardable"},
 "gre" => 
  {scope: "source.ruby",
   name: "grep(/pattern/) { |match| .. }",
   content: "grep(${1:/${2:pattern}/}) { |${3:match}| $0 }"},
 "max" => 
  {scope: "source.ruby",
   name: "max { |a, b| .. }",
   content: "max { |a, b| $0 }"},
 "def" => 
  {scope: "source.ruby",
   name: "def … end",
   content: "def ${1:method_name}\n\t$0\nend"},
 "aso" => 
  {scope: "source.ruby",
   name: "assert_operator(..)",
   content: 
    "assert_operator`snippet_paren.rb`${1:left}, :${2:operator}, ${0:right}`snippet_paren.rb end`"},
 nil => 
  {scope: "text.html, source.yaml, meta.erb",
   name: "Insert ERb’s <% .. %> or <%= .. %>",
   content: "<%= ${0:$TM_SELECTED_TEXT} %>"},
 "rb" => 
  {scope: "source.ruby",
   name: "#!/usr/bin/env ruby -wKU",
   content: "#!/usr/bin/env ruby${TM_RUBY_SWITCHES: -wKU}\n"},
 "defds" => 
  {scope: "source.ruby",
   name: "def_delegators ..",
   content: "def_delegators :${1:@del_obj}, :${0:del_methods}"},
 "ife" => 
  {scope: "source.ruby",
   name: "if … else … end",
   content: "if ${1:condition}\n\t$2\nelse\n\t$3\nend"},
 "col" => 
  {scope: "source.ruby",
   name: "collect { |e| .. }",
   content: "collect { |${1:e}| $0 }"},
 "upt" => 
  {scope: "source.ruby",
   name: "upto(1.0/0.0) { |n| .. }",
   content: 
    "upto(${1:1.0/0.0}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:n}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "when" => 
  {scope: "source.ruby", name: "when …", content: "when ${1:condition}\n\t$0"},
 "ass" => 
  {scope: "source.ruby",
   name: "assert_same(..)",
   content: 
    "assert_same`snippet_paren.rb`${1:expected}, ${0:actual}`snippet_paren.rb end`"},
 "det" => 
  {scope: "source.ruby",
   name: "detect { |e| .. }",
   content: "detect { |${1:e}| $0 }"},
 "par" => 
  {scope: "source.ruby",
   name: "partition { |e| .. }",
   content: "partition { |${1:e}| $0 }"},
 "eas-" => 
  {scope: "source.ruby",
   name: "each_slice(..) { |group| .. }",
   content: "each_slice(${1:2}) { |${2:group}| $0 }"},
 "fet" => 
  {scope: "source.ruby",
   name: "fetch(name) { |key| .. }",
   content: 
    "fetch(${1:name}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:key}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "opt" => 
  {scope: "source.ruby",
   name: "option(..)",
   content: 
    "opts.on( \"-${1:o}\", \"--${2:long-option-name}\"${3/^\\s*$|(.*\\S.*)/(?1:, )/}${3:String},\n         \"${4:Option description.}\" ) do |${6:opt}|\n\t$0\nend"},
 "r" => 
  {scope: "source.ruby",
   name: "attr_reader ..",
   content: "attr_reader :${0:attr_names}"},
 "eal" => 
  {scope: "source.ruby",
   name: "each_line { |line| .. }",
   content: "each_line$1 { |${2:line}| $0 }"},
 "fil" => 
  {scope: "source.ruby",
   name: "fill(range) { |i| .. }",
   content: 
    "fill(${1:range}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:i}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "asm" => 
  {scope: "source.ruby",
   name: "assert_match(..)",
   content: 
    "assert_match`snippet_paren.rb`/${1:expected_pattern}/, ${0:actual_string}`snippet_paren.rb end`"},
 "reve" => 
  {scope: "source.ruby",
   name: "reverse_each { |e| .. }",
   content: "reverse_each { |${1:e}| $0 }"},
 "defd" => 
  {scope: "source.ruby",
   name: "def_delegator ..",
   content: "def_delegator :${1:@del_obj}, :${2:del_meth}, :${3:new_name}"},
 "asn" => 
  {scope: "source.ruby",
   name: "assert_nil(..)",
   content: "assert_nil`snippet_paren.rb`${0:instance}`snippet_paren.rb end`"},
 "inj" => 
  {scope: "source.ruby",
   name: "inject(init) { |mem, var| .. }",
   content: "inject${1/.+/(/}${1:init}${1/.+/)/} { |${2:mem}, ${3:var}| $0 }"},
 "rej" => 
  {scope: "source.ruby",
   name: "reject { |e| .. }",
   content: "reject { |${1:e}| $0 }"},
 "do" => 
  {scope: "source.ruby",
   name: "Insert do |variable| … end",
   content: 
    "do${1/(^(?<var>\\s*[a-z_][a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1: |)/}${1:variable}${1/(^(?<var>\\s*[a-z_][a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}\n\t$0\nend"},
 "deec" => 
  {scope: "source.ruby",
   name: "deep_copy(..)",
   content: "Marshal.load(Marshal.dump(${0:obj_to_copy}))"},
 "begin" => 
  {scope: "source.ruby - comment",
   name: "begin … rescue … end",
   content: 
    "${TM_SELECTED_TEXT/([\\t ]*).*/$1/m}begin\n\t${3:${TM_SELECTED_TEXT/(\\A.*)|(.+)|\\n\\z/(?1:$0:(?2:\\t$0))/g}}\n${TM_SELECTED_TEXT/([\\t ]*).*/$1/m}rescue ${1:Exception}${2/.+/ => /}${2:e}\n${TM_SELECTED_TEXT/([\\t ]*).*/$1/m}\t$0\n${TM_SELECTED_TEXT/([\\t ]*).*/$1/m}end\n"},
 "eab" => 
  {scope: "source.ruby",
   name: "each_byte { |byte| .. }",
   content: "each_byte { |${1:byte}| $0 }"},
 "am" => 
  {scope: "source.ruby",
   name: "alias_method ..",
   content: "alias_method :${1:new_name}, :${0:old_name}"},
 "asrt" => 
  {scope: "source.ruby",
   name: "assert_respond_to(..)",
   content: 
    "assert_respond_to`snippet_paren.rb`${1:object}, :${0:method}`snippet_paren.rb end`"},
 "dow" => 
  {scope: "source.ruby",
   name: "downto(0) { |n| .. }",
   content: 
    "downto(${1:0}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:n}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "Enum" => 
  {scope: "source.ruby",
   name: "include Enumerable ..",
   content: "include Enumerable\n\ndef each(&block)\n\t$0\nend"},
 "ast" => 
  {scope: "source.ruby",
   name: "assert_throws(..) { .. }",
   content: "assert_throws(:${1:expected}) { $0 }"},
 "usau" => 
  {scope: "source.ruby",
   name: "usage_unless()",
   content: 
    "unless ARGV.$1\n\tabort \"Usage:  \#{\\$PROGRAM_NAME} ${2:ARGS_GO_HERE}\"\nend"},
 "fina" => 
  {scope: "source.ruby",
   name: "find_all { |e| .. }",
   content: "find_all { |${1:e}| $0 }"},
 "Ml" => 
  {scope: "source.ruby",
   name: "Marshal.load(obj)",
   content: 
    "File.open(${1:\"${2:path/to/file}.dump\"}, \"rb\") { |${3:file}| Marshal.load(${3:file}) }"},
 "Array" => 
  {scope: "source.ruby",
   name: "Array.new(10) { |i| .. }",
   content: 
    "Array.new(${1:10}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:i}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "defs" => 
  {scope: "source.ruby",
   name: "def self .. end",
   content: "def self.${1:class_method_name}\n\t$0\nend"},
 "flao" => 
  {scope: "source.ruby",
   name: "flatten_once()",
   content: "inject(Array.new) { |${1:arr}, ${2:a}| ${1:arr}.push(*${2:a}) }"},
 "asid" => 
  {scope: "source.ruby",
   name: "assert_in_delta(..)",
   content: 
    "assert_in_delta`snippet_paren.rb`${1:expected_float}, ${2:actual_float}, ${0:2 ** -20}`snippet_paren.rb end`"},
 "tc" => 
  {scope: "source.ruby",
   name: "class .. < Test::Unit::TestCase .. end",
   content: 
    "require \"test/unit\"\n\nrequire \"${1:library_file_name}\"\n\nclass Test${2:${1/([\\w&&[^_]]+)|./\\u$1/g}} < Test::Unit::TestCase\n\tdef test_${3:case_name}\n\t\t$0\n\tend\nend"},
 "cla-" => 
  {scope: "source.ruby",
   name: "class .. < DelegateClass .. initialize .. end",
   content: 
    "class ${1:${TM_FILENAME/(?:\\A|_)([A-Za-z0-9]+)(?:\\.rb)?/(?2::\\u$1)/g}} < DelegateClass(${2:ParentClass})\n\tdef initialize${3/(^.*?\\S.*)|.*/(?1:\\()/}${3:args}${3/(^.*?\\S.*)|.*/(?1:\\))/}\n\t\tsuper(${4:del_obj})\n\t\t\n\t\t$0\n\tend\n\t\n\t\nend"},
 "eai" => 
  {scope: "source.ruby",
   name: "each_index { |i| .. }",
   content: "each_index { |${1:i}| $0 }"},
 "as" => 
  {scope: "source.ruby",
   name: "assert(..)",
   content: 
    "assert`snippet_paren.rb`${1:test}, \"${0:Failure message.}\"`snippet_paren.rb end`"},
 "req" => 
  {scope: "source.ruby", name: "require \"..\"", content: "require \"$0\""},
 "all" => 
  {scope: "source.ruby",
   name: "all? { |e| .. }",
   content: "all? { |${1:e}| $0 }"},
 "sub" => 
  {scope: "source.ruby",
   name: "sub(/../) { |match| .. }",
   content: 
    "sub(/${1:pattern}/) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:match}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }"},
 "app" => 
  {scope: "source.ruby",
   name: "application { .. }",
   content: "if __FILE__ == \\$PROGRAM_NAME\n\t$0\nend"},
 "asko" => 
  {scope: "source.ruby",
   name: "assert_kind_of(..)",
   content: 
    "assert_kind_of`snippet_paren.rb`${1:ExpectedKind}, ${0:actual_instance}`snippet_paren.rb end`"},
 "zip" => 
  {scope: "source.ruby",
   name: "zip(enums) { |row| .. }",
   content: "zip(${1:enums}) { |${2:row}| $0 }"},
 "asr" => 
  {scope: "source.ruby",
   name: "assert_raise(..) { .. }",
   content: "assert_raise(${1:Exception}) { $0 }"},
 "Yl-" => 
  {scope: "source.ruby",
   name: "YAML.load(file)",
   content: 
    "File.open(${1:\"${2:path/to/file}.yaml\"}) { |${3:file}| YAML.load(${3:file}) }"},
 ":" => 
  {scope: "source.ruby",
   name: "Hash Pair — :key => \"value\"",
   content: ":${1:key} => ${2:\"${3:value}\"}${4:, }"},
 "=b" => 
  {scope: "source.ruby",
   name: "New Block",
   content: 
    "`[[ $TM_LINE_INDEX != 0 ]] && echo; echo`=begin rdoc\n\t$0\n=end"},
 "loo" => {scope: "source.ruby", name: "loop { .. }", content: "loop { $0 }"},
 "dir" => 
  {scope: "source.ruby",
   name: "directory()",
   content: "File.dirname(__FILE__)"},
 "xpa" => 
  {scope: "source.ruby",
   name: "xpath(..) { .. }",
   content: "elements.each(${1:\"${2://XPath}\"}) do |${3:node}|\n\t$0\nend"},
 "end" => {scope: "source.ruby", name: "__END__", content: "__END__\n"},
 "until" => 
  {scope: "source.ruby",
   name: "until ... end",
   content: "until ${1:condition}\n\t$0\nend"},
 "sinc" => 
  {scope: "source.ruby",
   name: "singleton_class()",
   content: "class << self; self end"},
 "tra" => 
  {scope: "source.ruby",
   name: "transaction( .. ) { .. }",
   content: 
    "transaction${1/(^.*?\\S.*)|.*/(?1:\\()/}${1:true}${1/(^.*?\\S.*)|.*/(?1:\\))/} { $0 }"},
 "rep" => 
  {scope: "source.ruby",
   name: "results.report(..) { .. }",
   content: "results.report(\"${1:name}:\") { TESTS.times { $0 } }"},
 "Pn-" => 
  {scope: "source.ruby",
   name: "PStore.new( .. )",
   content: "PStore.new(${1:\"${2:file_name.pstore}\"})"},
 "bm-" => 
  {scope: "source.ruby",
   name: "Benchmark.bmbm do .. end",
   content: "TESTS = ${1:10_000}\nBenchmark.bmbm do |results|\n  $0\nend"},
 "reqg-" => 
  {scope: "source.ruby",
   name: "require_gem \"..\"",
   content: "require \"$0\""},
 "tas" => 
  {scope: "source.ruby",
   name: "task :task_name => [:dependent, :tasks] do .. end",
   content: 
    "desc \"${1:Task description}\"\ntask :${2:${3:task_name} => ${4:[:${5:dependent, :tasks}]}} do\n\t$0\nend"},
 "xml-" => 
  {scope: "source.ruby",
   name: "xmlread(..)",
   content: "REXML::Document.new(File.read(${1:\"${2:path/to/file}\"}))"},
 "ase" => 
  {scope: "source.ruby",
   name: "assert_equal(..)",
   content: 
    "assert_equal`snippet_paren.rb`${1:expected}, ${0:actual}`snippet_paren.rb end`"},
 "while" => 
  {scope: "source.ruby",
   name: "while ... end",
   content: "while ${1:condition}\n\t$0\nend"},
 "#" => {scope: "source.ruby", name: "Add ‘# =>’ Marker", content: "# => "},
 "elsif" => 
  {scope: "source.ruby",
   name: "elsif ...",
   content: "elsif ${1:condition}\n\t$0"},
 "y" => 
  {scope: "source.ruby comment",
   name: ":yields:",
   content: " :yields: ${0:arguments}"},
 "nam" => 
  {scope: "source.ruby",
   name: "namespace :.. do .. end",
   content: "namespace :${1:${TM_FILENAME/\\.\\w+//}} do\n\t$0\nend"},
 "patfh" => 
  {scope: "source.ruby",
   name: "path_from_here( .. )",
   content: "File.join(File.dirname(__FILE__), *%w[${1:rel path here}])"}}
