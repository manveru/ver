# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nif ENV['TM_CURRENT_LINE'] =~ /^\\s*[\\w.]+\\s*=\\s*(\\d+)\\s*[,;]?\\s*$/\n\tidx = $1.to_i + 1\nelse\n\tidx = 1\nend\n\nif ENV['TM_CURRENT_LINE'] =~ /^\\s+/\n  indent = ''\nelse\n  indent = \"\\t\"\nend\n\nputs\nprint \"\#{indent}${1:FIELD} = ${2:\#{idx}},$0\"\n",
  fallbackInput: "line",
  input: "none",
  name: "enum field",
  output: "insertAsSnippet",
  scope: "meta.enum.thrift",
  uuid: "841E598E-C872-4A98-A4D5-F13272F51B6F"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\n# this command is intended to be used to generate the struct field macro\n# the struct field macro is ^E followed by this command.\n\ni = 1\nif ENV['TM_CURRENT_LINE'] =~ /^\\s*(\\d+):/\n\ti = $1.to_i + 1\nend\n\nindent = ''\nif ENV['TM_CURRENT_LINE'] !~ /^\\s+/\n  indent = \"\\t\"\nend\n\nputs\nprint \"\#{indent}${1:\#{i}}${1/.+/: /m}${2:i32} ${3:field}${4/.+/ = /m}${4:value},$0\"\n",
  fallbackInput: "line",
  input: "none",
  name: "struct field",
  output: "insertAsSnippet",
  scope: "meta.struct.thrift, meta.exception.thrift",
  uuid: "9240E318-0643-4BF7-8EBA-DD947C8CB7B9"}]
