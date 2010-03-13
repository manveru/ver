# Encoding: UTF-8

{comment: 
  "Go allows any Unicode character to be used in identifiers, so our identifier regex is: \\b([[:alpha:]_]+[[:alnum:]_]*)\\b",
 fileTypes: ["go"],
 firstLineMatch: "-[*]-( Mode:)? Go -[*]-",
 foldingStartMarker: 
  /(?x)
          \/\*\*(?!\*)                           # opening C-style comment with 2 asterisks but no third later on
         |                                      # OR
          ^                                     # start of line...
           (?!                                  # ...which does NOT contain...
              [^{(?<_1>]*?\/\/                         #    ...a possible bunch of non-opening-braces, followed by a C++ comment
             |                                  #    OR
              [^{(?<_2>]*?\/\*(?!.*?\*\/.*?[{(?<_3>])       #    ...a possible bunch of non-opening-braces, followed by a C comment with no ending
           )
           .*?                                  # ...any characters (?<_4>or none)...
           [{(?<_5>]\s*                              # ...followed by an open brace and zero or more whitespace...
           (?<_6>                                    # ...followed by...
            $                                   #    ...a dollar...
             |                                  #    OR
            \/\/                                  #    ...a C++ comment...
             |                                  #    OR
            \/\*(?!.*?\*\/.*\S)                   #    ...a C comment, so long as no non-whitespace chars follow it..
           )
    /,
 foldingStopMarker: /(?<!\*)\*\*\/|^\s*[})]/,
 keyEquivalent: "^~G",
 name: "Go",
 patterns: 
  [{include: "#receiver_function_declaration"},
   {include: "#plain_function_declaration"},
   {include: "#basic_things"},
   {include: "#exported_variables"},
   {begin: /^[[:blank:]]*(?<_1>import)\b\s+/,
    beginCaptures: {1 => {name: "keyword.control.import.go"}},
    end: "(?=(?://|/\\*))|$",
    name: "meta.preprocessor.go.import",
    patterns: 
     [{begin: /"/,
       beginCaptures: {0 => {name: "punctuation.definition.string.begin.go"}},
       end: "\"",
       endCaptures: {0 => {name: "punctuation.definition.string.end.go"}},
       name: "string.quoted.double.import.go"}]},
   {include: "#block"},
   {include: "#root_parens"},
   {include: "#function_calls"}],
 repository: 
  {access: 
    {match: /(?<=\.)[[:alpha:]_][[:alnum:]_]*\b(?!\s*\()/,
     name: "variable.other.dot-access.go"},
   basic_things: 
    {patterns: 
      [{include: "#comments"},
       {include: "#initializers"},
       {include: "#access"},
       {include: "#strings"},
       {include: "#keywords"}]},
   block: 
    {begin: /\{/,
     end: "\\}",
     name: "meta.block.go",
     patterns: [{include: "#block_innards"}]},
   block_innards: 
    {patterns: 
      [{include: "#function_block_innards"},
       {include: "#exported_variables"}]},
   comments: 
    {patterns: 
      [{captures: {1 => {name: "meta.toc-list.banner.block.go"}},
        match: /^\/\* =(?<_1>\s*.*?)\s*= \*\/$\n?/,
        name: "comment.block.go"},
       {begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.go"}},
        end: "\\*/",
        name: "comment.block.go"},
       {match: /\*\/.*\n/, name: "invalid.illegal.stray-commend-end.go"},
       {captures: {1 => {name: "meta.toc-list.banner.line.go"}},
        match: /^\/\/ =(?<_1>\s*.*?)\s*=\s*$\n?/,
        name: "comment.line.double-slash.banner.go"},
       {begin: /\/\//,
        beginCaptures: {0 => {name: "punctuation.definition.comment.go"}},
        end: "$\\n?",
        name: "comment.line.double-slash.go",
        patterns: 
         [{match: /(?>\\\s*\n)/,
           name: "punctuation.separator.continuation.go"}]}]},
   exported_variables: 
    {comment: 
      "This is kinda hacky, in order to get the 'var' scoped the right way again.",
     match: /(?<=\s|\[\])(?<_1>[[:upper:]][[:alnum:]_]*)(?=\W+)/,
     name: "variable.exported.go"},
   fn_parens: 
    {begin: /\(/,
     end: "\\)",
     name: "meta.parens.go",
     patterns: [{include: "#basic_things"}, {include: "#function_calls"}]},
   function_block: 
    {begin: /\{/,
     end: "\\}",
     name: "meta.block.go",
     patterns: [{include: "#function_block_innards"}]},
   function_block_innards: 
    {patterns: 
      [{include: "#basic_things"},
       {captures: 
         {1 => {name: "punctuation.whitespace.support.function.leading.go"},
          2 => {name: "support.function.builtin.go"}},
        match: 
         /(?<_1>\s*)\b(?<_2>new|c(?<_3>lose(?<_4>d)?|ap)|p(?<_5>anic(?<_6>ln)?|rint(?<_7>ln)?)|len|make)(?:\b|\()/},
       {include: "#function_block"},
       {include: "#function_calls"},
       {include: "#fn_parens"}]},
   function_calls: 
    {captures: 
      {1 => {name: "punctuation.whitespace.function-call.leading.go"},
       2 => {name: "support.function.any-method.go"},
       3 => {name: "punctuation.definition.parameters.go"}},
     match: 
      /(?x)
                (?: (?= \s ) (?:(?<=else|new|return) | (?<!\w)) (?<_1>\s+) )?
                (?<_2>\b
                    (?!(?<_3>for|if|else|switch|return)\s*\()
                    (?:[[:alpha:]_][[:alnum:]_]*+\b)            # method name
                )
                \s*(?<_4>\()
            /,
     name: "meta.function-call.go"},
   initializers: 
    {patterns: 
      [{captures: 
         {0 => {name: "variable.other.go"}, 1 => {name: "keyword.control.go"}},
        comment: 
         "This matches the 'var x int = 0' style of variable declaration.",
        match: 
         /^[[:blank:]]*(?<_1>var)\s+(?:[[:alpha:]_][[:alnum:]_]*)(?:,\s+[[:alpha:]_][[:alnum:]_]*)*/,
        name: "meta.initialization.explicit.go"},
       {captures: 
         {0 => {name: "variable.other.go"},
          1 => {name: "keyword.operator.initialize.go"}},
        comment: "This matches the 'x := 0' style of variable declaration.",
        match: 
         /(?:[[:alpha:]_][[:alnum:]_]*)(?:,\s+[[:alpha:]_][[:alnum:]_]*)*\s*(?<_1>:=)/,
        name: "meta.initialization.short.go"}]},
   keywords: 
    {patterns: 
      [{match: 
         /\b(?<_1>s(?<_2>truct|elect|witch)|c(?<_3>ontinue|ase)|type|i(?<_4>nterface|f|mport)|def(?<_5>er|ault)|package|else|var|f(?<_6>or|unc|allthrough)|r(?<_7>eturn|ange)|go(?<_8>to)?|map|break)\b/,
        name: "keyword.control.go"},
       {match: 
         /(?<_1>\b|(?<=\]))(?<_2>int(?<_3>16|8|32|64)?|uint(?<_4>16|8|32|ptr|64)?|float(?<_5>32|64)?|b(?<_6>yte|ool)|string)\b/,
        name: "storage.type.go"},
       {match: /\b(?<_1>const|chan)\b/, name: "storage.modifier.go"},
       {match: /\b(?<_1>nil|true|false|iota)\b/, name: "constant.language.go"},
       {match: 
         /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)\b/,
        name: "constant.numeric.go"},
       {match: /(?<_1>\<\-)|(?<_2>\-\>)/,
        name: "support.channel-operator.go"}]},
   plain_function_declaration: 
    {begin: 
      /(?x)
    	            ^[[:blank:]]*(?<_1>func)\s*
    	            (?: (?<_2>[[:alpha:]_][[:alnum:]_]*)? )          # name of function is optional
    	            (?: \( (?<_3>(?:[\[\]\w\d\s\/,._*&<>-]|(?:interface\{\}))*)? \) )             # required braces for parameters (?<_4>even if empty)
    	            \s*
    	            (?: \(? (?<_5>(?:[\[\]\w\d\s,._*&<>-]|(?:interface\{\}))*) \)? )?             # optional return types, optionally within braces
    	    /,
     beginCaptures: 
      {1 => {name: "keyword.control.go"},
       2 => {name: "entity.name.function.go"},
       3 => {name: "variable.parameters.go"},
       4 => {name: "variable.return-types.go"}},
     end: "(?<=\\})",
     name: "meta.function.plain.go",
     patterns: 
      [{include: "#comments"},
       {include: "#storage_type"},
       {include: "#storage_modifier"},
       {include: "#function_block"}]},
   receiver_function_declaration: 
    {begin: 
      /(?x)
    	            (?<_1>func)\s*
    	            (?: \( (?<_2>(?:[\[\]\w\d\s,._*&<>-]|(?:interface\{\}))*) \)\s+ )                # receiver variable declarations, in brackets
    	            (?: (?<_3>[[:alpha:]_][[:alnum:]_]*)? )          # name of function is optional
    	            (?: \( (?<_4>(?:[\[\]\w\d\s,._*&<>-]|(?:interface\{\}))*)? \) )               # required braces for parameters (?<_5>even if empty)
    	            \s*
    	            (?: \(? (?<_6>(?:[\[\]\w\d\s,._*&<>-]|(?:interface\{\}))*) \)? )?             # optional return types, optionally within braces
    	    /,
     beginCaptures: 
      {1 => {name: "keyword.control.go"},
       2 => {name: "variable.receiver.go"},
       3 => {name: "entity.name.function.go"},
       4 => {name: "variable.parameters.go"},
       5 => {name: "variable.return-types.go"}},
     comment: 
      "Version of above with support for declaring a receiver variable.",
     end: "(?<=\\})",
     name: "meta.function.receiver.go",
     patterns: 
      [{include: "#comments"},
       {include: "#storage_type"},
       {include: "#storage_modifier"},
       {include: "#function_block"}]},
   root_parens: 
    {begin: /\(/,
     end: "(?<=\\()(\\))?|(?:\\))",
     endCaptures: {1 => {name: "meta.parens.empty.go"}},
     name: "meta.parens.go",
     patterns: 
      [{include: "#basic_things"},
       {include: "#exported_variables"},
       {include: "#function_calls"}]},
   string_escaped_char: 
    {patterns: 
      [{match: 
         /\\(?<_1>\\|[abfnrutv'"]|x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|U[0-9a-fA-F]{8}|[0-7]{3})/,
        name: "constant.character.escape.go"},
       {match: /\\./, name: "invalid.illegal.unknown-escape.go"}]},
   string_placeholder: 
    {patterns: 
      [{match: 
         /(?x)%
                        (?<_1>\d+\$)?                                    # field (?<_2>argument #)
                        [#0\- +']*                                  # flags
                        [,;:_]?                                     # separator character (?<_3>AltiVec)
                        (?<_4>(?<_5>-?\d+)|\*(?<_6>-?\d+\$)?)?                     # minimum field width
                        (?<_7>\.(?<_8>(?<_9>-?\d+)|\*(?<_10>-?\d+\$)?)?)?                # precision
                        [diouxXDOUeEfFgGaAcCsSpnvtTbyYhHmMzZ%]      # conversion type
                    /,
        name: "constant.other.placeholder.go"},
       {match: /%/, name: "invalid.illegal.placeholder.go"}]},
   strings: 
    {patterns: 
      [{begin: /"/,
        beginCaptures: {0 => {name: "punctuation.definition.string.begin.go"}},
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.go"}},
        name: "string.quoted.double.go",
        patterns: 
         [{include: "#string_placeholder"},
          {include: "#string_escaped_char"}]},
       {begin: /'/,
        beginCaptures: {0 => {name: "punctuation.definition.string.begin.go"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.go"}},
        name: "string.quoted.single.go",
        patterns: [{include: "#string_escaped_char"}]},
       {begin: /`/,
        beginCaptures: {0 => {name: "punctuation.definition.string.begin.go"}},
        end: "`",
        endCaptures: {0 => {name: "punctuation.definition.string.end.go"}},
        name: "string.quoted.raw.go"}]}},
 scopeName: "source.go",
 uuid: "33100200-8916-4F78-8522-4362628C6889"}
