# Encoding: UTF-8

[{name: "Typing Pairs: Block Opening",
  scope: "keyword.control.start-block.ruby, meta.syntax.ruby.start-block",
  settings: 
   {smartTypingPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["|", "|"]]},
  uuid: "6D75102B-6E51-4360-8F12-BE12327B6AE6"},
 {name: "Indent",
  scope: "source.ruby",
  settings: 
   {decreaseIndentPattern: 
     "^\\s*([}\\]]\\s*$|(end|rescue|ensure|else|elsif|when)\\b)",
    increaseIndentPattern: 
     "(?x)^\n    (\\s*\n        (module|class|def\n        |unless|if|else|elsif\n        |case|when\n        |begin|rescue|ensure\n        |for|while|until\n        |(?= .*? \\b(do|begin|case|if|unless)\\b )\n         # the look-ahead above is to quickly discard non-candidates\n         (  \"(\\\\.|[^\\\\\"])*+\"        # eat a double quoted string\n         | '(\\\\.|[^\\\\'])*+'      # eat a single quoted string\n         |   [^#\"']                # eat all but comments and strings\n         )*\n         (                         \\s   (do|begin|case)\n         | [-+=&|*/~%^<>~](?<!\\$.) \\s*+ (if|unless)\n         )\n        )\\b\n        (?! [^;]*+ ; .*? \\bend\\b )\n    |(  \"(\\\\.|[^\\\\\"])*+\"            # eat a double quoted string\n     | '(\\\\.|[^\\\\'])*+'          # eat a single quoted string\n     |   [^#\"']                    # eat all but comments and strings\n     )*\n     ( \\{ (?!  [^}]*+ \\} )\n     | \\[ (?! [^\\]]*+ \\] )\n     )\n    ).*$"},
  uuid: "6FEAF60F-F0F3-4618-9259-DE93285F50D1"},
 {name: "Symbol List: Method",
  scope: "source.ruby meta.function",
  settings: {showInSymbolList: 1, symbolTransformation: "s/^\\s*def\\s+/ /"},
  uuid: "92E190C9-A861-4025-92D4-D6B5A24C22D4"},
 {name: "Comments",
  scope: "source.ruby",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "# "},
      {name: "TM_COMMENT_START_2", value: "=begin\n"},
      {name: "TM_COMMENT_END_2", value: "=end\n"}]},
  uuid: "1D26F26C-C6F7-434F-84F8-FEE895372E8A"},
 {name: "Completion: require strings",
  scope: "meta.require.ruby string.quoted",
  settings: 
   {completionCommand: 
     "#!/usr/bin/env ruby\n\t\tptrn = /^\#{Regexp.escape ENV[\"TM_CURRENT_WORD\"].to_s}[^.]+\\..+/\n\t\tputs( $LOAD_PATH.inject([]) do |res, path|\n\t\tres << Dir.new(path).grep(ptrn) { |file| file[/^[^.]+/] } if File.exists?(path)\n\t\tres\n\t\tend.sort.uniq )"},
  uuid: "AEDD6A5F-417F-4177-8589-B07518ACA9DE"},
 {name: "Completion: ENV[…] variables",
  scope: "meta.environment-variable.ruby string.quoted",
  settings: 
   {completionCommand: "env|grep \"^$TM_CURRENT_WORD\"|sort|cut -d= -f1"},
  uuid: "1A7701FA-D866-498C-AD4C-7846538DB535"},
 {name: "Symbol List: No Function Call",
  scope: "source.ruby meta.function-call entity.name.function",
  settings: {showInSymbolList: 0},
  uuid: "A5D50494-EB97-48DE-A2BE-322DF52A7A7A"}]
