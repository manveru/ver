# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nline = STDIN.read\nTAB = line.match(/^(\\s+)/).to_s\n\n# first check to see if we have a\n# key on the current line, if so indent\nif ENV['TM_CURRENT_LINE'].match /^\\s*.+:/\n  $stdout.write \"\#{line}\\n\#{TAB}\\t- \" \n\n# then to see if it's a one-liner list item,\n# in which case we don't indent\nelsif ENV['TM_CURRENT_LINE'].match /^\\s*- /\n  $stdout.write \"\#{line}\\n\#{TAB}- \"\n\n# otherwise back up indent\nelse \n  $stdout.write \"\#{line}\\n\#{TAB[(0..-3)]}- \"\nend\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "",
  name: "Add list item",
  output: "insertAsSnippet",
  scope: "source.yaml",
  uuid: "037242FC-9D77-46A6-94B8-865052595B5A"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nrequire \"yaml\"\nrequire \"pp\"\n\nputs \"#!/usr/bin/env ruby\\n\\n\"\nprint \"documents = \"\npp(YAML.load_stream(STDIN).documents)",
  input: "selection",
  keyEquivalent: "^H",
  name: "Convert Document / Selection to Ruby",
  output: "openAsNewDocument",
  scope: "source.yaml",
  uuid: "D73CBC77-1692-4981-8C3E-6DCE63F6E2E2"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nprint (s = STDIN.read).split(/^\#{indent = s.scan(/^(\\s*)\\b/).flatten.first}(?=\\w)/).sort.join(indent)",
  input: "selection",
  keyEquivalent: "",
  name: "Sort Keys Alphabetically",
  output: "replaceSelectedText",
  scope: "source.yaml",
  uuid: "331791FA-7335-45B9-865E-760D52294D01"},
 {beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"YAML Reference Card\" \"YAML\"\nMarkdown.pl <<'EOF'\n\n<title>YAML Reference Card</title>\n\n\t  Collection indicators:\n\t      '? ' : Key indicator.\n\t      ': ' : Value indicator.\n\t      '- ' : Nested series entry indicator.\n\t      ', ' : Separate in-line branch entries.\n\t      '[]' : Surround in-line series branch.\n\t      '{}' : Surround in-line keyed branch.\n\t  Scalar indicators:\n\t      '''' : Surround in-line unescaped scalar ('' escaped ').\n\t      '\"'  : Surround in-line escaped scalar (see escape codes below).\n\t      '|'  : Block scalar indicator.\n\t      '>'  : Folded scalar indicator.\n\t      '-'  : Strip chomp modifier ('|-' or '>-').\n\t      '+'  : Keep chomp modifier ('|+' or '>+').\n\t      1-9  : Explicit indentation modifier ('|1' or '>2').\n\t             # Modifiers can be combined ('|2-', '>+1').\n\t  Alias indicators:\n\t      '&'  : Anchor property.\n\t      '*'  : Alias indicator.\n\t  Tag property: # Usually unspecified.\n\t      none    : Unspecified tag (automatically resolved by application).\n\t      '!'     : Non-specific tag (by default, \"!!map\"/\"!!seq\"/\"!!str\").\n\t      '!foo'  : Primary (by convention, means a local \"!foo\" tag).\n\t      '!!foo' : Secondary (by convention, means \"tag:yaml.org,2002:foo\").\n\t      '!h!foo': Requires \"%TAG !h! <prefix>\" (and then means \"<prefix>foo\").\n\t      '!<foo>': Verbatim tag (always means \"foo\").\n\t  Document indicators:\n\t      '%'  : Directive indicator.\n\t      '---': Document header.\n\t      '...': Document terminator.\n\t  Misc indicators:\n\t      ' #' : Throwaway comment indicator.\n\t      '`@' : Both reserved for future use.\n\t  Special keys:\n\t      '='  : Default \"value\" mapping key.\n\t      '<<' : Merge keys from another mapping.\n\t  Core types: # Default automatic tags.\n\t      '!!map' : { Hash table, dictionary, mapping }\n\t      '!!seq' : { List, array, tuple, vector, sequence }\n\t      '!!str' : Unicode string\n\t  More types:\n\t      '!!set' : { cherries, plums, apples }\n\t      '!!omap': [ one: 1, two: 2 ]\n\t  Language Independent Scalar types:\n\t      { ~, null }              : Null (no value).\n\t      [ 1234, 0x4D2, 02333 ]   : [ Decimal int, Hexadecimal int, Octal int ]\n\t      [ 1_230.15, 12.3015e+02 ]: [ Fixed float, Exponential float ]\n\t      [ .inf, -.Inf, .NAN ]    : [ Infinity (float), Negative, Not a number ]\n\t      { Y, true, Yes, ON  }    : Boolean true\n\t      { n, FALSE, No, off }    : Boolean false\n\t      ? !!binary >\n\t          R0lG...BADS=\n\t      : >-\n\t          Base 64 binary value.\n\t  Escape codes:\n\t   Numeric   : { \"\\x12\": 8-bit, \"\\u1234\": 16-bit, \"\\U00102030\": 32-bit }\n\t   Protective: { \"\\\\\": '\\', \"\\\"\": '\"', \"\\ \": ' ', \"\\<TAB>\": TAB }\n\t   C         : { \"\\0\": NUL, \"\\a\": BEL, \"\\b\": BS, \"\\f\": FF, \"\\n\": LF,\n\t                 \"\\r\": CR, \"\\t\": TAB, \"\\v\": VTAB }\n\t   Additional: { \"\\e\": ESC, \"\\_\": NBSP, \"\\N\": NEL, \"\\L\": LS, \"\\P\": PS }\nEOF\nhtml_footer\n",
  input: "none",
  keyEquivalent: "^h",
  name: "Syntax Cheat Sheet",
  output: "showAsHTML",
  scope: "source.yaml",
  uuid: "52CDBDBC-91B6-40DD-852A-C92D7D15D6F5"}]
